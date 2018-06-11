---
tags:
  - linux
  - zfs
categories:
  - Proof of Concept
params:
  hideTitle: false
  hideMeta: false
  hideComments: false
  hideTOC: true
  postcode: EBP036
  indexImage: archzfs.png
  indexImagePercent: 20
  importAsciinema: true
slug: "ebp036_archzfs-repo-for-kernels"
draft: true
aliases: ["/ebp036"]
Title: "ArchZFS companion repo for dependent kernel versions"
Date: 2018-05-31T21:33:58
---

As per the ArchZFS repository: ''occasionally the OpenZFS project gets behind on stable support for the latest Linux Kernel release. This means that if Linux 4.15 is released to core, but the latest stable release of OpenZFS does not support Linux 4.15, it is not possible to perform a system update. Sometimes it can take a few days, a few weeks, or a month to release a new stable version of OpenZFS''.

Based on the good ol' Gentoo memories, you might think that the package manager of this ultramodern distribution surely can handle different kernel versions installed at the same time? Unfortunately, the implementation reality of `pacman`, the package manager of ArchLinux follows a different stereotype.

See my ArchZFS-compatible kernel packages repository that offers a solution for this problem.<!--more-->

If you use ZFS on Arch Linux and wanted to upgrade your systems with your kernel, i bet you encountered the issue of actual official Arch Linux repository kernel versions can differ from the ArchZFS package expected kernel versions.

*Please note that the post below applies to the ArchZFS 'precompiled kernel modules' packages. DKMS version of ArchZFS doesn't have this issue (it has other issues)*

### The issue

As stated, this discrepancy, when happens can block the whole upgrade process unless archzfs (repo for Arch Linux ZFS port) maintainers keep up with the current kernel versions or you manually instruct pacman to neglect upgrading of the kernel packages.

This issue unfolds like to following:

First you upgrade repo db files as usual:

```sh
# pacman -Sy
:: Synchronizing package databases...
 core           129.7 KiB  12.7M/s 00:00 [----------] 100%
 extra         1620.4 KiB  26.4M/s 00:00 [----------] 100%
 community        4.4 MiB  49.1M/s 00:00 [----------] 100%
 multilib       170.8 KiB  0.00B/s 00:00 [----------] 100%
 archzfs         21.7 KiB   167K/s 00:00 [----------] 100%
 archzfs.sig    310.0   B  0.00B/s 00:00 [----------] 100%
```

And then you start the upgrade process:

```sh
# pacman -Su
:: Starting full system upgrade...
resolving dependencies...
looking for conflicting packages...
error: failed to prepare transaction (could not satisfy dependencies)
:: spl-linux-lts: installing linux-lts (4.14.44-1) breaks dependency 'linux-lts=4.14.41-1'
:: zfs-linux-lts: installing linux-lts (4.14.44-1) breaks dependency 'linux-lts=4.14.41-1'
```
And *bam*, nonexistent kernel version is needed. A new kernel is available for installing, at the time of writing this post:

```
# pacman -Ss ^linux-lts$ 
core/linux-lts 4.14.44-1 [installed: 4.14.36-1]
    The Linux-lts kernel and modules
```

See the following timeline to be more clear on what this repo can do for you:

| Kernel version | Situation | Means that |
|:-:|:-:|:-:|
| ... | | |
| 4.14.35 | |
| 4.14.36 | You are here with your currently installed kernel with ArchZFS modules | you want to upgrade your kernel and ArchZFS modules|
| 4.14.37 | |
| 4.14.38 | |
| 4.14.39 | |
| 4.14.40 | |
| 4.14.41 | Most recent ArchZFS supported linux-lts kernel modules package | my archzfs-kernels repository has the matching kernel packages that you can install along with ArchZFS module packages |
| 4.14.42 | |
| 4.14.43 | |
| 4.14.44 | |
| 4.14.45 | Most recent release of linux-lts kernel package | you can't upgrade to this version as ArchZFS support is behind |
| 4.14.46 | |
| ... | | |

Thus, this repo can come handy, when you are behind with the most recent ZFS supported kernel version but there's a newer ArchZFS supported kernel version that you want to upgrade to.

How can we obtain the required version for ZFS?

### My solution

Add my repo to pacman configuration file and refresh the repo dbs.

```sh
# cat >> /etc/pacman.conf <<_
> [archzfs-kernels]
> Server = http://end.re/\$repo/
> _
# pacman -Sy
:: Synchronizing package databases...
 core                      129.7 KiB  12.7M/s 00:00 [----------] 100%
 extra                    1620.4 KiB  26.4M/s 00:00 [----------] 100%
 community                   4.4 MiB  88.3M/s 00:00 [----------] 100%
 multilib                  170.8 KiB  0.00B/s 00:00 [----------] 100%
 archzfs is up to date
 archzfs-kernels             2.7 KiB  0.00B/s 00:00 [----------] 100%
```

After that, you can start upgrading as usual:

```
# pacman -Su
:: Starting full system upgrade...
resolving dependencies...
looking for conflicting packages...
error: failed to prepare transaction (could not satisfy dependencies)
:: spl-linux-lts: installing linux-lts (4.14.44-1) breaks dependency 'linux-lts=4.14.41-1'
:: zfs-linux-lts: installing linux-lts (4.14.44-1) breaks dependency 'linux-lts=4.14.41-1'
```

But it still won't work. Why? The thing is that even if the required version exists in my repo, `pacman` won't try to install/use it by itself. It would boil out with the very same message on the next run of `pacman -Su`. The trick is that we have to hint the required dependent version of the kernel itself:

```sh
# pacman -Su linux-lts=4.14.41-1
:: Starting full system upgrade...
resolving dependencies...
looking for conflicting packages...

Package (50)         Old Version   New Version   Net Change   Download Size

community/apcupsd    3.14.14-2     3.14.14-3       0.04 MiB        0.24 MiB
extra/bind-tools     9.12.1.P2-1   9.13.0-1       -0.25 MiB        1.61 MiB
[...]
```

If you want to have headers (for using other DKMS modules like VirtualBox host modules) you can install the relevant linux header packages at the same time:

```sh
# pacman -Su linux-lts{,-headers}=4.14.41-1
```

If the upgrade process happens to fail, and linux kernel package is installed.

{{< asciinema src="teszt.json" >}}

warning: linux-lts-4.14.41-1 is up to date -- reinstalling
