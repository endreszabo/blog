---
tags:
  - networking
categories:
  - Proof of Concept
params:
  hideTitle: false
  hideMeta: false
  hideComments: false
  hideTOC: true
  hideNav: false
  hideLicenceButton: false
  hideFooterNote: false
  hideHeader: false
  indexImage: wifiethernet4.png
  indexImagePercent: 20
  importHighlight: false
  importAsciinema: false
  postcode: EBP001
slug: "ebp001_wifi-ethernet-bonding"
aliases: ['/ebp001/', '2015-07-09_wifi-ethernet-bonding.html']
Title: "WiFi + Ethernet bonding"
Date: "2010-05-24T00:00:00"
lastmod: "2010-07-24T00:00:00"
---

When I'm at home, I *dislike* undocking my laptop to move around the house because of the Ethernet-to-WiFi switchover takes long seconds and all my TCP sessions like SSH get lost. It's because my laptop is assigned a different IP address on WiFi and on the wired network even if they belong to the same VLAN. Well, it looks like this is not the case any more.<!--more-->

## The solution

Today I was thinking of bonding, a stuff used to do failover/loadbalancing on wired ethernet interfaces, commonly used in the enterprise. It can do all sort of standardized stuff like 802.3ad/LACP, broadcasting, 4 different kind of loadbalancing---in this scenario I need only the so called "Active-backup policy". That is, only one interface is active at a time, where the wired Ethernet is the preferred. There is no special config need on the network rig, but it's effective **if and only if** the wired connection and the wireless ESSID belong to the same layer 2 network segment.

## Proof of concept

In [this video](https://vimeo.com/41582323) I demonstrate the setup in use, where a bond0 interface is active on the primary wired eth0 that fails over to wlan0 upon disconnection of the wired ethernet cable. The failover (and failback) happens amazlingly fast, virtually no interrupt can be observed as you can see in this video:

<center><iframe style="border:0px solid #ccc" src="http://player.vimeo.com/video/41582323?title=1&amp;byline=0&amp;portrait=0&amp;color=f2f2f2" width="100%" height="400" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe><br />Wifi-Ethernet bonding convergence in action</center>

## Integration into the everydays

I use [wicd](http://wicd.sourceforge.net/) to manage my wireless connections. A sad thing is that it doesn't support this much weird setup at all. There was a [thread](http://wicd.sourceforge.net/punbb/viewtopic.php?id=480) (called Wireless and Wired) on the official forum, one of the developers told

> I would expect it to be very distant in the future, if ever.
 
I don't know either if there is any other network/connection manager out there to support this. Even worse, wicd is apparently abandoned: they closed down their forums due to spam bots, and there's no reaction from developers on the official freenode IRC `#wicd` channel either.  Altough wicd source looks fairly easy to modify, I guess I will stick to my handmade 'init' scripts to do bonding and wpa_supplicant configuration.

Anyway, this is what should be done in wicd one day:

A GUI/TUI item needed to configure bonding interface, thus a `-b bond0` parameter could be used for `wpa_supplicant` and DHCP client daemons need to bind on `bond0` interface itself instead of the physical slave devices. 
**Update:** later on after days of debugging it became clear that 802.1x wireless authentication will be highly unstable (continuous authentication failures/timeouts every 3 minutes) using this bonded setup, even if `wpa_supplicant` is told do bind on the `bond0` interface.

## Extending it to the mobile broadband?

It is not possible using standard Linux bonding due to the very different kind of interfaces (Ethernet vs PPP), instead one could use IPSec *with* MOBIKE for nearly seamless inter-network roaming. I will go on further rambling on this later.

