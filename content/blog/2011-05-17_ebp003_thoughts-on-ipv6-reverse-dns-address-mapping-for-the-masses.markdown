---
title: "Thoughts on IPv6 Reverse DNS Address Mapping for the masses"
date: 2011-05-17T18:29:00
slug: "ebp003_thoughts-on-ipv6-reverse-dns-address-mapping-for-the-masses.html"
categories:
  - Half Baked Ideas
tags:
  - dns
aliases: ['/ebp003/']
params:
  hideTitle: false
  hideMeta: false
  hideComments: false
  hideTOC: true
  hideNav: false
  hideLicenceButton: false
  hideFooterNote: false
  hideHeader: false
#  indexImage: bridge.jpg
#  indexImagePercent: 20
  importHighlight: true
#  importAsciinema: true
  postcode: EBP003
---

Reverse DNS records are good for you. Especially if you run your own SMTP MTAs. Without proper reverse-forward DNS record mapping, some nice anomalies may appear for you. You may have faced the fact some other MTAs shut down your incoming connection for no particular reason. OpenSSH daemon also has the option to check if your forward and reverse DNS entries match. Also, being on IRC with only an IP address is so 90's ;)

<!--more-->

In the IPv4 times we had relatively small subnets where we could easily set up reverse reocrds for our hosts. However, with IPv6 we now have plenty addresses available so dealing manually with the records is not the way to go.

A Hungarian telco, Magyar Telecom, provides IPv6 access pilot for home users via ADSL PPPoE, delegating them /56 subnets upon request. Many tunnel brokers let you use your own nameservers for reverse PTR records for the delegated subnets. This is not the case with Telekom, they serve the reverse records for each and every IP address that belong to the delegated subnets. They have chosen the representation of non-compressed ipv6 addresses without the colon separator (20014C48010002D3D80C3CA1F161E842.access.pool.telekom.hu). DIGI, another company in Hungary service area is providing IPv6 access that has dynamic v6 reverse servers for their customers. DIGI has became a SixXS PoP with two nodes and also has an IPv6 pilot for customers in a chosen city. DIGI does this using two other nameservers than their main ones serving regular PTR records: ns1-dynv6.hdsnet.hu and ns2-dynv6.hdsnet.hu respectively. They represent IP addresses as they are in regular non-compressed convention but with changing colons to minus signs (2a01-0368-e002-0000-0000-0000-0000-0001.pool6.digikabel.hu). The actual solution Magyar Telekom and DIGI uses is unknown to me.

Serving this large zones obviously cannot be done with classic in-memory static zone files as it would need much, very MUCH of storage capacity just to store the records for the 2^72 address delegated for one single subscriber's connection.

## Solutions in the wild

There are a few simple yet powerful services for this issue, one of them is ip6arpa.co.cc. It only needs your reverse zones delegated to its nameserver, everything else done magically. Of course this prevents you to have custom rDNS record for your hosts. Another one is made by DJB: walldns that simply maps the IP address to the appropiate in-addr.arpa entries pretty much the same way as ip6arpa.co.cc does.

I also met this technique when I was at the 27th Chaos Communication Congress (27c3) in 2010, where the network guys set up a DNS server providing dynamic reverse (and forward) records for both the IPv4 (/16) and IPv6 (/48) subnets delegated for the congress itself. They made nice mappings looking on IRC like the following:

	muckl [~hans@node-d635ikmq0jzy23f.ipv6.congress.ccc.de] has joined #27c3
	nikNULLP0INTER [~okin@node-37k.ipv4.congress.ccc.de] has joined #27c3

Base 36 encoding of IP address is the most compact way an IP address can be represented in compliance with the according RFCs (though an [april's fool RFC](https://tools.ietf.org/html/rfc1924) is out for base 85 representation). This was more than perfect for my SOHO needs. I just needed the exact solution the guys at 27c3 were using. The authoritive name server DNS version query showed that PowerDNS was being used for this purpose.

I have heard of PowerDNS being powerful, just not thought that it is this much powerful.

So with all these informations I began to look around for ready made solutions. The first relevant match was v6rev which just does an eye-friendly reverse representation of ip addresses but not in such a compact way. Later I found a pipe backend written in C for PowerDNS which had the same limitation as v6rev had: it still need its own subdomain for the delegated zone. I find it technically awesome to have the reverse records mapped automatically right in the topmost domain.

## My approach

There were no ready to use tools having these features so I started to write my own in Perl. A prototype version worked well but it did a lot on-the-fly math with the IP addreses. Meanwhile I have found the original code that was used at 27c3 and I immediately started to enchance it to fit my needs as it also had support for IPv4 addresses with the same library they were using for IPv6. I have added the following features to the original code:

- custom prefix and postfix settings per subnet,
- best match of prefixes using radix trie,
- attribute inheritance within prefix tree (dict inheriting class included),
- automatic reverse zone calculation.

It accepts the following configuration parameters stored in a dictionary:

```python
DEFAULTS = {
    'email': 'hostmaster.example.com',
    'dns': 'ns0.example.com',
    'ttl': 300,
    'version': 6,
    'nameserver': [
        'ns0.example.com',
        'ns1.example.com'
    ]
}
```

Default are for the SOA record as well for the NS records needed to reflect the zone delegation records defined at the tunnelbroker side. Prefix delegation mapping are defined like the following (all defined values are overriding the default ones):

```python
PREFIXES = {
    netaddr.IPNetwork('2a01:270:201b::/48'):    HierDict(DEFAULTS,{'prefix': 'u', 'postfix': '-node0', 'forward': 'y7.hu',}),
    netaddr.IPNetwork('2a01:270:201b:1::/64'):  HierDict(DEFAULTS,{'prefix': 'h', 'postfix': '-vpn0-node0', 'forward': 'y7.hu',})
}
```

Example operation:

```
# dig -x 2a01:270:90bd::1 +short
u1-node0.y7.hu.
# dig -x 2a01:270:90bd:1::1 +short
h1-vpn0-node0.y7.hu.
# dig -x 2a01:270:90bd::dead:c0de +short
u1ps9xb2-node0.y7.hu.
#
# dig -t aaaa h1-vpn0-node0.y7.hu. +short
2a01:270:90bd:1::1
# dig -t aaaa usomefoobar-node0.y7.hu. +short
2a01:270:90bd:0:a:597c:761c:6333
# dig -t aaaa hsomefoobar-vpn0-node0.y7.hu. +short
2a01:270:90bd:1:a:597c:761c:6333
```

Automatically generated record can be overridden depending of the order of the launch of backends specified in the PowerDNS configuration. The forked source can be found in my github repo.
