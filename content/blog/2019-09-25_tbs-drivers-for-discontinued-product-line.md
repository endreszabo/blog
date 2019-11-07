---
tags:
  - dvb
  - tbs
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
  postcode: EBP046
slug: "ebp046_drivers-for-discontinued-tbs-dvb-product-line"
draft: true

aliases: ["/ebp046"]
Title: "Drivers for discontinued TBS DVB product line"
Date: 2019-09-25T06:12:13
---
In this post I provide you with working compiled kernel modules for [TBS Technologies](https://www.tbsdtv.com/about-us.html) discontinued DVB product line.

<!-- more -->

TBS is a major manufacturer of DVB broadcasting related devices and instruments. Among other high quality diginal broadcasting gear the also produce DVB receiver tuner card for PCs. They also officially support Linux and make driver kernel modules for their cards. However, somewhy, they never managed to get their modules in mainline kernels. Because of that poeple always need to compile these modules agains their kernel in use.

This has worked quite well for the time being, but TBS ceased to furhter update module sources for their discontinued product line. These days the latest version of the modules can not be compiled againt the current kernels and at the same time the recent binutils can not assemble a probper kernel module for the latest supported kernels. Therefore you can not make these devices work.

Until now. I am also affected. I'm here to help.

It's understandable that you want to use these devices once you paid a lot for them.

