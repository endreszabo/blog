---
title: "WiFi + Ethernet bondingja"
date: "2010-07-24T00:00:00"
postcode: EBP003
comments: true
slug: "ebp003_wifi-es-ethernet-bondingja"
tags:
  - hálózat
categories:
  - koncepcionálás
---

Amikor otthon vagyok, macerásnak tartom a laptopomat levenni a dokkolóról, mert a vezetékes Ehternetről a WiFi-re való áttérés észrevehető másodpercekbe telik a már kiépült TCP kapcsolataim megszakadása mellett. Mindez persze azért van, mert a WiFi és vezetékes interfészeknek más-más IP-címük van, annak ellenére, hogy egy adott VLAN-ba tartoznak. Nos, megoldódni látszik ez a helyzet a továbbiakban.<!--more-->

## A megoldás

Ma az interface bonding világán filóztam, ez az ami failover/terhelés elosztást szolgáltat a vezetékes ethernet világában, melyet főleg enterprise környezetekben használunk. Ez mindenféle szabványos (802.3ad/LACP, broadcast, négyféle csomagszintű loadbalancing) megoldást kínál, azonban az esetemben egy egyszerű aktiv-passzív üzemmód az, ami nekem kellett. Ez azt jelenti, hogy minden esetben egy interface az aktív, elsúlyozva a vezetékes Ethernet interface irányába. Hálózati eszközökön ez semmilyen további extra konfigigénnyel nem jár, de értelme akkor és csak akkor van, amennyiben az adott ESSID a vezetékessel megegyező layer 2 hálózati szegmens tagja.

## Proof of concept

[Ebben a videó](https://vimeo.com/41582323)ban bemutatom a koncepciót működés közben, ahol is a bond0 interfész elsődleges tagja a vezetékes eth0 ethernet interfész, ami a WiFi wlan0 interfészre fog átterhelni, amint a vezetékes ethernet interface kapcsolatát megszakítom. Az át- és visszaterhelés elképesztően gyorsan zajlik, igazából kieséssel nem is jár, ahogy az az alábbi videón megfigyelhető:

<center><iframe style="border:2px solid #ccc" src="http://player.vimeo.com/video/41582323?title=1&amp;byline=0&amp;portrait=0&amp;color=f2f2f2" width="500" height="331" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe><br />Wifi-Ethernet bonding convergence in action</center>

## Használata a mindennapokban

Jelenleg a [wicd](http://wicd.sourceforge.net/) nevű keretrendszert használom a vezeték nélküli kapcsolataim kezelésére. A szomorú fejlemény ezzel kapcsolatban, hogy ez egyáltalán nem támogatja ezt a fura felállást. Erről volt is egy [szál](http://wicd.sourceforge.net/punbb/viewtopic.php?id=480) ("Wireless and Wired" néven) a hivatalos fórumon, aholis az egyik fejlesztő azt mondta, hogy:

> I would expect it to be very distant in the future, if ever.
 
Azaz az igény megvalósítására egy nagyon távoli jövőben számít, ha és egyáltalán.

Nem tudom, hogy van-e már hálózati kapcsolatokat kezelő megoldás ami támogatná ezt. Sajnálatos módon, úgy tűnik, hogy a wicd önmagában is elég hányatott sorsú: lezárták a fórumjaikat spam botok miatt és reakció sincs a fejlesztők felől a hivatalos #wicd freenode IRC csatornájukon. Bár a wicd egész könnyen módosíthatónak tűnik, úgy gondolom, hogy mégis a kis házi 'init' scriptjeimnél fogok maradni, ami felhúzza a bondingot és a wpa_supplicantet a megfelelő konfigurációban.

Bárhogy is legye, egy napon ezt kellene a wicd-nek megoldani:

Egy GUI/TUI elemre lenne szükség, mely a wpa_supplicant számára beállíthatóvá teszi a `-b bond0` paramétert, illetve egyúttal megadja a DHCP kliens daemonoknak, hogy magán a `bond0` interface-n figyeljenek a fizikai slave interface-k helyett.
**Frissítés:** jóval később pár napos debug után világossá vált, hogy a megoldásom 802.1x-et alkalmazó vezeték nélküli hálózatok esetében meglehetősen instabil: kb. 3 percenként bekövetkezik egy autentikációs hiba/timeout, még annak ellenére is, hogy a wpa_supplicant-nek meg lett mondva, hogy a `bond0` interface-re bindoljon.

## Kiterjesztés a mobil internet irányába?

Sajnos ez nem lehetséges a teljesen különböző típusú interface-k (Ethernet vs PPP) miatt, de az IPSec MOBIKE intézménye hasonló megoldást nyújthat. Erről majd még értekezek a későbbiekben.

