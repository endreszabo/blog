---
title: "VTI Tunnel Interface with strongSwan"
postcode: EBP002
external-url:
date: 2016-03-28T00:00:00
lastmod: 2016-08-18T00:00:00
slug: "ebp002-vti-tunnel-interface-with-strongswan"
categories:
  - tutorial
tags: 
  - ipsec
meta:
    docclass: "Proof of Concept"
    code: epc001
    gtoc: false
    gnotoc: true
    indexImage: strongswanlogo.png
---

I successfully managed to get Linux VTI (Virtual Tunnel Interface) working with strongSwan. By using VTI it is no longer needed to rely on the routing policy database, making understanding and maintaining routes easier. Also with VTI you can see the cleartext traffic on the VTI interface itself. It was confusing to see actual tunnel traffic before using `tcpdump` using the standard policy database setup. (There are `ulog`/`nflog` hacks to see cleartext traffic in both direction though, similar to BSD `pflog`.)<!--more-->

With policy database strongSwan installs its learned policy routes to a separate routing table having preference over the main routing table. strongSwan does not support native VTI setup so a `<left|right>updown` script is needed to setup the tunnel this way.

So far the `/usr/local/sbin/ipsec-notify.sh` file looks like this:

```sh
#!/bin/bash

set -o nounset
set -o errexit

VTI_IF="vti${PLUTO_UNIQUEID}"

case "${PLUTO_VERB}" in
    up-client)
        ip tunnel add "${VTI_IF}" mode vti \
			local "${PLUTO_ME}" remote "${PLUTO_PEER}" \
            okey "${PLUTO_MARK_OUT%%/*}" ikey "${PLUTO_MARK_IN%%/*}"
        ip link set "${VTI_IF}" up
        ip addr add ${PLUTO_MY_SOURCEIP} dev "${VTI_IF}"
        ip route add <tunneled-network> dev "${VTI_IF}"
        sysctl -w "net.ipv4.conf.${VTI_IF}.disable_policy=1"
        ;;
    down-client)
        ip tunnel del "${VTI_IF}"
        ;;
esac

```

and the relevant part of `/etc/ipsec.conf` looks like this (without authentication method details):

```python
conn <vpngw>
    leftupdown=/usr/local/sbin/ipsec-notify.sh
    left=%defaultroute
    leftsourceip=%config4,%config6
    rightsubnet=0.0.0.0/0,::/0
    right=<vpngw_ip>
    rightid=<vpngw_id>
    auto=route
    mark=2

```

In `/etc/strongswan.d/charon.conf` uncomment `install_routes` and `install_virtual_ip` properties and change their value to `no`:

```sh
# Install routes into a separate routing table for established IPSec tunnels.
install_routes = no

# Install virtual IP addresses.
install_virtual_ip = no

```

##### Update 

Thermi has turned this blog post and other related informations into a [strongSwan wiki entry](https://wiki.strongswan.org/projects/strongswan/wiki/RouteBasedVPN). Please be sure to check that out too.
