---
title: "Applied strongSwanism"
date: 2016-08-10T00:00:00
postcode: ett001
comments: true
slug: "ett001_applied-strongswanism"
categories:
  - tutorial
tags:
  - ipsec
  - strongswan
Params:
    code: ett001
    docclass: tutorial
headerimage: "/images/world-1264062_1280.jpg"
---
Being on strongSwan IRC support channel at freenode for quite a period I see somewhat general configuration question repeatedly asked. I decided to make a series of posts to help people configure strongSwan for some very tipical usage scenarios. This will include site&ndash;to&ndash;site (where two Linux instances run strongSwan) and client&ndash;server (desktop and mobie clients using secure VPN) connections. I wouldn't call myself an in-depth expert on the topic but I've dealt with various IPSec setups involving openswan, strongSwan, cisco ASA appliances and the like.<!--more-->

Among the most common I see people asking for help in subjects as:

- native Windows 7 as a client with IKEv2 based connections, server side X509 certificate attribute requirements,
- Android and (P)EAP authentication, and especially X509 certificate issues,
- General RADIUS questions, who connectes to who,
- "PSK is probably not correct."

With my quite well developed home setup I more-or-less cover these areas, so I write this post intruduce my setup in a way that would resemble as a tutorial. Protip: *I will not use and will not mention the by design defective preshared key (PSK) authentication at all.* Don't use PSK. It's not the 90's PPTP VPN era after all. Period.

I plan this to write this tutorial in a single huge, so here to be a not-so-accurate progress TOC with links coming alive as soon as I finish the relevant posts:

	[x] Definitions
	[x] Prerequisites
	[x] Creating X509 Certificates
	[x] Config tree description
	[x] First host to host connection with certificates

But first I think there is a need for clarification on IPSec related definitions.

## <a name="def"></a>1. Definitions

- **IPSec**: a collection name that covers a subset of standards of protocols for encrypted IP communication.

- **IKE**: it is the protocol standard that IKE daemons (like strongSwan in user-space) use for authentication and negotiation of ESP security parameters.

- **ESP**: it is an encapsulation protocol that carries the encrypted payload. It is processed in kernel-space.

As this writing aims to be a practical guidance I will not cover additional terms like low-level cryptographic primitives, transport/tunnel modes.

## 2. Prerequisites

To establish an IPSec connection we need two peer hosts. Server and client roles are generally not distinguished. At home I've got a server that runs Arch Linux with the latest strongSwan. My clients are Android smartphones, other Arch Linuxes and occasionally Windows clients.

Let's say you've got a host that other hosts are going to connect to. Let's call it `vpn-server`. For our first part of tutorial we will use Arch Linux both for our server and client hosts. Later on we will move on to other platforms.

I assume that you have installed strongSwan (from AUR for example) on your hosts with default configuration files.

Among the first questions to decide is to which authentication mechanism we'd like to use.

### 2.1. X509 Certificates

During authentication we will heavely rely on X509 aka. Public Key Infrastructure (PKI) certificates and private keys. This industry standard authentication helps us ensure authenticity of hosts and symmetric encryption keys much akin to how secure web and email communication works with standard TLS.

Later on we will extend our configurations to use not only X509 certificates but username and passwords with Extensible Authentication Protocol (EAP).

So, basically we'll need to generate a keypair: a private key and a self-signed certificate with our public key in it. This keypair is what is called a Certificate Authority (CA) certificate and private key. It will be needed for us to issue further, trusted certificates. Our hosts will testify the authenticity of connecting peers using this CA certificate.

Fortunately strongSwan comes with tools that can help us dealing with certificates, so we won't have to dig elbow deep into OpenSSL configuration files and totally utter command line parameters.

To begin we'll have to generate the aforementioned keypair called CA. strongSwan main command `ipsec` can not only deal with connections and configuration buy it can do X509 stuff for us. We will use this `ipsec` command from now on.

#### Generate our CA keypair:

##### create private key

```sh
ipsec pki --gen --outform pem > ca.key
```

##### create self signed certificate with public key embedded

As terms certificate and public key are commonly intercharged I will stop referring to public key as public key and will refer to both as certificate. Here, in the certificate we can specify a subject, a name that will identify our strongSwan CA instance. You can name it freely, but i'd suggest to use only non-accented 7-bit ASCII characters for compatibility. In our example I will use 'end.re VPN CA'. Certificates usually have a lifetime, and expiration date after it will not be valid. I will create our CA certificate with 10 years of validity period. Enough long to migrate from in the future.

```sh
ipsec pki --self --in ca.key \
    --lifetime 3650 --dn "CN=end.re VPN CA" \
    --ca --outform pem > ca.pem
```

This CA keypair is only useful to create (sign) further keypairs that our hosts can use for authentication against this CA. The private key is in the `ca.key` file and the public key (within the certificate) is in the `ca.pem` file.

#### Generate keypair for our VPN server

With this keypair to be created the server can authenticate itself to client connecting to it. We need to generate a private key the same way we created for the CA:

```sh
ipsec pki --gen --outform pem > vpn-server.key
```

And now we need to generate the certificate using the CA keypair:

```sh
ipsec pki --pub --in vpn-server.key -- | \
	ipsec pki --issue --cacert ca.pem --cakey ca.key \
	--dn "CN=vpn-server" --outform pem > vpn-server.pem
```

#### Generate keypair for our first client

With this keypair to be created our client can authenticate itself to the server connecting to it. The server and the client both authenticate each other against the trusted CA. This is called mutual authentication. This is how the random bad guest kept out from the server.

```sh
ipsec pki --gen --outform pem > vpn-server.key
```

And now we need to generate the certificate using the CA keypair:

```sh
ipsec pki --pub --in vpn-server.key -- | \
	ipsec pki --issue --cacert ca.pem --cakey ca.key \
	--dn "CN=vpn-server" --outform pem > vpn-server.pem
```

## 3. strongSwan configuration directory tree

Now it's the very time to introduce the location of strongSwan configuration files, certficiates and keys.

strongSwan package installs configuration files into /etc. The main configuration files and directories are:

- `/etc/ipsec.conf`: classic IPsec connection related configuration parameters
- `/etc/ipsec.d/`: location of CA and host certificates

### 3.1. /etc/ipsec.d

This directory contains (among others) X509 certificates. In here there are also subdirectories, the following are important to us now:

#### /etc/ipsec.d/cacerts/

This directory holds the ca.pem file. Do not place the private key file called ca.key here. Because it's private to the CA itself and has nothing to do on the VPN server.

#### /etc/ipsec.d/certs/

This directory holds one or more of the certficiates that is used to authenticate this host to other peers. Right now we will place the vpn-server.pem to this directory.

#### /etc/ipsec.d/private/

This directory is for the private keys. The host needs to do cryptographic processing during the authentication and this host-bound private key is needed for the host to be able to prove it's identity. We will place the vpn-server.key to this directory.

### 3.2. /etc/ipsec.conf

This file defines our connections to and from other peers. It holds all the IP addresses, keypair references, encryption algorithm specifications to be used upon connecting or when accepting a connection.


