---
címkék:
  - hálózat
  - linux
kategóriák:
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
  importHighlight: true
#  importAsciinema: true
  postcode: EBP041
slug: "ebp041_using-linux-dummy-interfaces-instead-of-virtualbox-host-only-adapter"
draft: true

aliases: ["/hu/ebp041"]
Title: "Linux dummy interface bridge-k használata a VirtualBox host-only adaptere helyett"
Date: 2018-07-10T06:50:32
---
Mint az korábbi blogposztokból kiderülhetett, VirtualBox-ot használok munkám során pár VM futtatására, köztük például split-tunneling-mentes ügyfél VPN létesítésére és kényelmes host oldali használatára.

A VirtualBox sokféle hálózati konfigurációt támogat a VM-ek számára, ezek közül én jó ideig a host-only adaptert használatam a VM-ek kiszolgálására. Az idők nagy részében a konfiguráció kielégítette az igényeimet, azonban a host interface-k felkonfigurálásának módját homály övezte jó ideig.

A VPN kapcsolatok létesítése és kiszolgálásának feladata során jelentkezett az igény, hogy a VM maga routeoljon és SNAT-oljon forgalmat a VPN tunnel felé. A VPN "mögöttes" tartományok host oldali eléréséhez a tartományokat rá kellett routolni a VM IP-címére. És erre route beállításra nem találtam a host rebootja után, automatikusan működő megoldást.

Ezért váltottam olyan megoldásra, ahol a host kontrollált körülmények között húzza fel a VM-ek számára elérést biztosító host oldali interface-t.<!--more-->

A megoldás alapjául a korábban már nálam erős használatban lévő dummy interface intézménye jelentette. A meglévő dummy interface-től való elszeparáltságként választhattam volna, hogy a `dummy` kernel modulnak adott `numdummies` paraméter értékét növelve további dummy interface-eket hozok létre, vagy, mint az alább látható, VLAN-címkézés is működő megoldás a dummy interface-k tekintetében.

Mindenféle `systemd` felől származtatható kinövés ellenére én a klasszikus, daemon futását nem igénylő Arch Linux specifikus `netctl` nevű hálózati konfigurációs megoldást preferálom.

Fontos tanulságként jött szembe a kialakítás során, hogy a dummy interface alapértelmezett állapotában sem ARP sem multicast (=IPv6 ARP) forgalmazást nem támogat.

A következő netctl profil került kialakításra a `/etc/netctl/dummy0.1192` file-ban:

```sh
Description='Dummy VLAN 1192, formerly vboxnet0'
Interface=dummy0.1192
Connection=vlan
BindsToInterfaces=dummy0
VLANID=1192
IP=static
Address=("44.128.191.1/24")
IP6=static
Address6=("fd4d:4045:e5e8:3000::/64")
ForceConnect=yes
ExecUpPost=(
	'/sbin/ifconfig dummy0.1192 multicast arp'
	'/sbin/ip ro add 10.31.0.0/17 via 44.128.191.36'
	'/sbin/ip ro add 10.33.0.0/17 via 44.128.191.36'
)
```

Bár jellemzően minden VM-em fix IP-címmel rendelkezik, adódik a helyzet, hogy egy DHCP-vel IP-címet kérő VM-et kell importálnom és indítanom. Erre az eshetőségre a dummy0.1192 interface-n figyel egy ISC-féle DHCPd a következő idevágó releváns konfigurációs részlettel:

```
subnet 44.128.191.0 netmask 255.255.255.0 {
	range 44.128.191.100 44.128.191.199;
	option routers 44.128.191.1;
	option domain-name-servers 44.128.255.255;
	default-lease-time 7200;
	max-lease-time 86400;
}
```

VirtualBox VM beállítsai között pedig így néz ki a dummy interface bridge:

{{< img src="1531206534.png" title="1531206534.png" link="" alt="" caption="" attr="" attrlink="" class="center arnyek" >}}

