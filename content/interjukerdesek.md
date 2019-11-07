---
date: 2017-05-07T16:48:40+02:00
draft: false
params:
  hideComments: true
  hideMeta: true
  hideTitle: true
  hideToc: true
  hideNav: true
  postcode: ERP888
  unlisted: true
slug: "interjukerdesek"
title: Interjú kérdések
---

# Általános Unix-szerű kérdések

## Egyszerű kérdések

### Hogyan futtatsz egy parancsot a háttérben indítva? Hogyan hozod előtérbe?

- A parancssorban a parancs végére illesztett `&` jellel indítom a háttérben.
- `fg` parancs kiadásával hozom előtérbe.

### Hogyan állítod le a háttérben indított processzed?

- `fg` paranccsal előtérbe hozom, majd `<ctrl+c>`-vel leállítom.
- `kill %<jobid száma>` paranccsal SIGTERM signalt küldve leállítom.

### Hogyan lépsz ki `vi`-ból?

- Mentés nélkül:

1. `:q`
2. `:q!`
3. `ZZ`

- Mentéssel:

1. `:x`

### Hogyan kéred le / nézed meg a shellben korábban kiadott parancsokat?

A `history` (shell builtin) parancs segítségével.

### Hogyan másolsz biztonságos módon át egy filet egy gépről egy másik gépre?

- `scp` parancs használatával
- `sftp` parancs használatával
- `rsync` parancs használatával SSH-n keresztül.

### Hogyan találod meg a legtöbb memóriát foglaló processzt?

A `top` parancs segítségével, azon belül lesortolom memóriafoglaltság szerint.

### Hogyan deríted ki, hogy hány CPU, mag, illetve szál van a gépen, amire be vagy jelentkezve?

- `lscpu` kimenetének elemzésével (CPU(s), Thread(s) per core, Core(s) per socket sorok, de ezt nem kell tudni fejből).
- A `/proc/cpuinfo` pszeudofile tartalmának elemzésével (physical id, core id, processzor sorszám sorok, de ezt nem kell tudni fejből).

### Mi a különbség a hardlink és a softlink között?

### Milyen az egy felhasználós (single user) UN\*X rendszer? Mikor kerülhet sor a használatára?

### Mi az a `bash`?

### Mit jelent, mit csinál az `rm -r *` parancs? Milyen körülmények között nem végzi el a feladatát teljesen?

- Törli az aktuális könyvtárban található fileokat/könyvtárakat.
- Nem törli a rejtett fileokat, illetve nagyon sok, az aktuális könyvtárban létező file/könyvtár esetén E2BIG hibával nem fut le.

### Mik azok a hardlinkek és mitől különböznek a softlinkektől?

### Mit célt szolgálnak a `chmod`, `chown`, illetve `chgrp` parancsok?

### Van a gépeden valahol egy `fw-rendszerterv` karaktersorozatot tartalmazó nevű file. Milyen módon tudod megtalálni, hogy hol van?

- locate (ha van és futott a `<s|m>locate` indexelője)
- find

### Hogyan találsz meg egy adott karaktersorozatot tartalmazó sort egy adott fileban?

- `grep "karaktersorozat" filenév`

### Hogyan számolod meg egy adott karaktersorozatot tartalmazó sorokat egy adott fileban?

- `grep -c "karaktersorozat" filenév`

### Mik azok a környezeti változók és milyen formátumban kell őket definiálni?

### Milyen módon tudod ellenőrizni, hogy egy adott TCP port nyitva van-e egy távoli gépen (mindennemű tűzfal kikapcsolt állapotában)?

### Mi célt szolgál a `nohup` parancs és mikor, milyen módon kell meghívni?

### Milyen módon jeleníted meg periodikus módon (pl. 2 másodpercenként) egy folyamat kimenetét?

- A `watch <parancs>` parancs használatával.

### Egy adott, `fwlog.txt` nevű syslog fileban anonimizálás céljából hogyan cseréled ki a `fwpri1` hostnév karakterláncot `firewall` karakterláncra?

Ezt rendesen el lehet bonyolítani, de a legvalószínűbb egyszerű válasz ez lesz: `sed s/fwpri1/firewall/g -i fwlog.txt` Esetleg /g nélkül, ha a válaszadó figyelmet fordít arra, hogy klasszikus syslog formátumok esetében a hostnév mező a sorok első részében szerepel.

### Egy gép adott kötetének szabad területe elfogyott. Milyen módon deríted ki, hogy mi foglalta el a helyet, ha korábbról nem volt helyismereted az adott gépen?

- `du -sh *` és hasonló iterációk fognak következni.
- Vagy rögtön `ncdu` lesz a válasz.

### Hogyan deríted ki, hogy mennyi ideje van egy adott gép bekapcsolva?

- `uptime` parancs használatával.
- `/proc/uptime` pszeudofile kimenete.

### Adott egy ismert IP-című gép a hálózatodon. Milyen módon deríted ki a hostnevét (minden körülmény ideális)?

- DNS alapon, `dig`, `host`, `nslookup` parancsok jönnek szóba.

### Mi a különbség az abszolút és relatív út között?

### Hogyan zajlik egy HTTP proxy-val biztosított kérés kiszolgálása?

### Lehetséges-e HTTPS forgalom kiszolgálása egy HTTP proxy-val?

### Lehetséges-e FTP forgalom kiszolgálása egy HTTP proxy-val?

### Mire szolgál egy HTTP válaszüzenet fejlécében található "Location" nevű header?

### Mi a különbség a MUA és az MTA között?

### Mit jelent az UAC?

### Mi az az Active Directory?

### Milyen feladatai vannak egy tartományvezérlőnek?

## Közepes kérdések

### Mit jelent a PGP? Miben másabb ez a GPG-től?

### Mi a különbség a SCSI, iSCSI és Serial-attached-SCSI között?

### Mit jelent a snapshot intézménye egy volume manager esetében?

### Mit jelent a tükrözött kötet?

### Mit jelent az extended unix ACL és mikor van jelentősége?

### Mit jelent az FDE?

### Hogyan deríted ki, hogy egy adott, már futó processz milyen file-okat tart nyitva?

- `lsof -c` ha processznév, `lsof -p` ha PID alapján keresem.
- A `/proc/PID/fd` könyvtár tartalma alapján.

### Hogyan deríted ki, hogy milyen távoli gépek csatlakoznak a gépeden nyitott, pl. 3128/TCP portra?

- `netstat -ntp | grep 3128`

### Mik azok a FIFO típusú fileok és mire használatosak?

### Milyen típusú fileokat támogat a Linux, illetve általános célú filerendszerei?

- közönséges file-ok
- (unix domain) socketek
- szimbolikus linkek
- karakter típusú eszközfileok
- blokk típusú eszközfileok
- FIFO-k
- könyvtárak (igen, ezek is fileok)

### Mi az a zombie processz? Hogyan derítheted ki a létezését?

- A zombie processz olyan néhai, már nem futó processz, amelynek a szülője processze még nem gondoskodott a kernel által a szülő számára biztosított, a zombie processzhez tartozó átmeneti memóriaterület elkéréséről, felszabadításáról.
- A `ps` parancs használatával, annak kimenetében a zombie státuszú processzeket legyűjtve (`Z`) derítem ki a létezését.

### Meddig "él" a zombie processz? Hogyan tudod leállítani?

- Addig él, amíg a szülője, vagy szülő processz nélküli esetben az `init` el nem "takarítja".
- Sehogy.

### Hogyan deríted ki, hogy mennyi hely van még az aktuális meghajtón?

A `df -<közel tetszőleges kapcsolók> .` paranccsal, például `df -h .` vagy `df -k .`.

### Ha több processzt indítottál a háttérben egy shell-ből, milyen módon hozod előtérbe egy korábban indított processzed?

- (opcionális): `jobs` paranccsal lekérem a háttérbe küldött/háttérben indított processzek listáját, melyben a parancs mellett a job id-t is láthatom.
- az `fg %<jobid száma>` paranccsak hozom előtérbe a kiválasztott processzt.

### Hogyan állapítod meg, hogy a rendszer, amelyiken dolgoznod kell, 32 vagy 64 bites-e?

- `uname -m` vagy `uname -a` parancsok kimenete alapján.
- `/proc/cpuinfo` fileból (ha van) szerzett adatok alapján. 
- `lscpu` (ha van) Architecture sora alapján
- `getconf LONG_BIT` paranccsal (ha van) ellenőrizhetjük a long típusú integer méretét bitben.
- `file` paranccsal az `/sbin/init` file elemzése alapján kapott adatokból.

### Milyen módon tudod egy környezeti változót a subshell számára is elérhetővé tenni?

- `export VÁLTOZÓNÉV` ha már definiálva van.
- `export VÁLTOZÓNÉV=ÉRTÉK` ha még nincs definiálva.

### Milyen módon tudod ellenőrizni, hogy egy adott UDP port nyitva van-e egy távoli gépen (mindennemű tűzfal kikapcsolt állapotában)?

### Mit jelent és mikor használatos a "gather\_facts: false" beállítás?

### Kialakítható-e egy RAID6-os szintű tömb pusztán Linux kernel alapú szoftveres megoldás használatával?

### Mi az adatéletút-menedzsment és miért van rá szükség?

### VMware használata estén fizikai node-ok közötti VM-migráció tud-e SAN-hálózat használatával működni?

### Lehetséges-e egy SAN-t támogató tárolóról közvetlenül magnóra történő mentés készítése?

### Származhat-e az RDN a DN értékéből?

## Extrém kérdések

### Mi a különbség a `ps -ef`, `ps aux` és `ps -aux` parancsok kimenetei között?

### Milyen módon tudod ellenőrizni, hogy egy adott protokoll elérhető-e egy távoli gépen (mindennemű tűzfal kikapcsolt állapotában)?

### Mi a tiszavirág (ephermeral) portok intézménye?

# PKI és TLS kérdések
 
## Egyszerű kérdések

### Milyen paranccsal írathatjuk ki egy rendelkezésre álló, base64-kódolt tanúsítvány attribútumait shell-ből indítva?

- `openssl x509 -text -in tanusitvanyneve`

### Lezárul-e egy TLS-alapú kapcsolat, amennyiben a kapcsolatot hitelesítő tanúsítvány(ok egyike) lejárt?

- Nem, még rekeying esetében sem.

### Jelenleg hányas verziónál tart a TLS-szabvány?

- Élesben 1.2, az 1.3 tervezés alatt van.

### Mi a különbség az RSA és AES között?

### Mi a különbség az RSA és ECDSA között?

### Lehetséges-e ugyanazon az IP-címen HTTP és HTTPS kapcsolat egyszerre történő kiszolgálása?

### Mi az a CSR?

### Mi a különbség az SSL és a TLS között?

### Mi a különbség a szimmetrikus és aszimmetrikus titkosítások között? Melyik a gyorsabb?

### A 3DES kriptográfiai primitív nevében mit jelent a 3-as szám?

### Az AES, 3DES, RSA és RC4 felsorolásból melyik a kakukktojás és miért?

### Alkalmazható-e tömörítés egy TLS-session keretében titkosított csatornán belül? És azon kívül?

### Mi az a smartcard?

- Sok a különbség és a szimmetrikus gyorsabb.

### Mi az a blokklánc? Mondj rá gyakorlati példát!

## Közepes kérdések

### Milyen módokon lehetséges a HTTPS forgalom adott hostnévre való szűrése?

### Felépíthető-e egy FTP-kapcsolat STARTTLS használatával?

### Elképzelhető-e egy olyan TLS-kapcsolat, amelyben egyik fél sem hitelesíti, vagy mutat be tanúsítványt?

- Nem. Vagy a fogadó oldalnak vagy mindkét oldalnak hitelesítenie kell magát.

### Mi a különbség a PKCS11 és PKCS12 között?

### Miért lehetetlen PKCS11-ről PKCS12-re konvertálni/upgradelni?

### Egy tanúsítvány CSR alapján történő kiállításához milyen adatok átemelése kötelező?

### Milyen parancs használatával változtatható meg egy PEM formátumú asszimmetrikus privátkulcs titkosításához használt szimmetrikus kulcsa?

### Tud-e egy TLS-t támogató kliens egy csak SSL-t támogató szerverhez kapcsolódni?

- Igen.

### Milyen jelszó ujjlenyomatképzési algoritmusokat támogat egy modern Linux disztribúció?

### Alapértelmezett esetben fizikailag hol tárolódnak egy Linux disztribúción a felhasználói jelszavak?

### Milyen parancs használatával kapcsolódnál telnet szerűen egy TLS-alapú szolgáltatási ponthoz annak érdekében, hogy ez a TLS kapcsolat fel is épüljön?

### Lehetséges-e TLS-alapú tanúsítványokkal SSH szolgáltatási ponthoz viszontazonosítva kapcsolódni?

### Mutasd be a `Basic Authentication` HTTP header jelentését, működését.

### Mit jelent a "Cipher Suite" és mikor van jelentősége?

- Igen.

### Mi a különbség a HPKP és a HSTS között? Alkalmazhatók-e ugyanazon kapcsolaton belül egyidőben?



## Nehéz kérdések

### Hitelesnek tekinthető-e egy lejárt hitelesítésszolgáltatói tanúsítvány által kiállított időpecséttel ellátott dokumentum?

- Igen.

### Hitelesnek tekinthető-e egy visszavont hitelesítésszolgáltatói tanúsítvány által kiállított időpecséttel ellátott dokumentum?

- Az a körülményektől függ. A visszavonási lista tartalmazza a hitelesítésszolgáltatói tanúsítvány visszavonásának okát, de döntésünk minden esetben szubjektív. Érdemes egyeztetni a hitelesítésszolgáltatói tanúsítvány birtokosával a történtekről.

### Létezhet-e szimmetrikus titkosítás nélküli PKCS12 konténer? Ha igen, milyen körülmények között?

- Nem létezhet.

### Milyen viszontazonosítási eljárások mellett lehetséges-e Let's Encrypt-tel a wildcard típusú tanúsítvány kiállíttatása?

### Mi az a HSM és mikor használatos?

## Extrém kérdések

### Mik azok az attribútumtanúsítványok és mikor lehet rájuk szükség?

# Hálózattal kapcsolatos kérdések

## Egyszerű kérdések

### Mutasd be egy TCP kapcsolat felépülésének egyes fázisait!

### Mutasd be egy TCP kapcsolat lebontásának egyes fázisait!

### Mit jelentenek a martian source típusú hibaüzenetek?

### Kideríthető-e egy távoli gépről, hogy egy adott UDP portján van-e listenelő socket (minden körülmény ideális)? Ha nem miért nem?

### Lehetséges-e smartcard-on elhelyezett tanúsítvány segítségével történő hitelesítés egy VPN-kapcsolat felépítése során?

- Kideríthető, nem listenelő socket esetén ICMP port unreachable üzenet jön válaszul.

### Mi a különbség a switch és a router között?

### Mi a különbség az OSI 2-es és 3-as rétege között?

### Mit jelent a "Broadcast domain"?

### Hogyan működik az STP protokoll?

### Mi történik ha egy switch FDB táblája betelik?

### Mit jelent és mikor állhat elő a Broadcast Storm?

### Lehetséges-e TCP alapon traceroute-ot végezni?

### Sorold fel az RFC1918 által definiált privát hálózati tartományokat!

### Mit jelent az aszimmetrikus routing?

### Miben előnyösebb a CHAP használata a PAP-nál?

### Mi a különbség a PTP és PMP típusú hálózati viszonylatok között?

### Mi a különbség a CIFS és az NFS protokollok között?

### Mi az az IP-cím?

### Mi az a MAC-cím?

### Mi a különbség a multicast és a broadcast között?

### Mi a különbség az unicast és az anycast között?

### Mit jelent a DMZ?

### Hány rézvezetőnek van hely egy RJ45 típusú csatlakozóban?

### Mit jelent a csavart érpár?

### Mi a különbség a TCP és az UDP között?

### Mi a különbség a SAN és a NAS között?

## Közepes kérdések

### Lehet-e egy SMTP-válaszüzenet több soros?

### Mi közös van a H323 illetve SIP protokollokban?

### Mi az a LUN?

### Mi az a VTL?

### Mi az a VTP?

### Lehet-e egy SAN fabricot "VLAN" szerűen particionálni?

### Mi a különbség a single mode és multi mode között?

### Kiépíthető-e egy LACP/etherchannel link több, különböző sebességű taginterfész használatával?

### Mi az az ACL?

### Egy hálózati eszközön a "9600 8n1" felirat van feltüntetve. Mit jelent ez?

### Mi az az ARP proxy és mikor használatos?

### Mi az OSPF?

### Az ARP protokoll melyik OSI rétegben működik?

### IPsec kapcsolatod felépítésekor `NO\_PROPOSAL\_CHOSEN` típusú hibaüzenetet kapsz vissza a túloldaltól. Mi a hiba és hogyan lehet megoldani?

### Mik azon a SYN cookiek és mikor van rájuk szükség?

### Mi az a PMTUD?

### Mi a különbség az IPSec és a MACSec között?

### Általad üzemeltetett Linux netfilter alapú tűzfal naplóiban magas számosságban látsz RST flaggel ellátott és eldobott TCP csomagokat. Mi ennek az oka? Mit lehet tenni ellene?

### Kideríthető-e egy távoli gépről, hogy egy adott IP protokollon hajlandó-e kommunikálni (minden körülmény ideális)? Ha nem miért nem?

- Igen, ha nincs felbindolva az adott protokollra semmi sem (pl IPSec terminálására a kernel maga az ESP protokollon) akkor ICMP protocol unreachable üzenet jön válaszul.

### Mit jelent a csillapítás és hogyan szabályozható?

### Mit jelent az Autonomous System?

### Mi a különbség a latency és a jitter között?

### Hány darab használható IP-cím van egy /27-es IPv4 alhálózatban klasszikus ethernet alapú hálózat esetén?

### Mi a különbség a "baud rate" és a "bit rate" között? Ezek értéke milyen körülmények között egyezhet meg ugyanazon viszonylatban?

### Mi az a MIB?

### Mi a különbség az IPS és az IDS között?

### Mekkora a PPPoE linkeken használatos effektív MTU-érték, amennyiben az RFC4638 MTU növelő megoldás nem támogatott?

### Mi a különbség a dualstack és dualstack-lite között?

### WiFi hálózatok esetében mint jelent a "beacon interval"?

### Milyen portot használ a ping általános esetben?

### PoE képes VoIP telefon üzemeltethető-e egy PoE-t nem támogató switch-ről?

### Mi a különbség a stateful és stateless IPv6-cím autokonfigurációja között?

### Mi a különbség a tcpdump és wireshark programok között?

### Milyen üzemmódot jelent, ha egy Cisco router promptja `Router#`?

### Miért előnyösebb egy switch-elt hálózat a bridge-lt hez képest?

## Nehéz kérdések

### Ethernet flow control használatának mi az előnye?

### VLAN-taggelt VoIP telefonóia használata esetén az ezeket kiszolgáló switchportok access vagy trunk típusúak?

### Mutasd be a SYN cookiek alkalmazásával felépülő TCP kapcsolat egyes fázisait!

### Milyen esetekben nem tud a PMTUD működni?

### Kiépíthető-e egy MACSec kapcsolat tanúsítványok helyett csak PSK alapú viszontazonosítás használatával?

### Mit jelentenek a martian destination típusú hibaüzenetek?

### Mi történik ha egyik kommunikáló fél a TCP window méretét 0-ra húzza le?

### Mi az az OTDR? Mire használatos?

### Kialakítható-e egy null-modem kábel kettő darab cisco konzol kábel RJ45-toldóval történő illesztésével?

### Mi az a BPDU és mikor érdemes szűrni?

### Mi az a BGP?

### Mi az az IPVS?

### Milyen módon kell egy ASA-eszközt menteni annak érdekében, hogy a konfigurációs beállításokban szereplő jelszavak is elmentésre kerüljenek?

### Lehetséges-e egy ASA-eszköz estében egyazon lábon érkező, routing beállítások miatt ugyanazon kimenő forgalom szűrése?

## Extrém kérdések

### Az IPVS RD üzemmódban melyik OSI rétegen dolgozik?

### Mit jelent a Bandwidth Delay Product?

- BDP = sávszélesség * rtt. Éppen a hálózatban mozgásban lévő adatok mennyisége.

# DNS-sel kapcsolatos kérdések

## Egyszerű kérdések

### Mi a különbség az A és AAAA típusú rekordok között?

### Lehet-e A típusú rekordot PTR típusú rekorddá alakítani?

### NS rekord értékeként beállítható-e IP-cím?

### MX rekord értékeként beállítható-e IP-cím?

### Mi a különbség a DNSSEC és az IPSec között?

## Közepes kérdések

### Mi az a glue (ragadvány) típusú rekord és milyen esetekben van rá szükség?

### Az SPF előírásokat milyen típusú rekord(okban) tároljuk?

### Lehetséges-e egy /24-nél kisebb tartomány reverse zónájának delegálása?

## Nehéz kérdések

### Mi az a CAA típusú rekord?


