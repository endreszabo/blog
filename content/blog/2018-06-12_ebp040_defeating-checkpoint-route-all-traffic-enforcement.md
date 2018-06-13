---
tags:
  - firewall
  - vpn
  - hacks
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
  indexImage: route-all-client-traffic.png
#  indexImagePercent: 20
#  importHighlight: true
#  importAsciinema: true
  postcode: EBP040
slug: "ebp040_defeating-checkpoint-route-all-traffic-enforcement"
aliases: ["/ebp040"]
Title: "Defeating CheckPoint Route-All-Traffic Enforcement"
Date: 2018-06-12T07:20:30
---

Quite a bit of the enterprises have chosen to use CheckPoint VPN solutions to allow remote access to their corporate networks. This platform is widely used and it's up to the security administrators to create the actual VPN security policies that apply to the connecting clients. Among these security rules, it's very common to enforce all of the client's traffic to go through the tunnel, be it destined to the corporate office or not, like Internet traffic that the corporation has noting to with. There is even a knowledge base entry on how to set up to [Route all traffic from Remote Access clients, including internet traffic, through Security Gateway](https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk101239). On the sad side effect, when these rules apply, it is also impossible to connect to the VPN client itself from the same subnet the client resides on. And this leads to being unable to do SSH reverse port forwards to access corporate resources from outside of this client. However, this would be really useful in my scenario, where the connecting client is a Windows VM on my ArchLinux host, and I'd like to access over-the-tunnel corporate unix hosts using the friendly and very convenient to use OpenSSH *from* the ArchLinux host and not from the Windows VM using PuTTY or something legacy dumb clients like that.

Using a netfilter rule with a trick on the ArchLinux host I managed to make easy to use transparent reverse port forwardings that also "complies" with the security enforcement rules of the VPN client.<!--more-->

The following image from the [Admin Guide](https://sc1.checkpoint.com/documents/R76/CP_R76_VPN_AdminGuide/14605.htm) describes the actual logical topology best:

{{< img src="route-all-client-traffic.png" class="center" >}}

To get out cleartext traffic of the tunnel using the Windows VM VPN, the only available option is to target the VPN remote endpoint itself. And the ArchLinux hosts sees this traffic and can act upon. Thus I set up a netfilter rule to divert the port 22 traffic going to the CheckPoint VPN endpoint to the ArchLinux interface facing the Windows VM. This way, the Windows VM successfully connects to the ArchLinux VM (in belief of connecting to the CheckPoint) and provides ArchLinux access to the corporate hosts using reverse port forwards.

For this I set up a dummy user on the ArchLinux box, having only the following SSH `authorized_keys` line:

```
restrict,port-forwarding ssh-rsa AAAAB3N[...]== Windows reverse port redirect
```

This is what the CheckPoint client thinks:

{{< img src="compliant.png" title="compliant.png" class="center arnyek" >}}

This is how PuTTY's `plink.exe` manages to establish port forwards:

{{< img src="1528807151.png" title="plink" link="" alt="how putty sees the connection on the client side" caption="" attr="" attrlink="" class="center arnyek" >}}
