---
title: remotely upgrading openwrt -- failure is imminent
date: 2010/09/21 15:45:00
tags: openwrt
categories: floss
---
Az a kövérke ``segfault`` az update folyamat közepén nem sok fényes jövőt jósol a távoli upgradenek.

::

    Writing from <stdin>; to kernel ...

    Writing from <stdin>; to rootfs ...
    Appending jffs2 data from /tmp/sysupgrade.tgz to rootfs...
    Updating FIS table...
    Segmentation fault
    Upgrade completed
    Reboot (Y/n):

persze az update + reboot után *missing in action* a cucc :(

