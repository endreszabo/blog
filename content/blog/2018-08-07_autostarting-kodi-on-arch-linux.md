---
tags:
  - linux
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
  postcode: ebp041
slug: "ebp041\_autostarting-kodi-on-arch-linux-over-pxe"
draft: true

aliases: ["/ebp041"]
Title: "Auto Starting Kodi on Arch Linux Booting Over PXE"
Date: 2018-08-07T07:34:15
---

At home I have a dedicated VLAN for media and set top boxes having only internet and restricted file server access to a NAS container.

I have an old laptop to run Kodi whose HDD is to be kept intact, thus this VLAN has network booting option to fire up a Kodi instance over in case of need.

This laptop boots over the network using PXE, then using NFS root, and autostarts Kodi without any further interactivity.

Here are the steps needed if you want to reproduce the same.

## Requirements on the client side

- Wired ethernet: obviously, as most PC's can not boot over over wireless

- BIOS and NIC with network boot capability (PCs made after 2000 probably have this)

- Nothing more

## Requirements on the server side

- Arch Linux or equivalent


- nfs server package

- pacst
