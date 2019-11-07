---
tags:
  - smtp
  - spam
categories:
  - Proof of Concept
params:
#  hideTitle: true
#  hideMeta: true
#  hideComments: true
#  showTOC: true
#  hideNav: false
#  hideLicenceButton: true
#  hideFooterNote: true
#  hideHeader: true
#  indexImage: 
#  importHighlight: true
#  importAsciinema: true
  postcode: ebp043
slug: "ebp043_full-round-trip-e-mail-flow-monitoring-using-the-free-everycloud-mailflow-monitor-service"
draft: true

aliases: ["/ebpebp043"]
Title: "In the Search of the Round-Trip E-mail Flow Monitoring Service"
Date: 2019-03-20T12:21:33
---

As many of you may know I use my own full stack MX and DNS servers in order to reach the unreachable Final Ultimate Solution to the Spam Problem. My solution works very differently compared to other existing solutions and for this to work I had to implement several components from scratch. In order to completely monitor the health of my stack without further investments in terms of extra EC2 instances and for-monitoring-purposes domains I looked around for a capable 3rd party monitoring service.

I must admit that there are a lot (and by lot I mean a very LOT) of low-profile e-mail monitoring services out there with exceptionally good SEOs (==money stuffed into Google) that are just only capable doing very limited SMTP transaction results monitoring. The ones capable of full round-trip monitoring are surprisingly harder to find.

I think my monitoring requirements are quite basic:

1. ability to provide a custom address to send probe mails to
2. preferably more than one for monitoring different domains
3. preferably out of band alerting in case of outage

### MXAlerts

The first one such service I found and tried is [MXAlerts](http://mxalerts.com/). With its free account you can monitor up to 5 e-mail addresses (so called servers) for 15 days. They do not offer any out of band alerting options, so you will need an email address somewhere else that they will send alert outage emails to. Regarding OOB alerting, they only give you a link to a 3rd party site where you can purchase a list of (free?) e-mail to SMS gateways for $3. What?! After the 15 days you have the option to buy a subscription or cancel your account. One really creepy thing to me about MXAlerts is their shady company background. Positive thing I found that they lets you setup scheduled downtimes, even periodically.

### EveryCloud MailFlow

The next service I found is the [EveryCloud MailFlow Monitor Service](https://mailflow.everycloudtech.com/dashboard). This is a free service provided by EveryCloud who are really into all sort of e-mail related solutions.

*Disclaimer: this is not a sponsored blog post.*
