---
title: Wifi - Ethernet bonding
date: 2012/05/04 19:03:00
tags: linux
categories: linux
---
**The problem**

When I'm at home, I *dislike* undocking my laptop to move around the house because of the Ethernet-to-WiFi switchover takes long seconds and all my TCP sessions like SSH get lost. It's because my laptop is assigned a different IP Address on wifi and on the wired network even if they belong to the same Layer2 segment (here: VLAN). Weel, it looks like this not the case any more.

**The idea**

Today I was thinking of bonding, a stuff used to do failover/loadbalancing on wired ethernet NICes, commonly in the enterprises. It can do all sort of standardized stuff like 802.3ad/LACP, broadcasting, 4 different kind of loadbalancing---in this scenario I need only the so called "Active-backup policy". That is, only one interface is active at a time, where the wired Ethernet is the preferred. There is no special config need on the network rig, but it's effective *iff* the wired connection and the wireless ESSID belong to the same layer 2 network segment.

**My theory works like a charm**

In `this video <https://vimeo.com/41582323>`_ I demonstrate the setup in use---where a bond0 interface is active on the primary wired eth0 that fails over to wlan0 upon disconnection of the wired ethernet cable. The failover (and failback) happens amazlingly fast, virtually no interrupt can be observed.

.. raw:: html

    <center><iframe style="border:2px solid #ccc" src="http://player.vimeo.com/video/41582323?title=0&amp;byline=0&amp;portrait=0&amp;color=f2f2f2" width="500" height="331" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe><br />Wifi-Ethernet bonding convergence in action</center>

**Integration into the everydays**

I use `wicd <http://wicd.sourceforge.net/>`_ to manage my wireless connections. A sad thing is that it doesn't support this much weird setup at all. There was a `thread <http://wicd.sourceforge.net/punbb/viewtopic.php?id=480>`_ (called Wireless and Wired) on the official forum, one of the developers told 'I would expect it to be very distant in the future, if ever'. I don't know if there's any other network/connection manager to support this. Even worse, wicd is apparently abandoned: they closed down their forums due to spam bots, and there's no reaction from developers on the official freenode IRC #wicd either.  Altough wicd source looks easy to modify I guess I will stick to my handmade 'init' scripts to do bonding and wpa_supplicant configuration.

What would be needed in wicd:

A GUI/TUI item needed to configure bonding interface, thus a '-b bond0' paramtere could be used for wpa_supplicant and DHCP client daemons need to bind on bond0 instead of the physical slave devices.

**Extending it to the mobile broadband?**

It's not possible using standard Linux bonding, instead IPSec+MOBIKE could be used for seamless inter-network roaming. I'm on further rambling on this.

.. |---| unicode:: U+2014
   :trim:
