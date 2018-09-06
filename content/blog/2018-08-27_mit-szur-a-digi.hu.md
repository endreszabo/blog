---
címkék:
  - hálózat
  - dns
kategóriák:
  - életem
params:
#  hideTitle: true
#  hideMeta: true
#  hideComments: true
#  showTOC: true
#  hideNav: false
#  hideLicenceButton: true
#  hideFooterNote: true
#  hideHeader: true
  headerimage: http://digi.hu/sites/default/files/slider//slider_20180319_1g_slider_02.png
#  importHighlight: true
#  importAsciinema: true
  postcode: ebp042
slug: "ebp042_mit-szur-a-digi"
aliases: ["/ebp042"]
Title: "Mit szűr a Digi?"
Date: 2018-08-27T20:22:11
lastmod: "2018-09-05T12:25:00"
---

Egy szép napos délelőttön jött a riasztás, hogy a monitoring szerint a Digi-s előfizetésen lógó gépem nem elérhető. Ez általában cron által jól meghatározott időpontban szokott történni, amikor is a heti újracsatlakozást pontos ütemezés szerint, automatikusan végeztetem el. Azonban a riasztás nem időben jött és nem múlt el. A gépem eléréséhez két, különböző dyndns szolgáltatást használok a VPS-eimre csatlakozó VPN-eken túl: egy sajátot és egy külső szolgáltatóit. A gépemet nem sikerült elérni sem az aktuálisan, internetes címnek látott, sem a korábbi publikus címén.<!--more-->

Korábban szóbeszéd szintjén járt a Digi ügyfelek között, hogy az alsóbb kategóriát képviselő Internet előfizetések esetén az ügyfeleket kérdés nélkül CGN NAT mögé terelik „jó lesz nekik az is” alapon. A DIGINet 1000 és hasonló előfizetések esetén korábbi híresztelések szerint ez nem volt tervbe véve, azonban sajnos mégis ez történt.

Szóval, ezen kérés nélkül beállított CGN NAT-os telefonhívás során volt egy heves vitám a Digi Ügyfélszolgálattal, hogy ha már úgy is hibára kell lejelenteni a NAT-oltságot (3 napos hibajavítási határidő, wtf), akkor vegyék fel hibára azt is, hogy mindenféle ÁSZF-beli hivatkozás nélkül szűrik -- többek között -- a DIGINet-es kliensek felé indított UDP/53 forgalmat is. Ezt a tényt a callcenteres agent a „társosztállyal” egyeztetve tagadta a telefonban. A Digi hivatalos ügyfélszolgálata szerint csak az SMTP 25-ös portját szűrik. Az ÁSZF tesz egy implicit kinyilatkoztatást arra, hogy az SMTP forgalmat engedélyeztetni lehet a fix IP-címes ügyfelek esetében, ez azonban a lakossági körben már nem lehetséges.

Az UDP/53 szűrésével kapcsolatban az igazán elkeserítő a Digi Ügyfélszolgálatának a „társosztályokkal” karöltve 10 percben előadott kategórikus tagadása.

## Mindeközben a valóságban

Lássuk, hogy a valóságban, titkolt és szembesítés esetén is letagadott módon miket szűr még a Digi.

### Internet felől Digi ügyfél felé küldött csomagok esetében

* **UDP/53**: Blogposztom tárgya ez az érthetetlen portszűrés maga. Mégis, mi az oka lehet PONT ennek? Ezer sebből vérző Windows RPC szeméthegyek miért nincsenek inkább szűrve? Milyen ártalom közlekedik UDP/53-on? Digis dinamikus lakossági IP-címre mutató FQDN-re senki értelmes nem fog névszerver szolgáltatást delegálni. Én csak VPN-ezni szeretnék. Igen, ezen a porton. Vannak olyan [szar](https://www.ikea.hu/) [szemét](https://www.auchan.hu/) agyonkorlátozott WiFi-k, ahol pont ez az utolsó mentsvár, amin át egy OpenVPN vagy iodine még kijut.
* **TCP/25**: érthetetlen módon a Digis kliensek *felé* sincsen engedélyezve az SMTP forgalom. Egy időben volt ilyen törekvésem, hogy domainjeim MX rekordjának az otthoni gépem „dyndns” FQDN-jét adjam meg, hogy a levelek közvetlenül hozzám érkezhessenek be. Ezt a szűrést sajnos nem lehetett kikapcsoltatni hosszan siránkozás ellenére sem, a Digi befelé jövő SMTP forgalom esetén is fix IP-cím szolgáltatásra való előfizetéshez kötötte ezt. Mi a franc? A megoldást végül egy VPS-es VPN-en keresztüli DNAT jelentette, ami még olcsóbb is, mint a Digis fix IP-cím (amit már nem is lehet igényelni lakossági csomagokhoz évek óta).
* **TCP/53**: DNS szűrés TCP felett is. De miééért?

### Digi ügyfél felől Internet felé küldött csomagok esetében

* **UDP/0**: 0-s célportra küldött UDP csomagokat szűrik. Érthetetlen, hogy mi ez a kivételezés, főleg, hogy TCP/0 viszont mehet.
* **TCP/25**: ennek az egyetlen szűrésnek lehet alapértelmezetten racionalitása. Minden lakossági szolgáltató védi a saját, ügyfelek számára poolként használt prefixeit ilyen módon. Vannak az ügyfeleket kevésbé leszaró [„jobb”](https://www.telekom.hu/lakossagi) [szolgáltatók](https://www.upc.hu/internet/), akik lehetővé teszik az ügyél kérésére és felelősségére a közvetlen lakossági linkről való SMTP alapú levélküldést, bár ennek a korunkban a mindenféle, kétes módon kialakított és karbantartott BL-listák miatt kevéssé van gyakorlati haszna.

Már-már kész szerencse, hogy a DNS forgalom legalább kifelé nincsen szűrve, bár igazán nem akarok ötletet adni a Diginek ahhoz, hogy ilyen IKEA meg Auchan nyílt WiFi minőségre züllessze a szolgáltatását.

## Hibabejelentő

Írtam a Digi hibabejelentő címére, mellékelve a vizsgálataim során keletkezett PCAP-fileokat, melyből kétséget kizáróan és nyilvánvalóan kiderül a tény, hogy (többek között) az UDP/53 forgalmat szűrik.


> Tisztelt DIGI Távközlési és Szolgáltató Kft,
>
> Telefonos ügyfélszolgálattal történt, [redacted] számú hívásazonosító alatt rögzített telefonbeszélgetésünkre hivatkozva kérem szépen, hogy az előfizetői végpontjaim ([redacted] és [redacted] számú szerződések szerint) felé érkező UDP/53 forgalom korlátozás intézményét az előfizetői viszonylataim tekintetében megszüntetni szíveskedjenek.
>
> ```# nmap -sU -p 48-58 188.143.14.197
> Starting Nmap 7.70 ( https://nmap.org ) at 2018-08-27 22:10 UTC
> Nmap scan report for 188-143-14-197.pool.digikabel.hu (188.143.14.197)
> Host is up (0.0031s latency).
>
> PORT   STATE         SERVICE
> 48/udp closed        auditd
> 49/udp closed        tacacs
> 50/udp closed        re-mail-ck
> 51/udp closed        la-maint
> 52/udp closed        xns-time
> 53/udp open|filtered domain
> 54/udp closed        xns-ch
> 55/udp closed        isi-gl
> 56/udp closed        xns-auth
> 57/udp closed        priv-term
> 58/udp closed        xns-mail
```
> Technikai részletekért lásd a mellékelt PCAP file-okat.
>
> Köszönettel,
>
> Szabó Endre Zoltán

A két mellékelt PCAP file:

* [Internet es kliens szempontjából rögzített forgalom](/p/ebp042/internetes-forras-oldal.pcap.gz)
* [Digi ügyfél végpont szempontjából rögzített frogalom](/p/ebp042/digi-ugyfel-oldal.pcap.gz)

## Update

Megjött a Digi hibabejelentő válasza, miszerint:

> Bejelentését továbbítottuk illetékes kollégáink felé, visszajelzésük szerint nem tiltunk semmilyen DNS portot, feltehetőleg az Ön részéről nincs nyitvs és/vagy nem automatára van állítva a DNS, vagy rossz névszerver van beállítva.

Vajon milyen lehetősége maradt az egyszeri internetfelhasználónak ilyen nyilvánvaló, kétoldalú PCAP-ekkel alátámasztott esetben? NMHH [Lakossági bejelentés](http://nmhh.hu/tart/report/88/Kiepites_lefedettseg_savszelesseg_szolgaltatas_kimaradasa?action=bejelent&category=internet_tech)?

Végül, egyelőre, mint mindenkit érintő eset, egy lakossági bejelentéssel éltem az NMHH felé:

> Tisztelt Hatóság,
>
> A Digi Kft DIGINet fantázianevű lakossági Internetelérési szolgáltatása keretében az ÁSZF-ben foglaltakon felül további port-alapú szűrést is végez, melyről sem az ÁSZF-ben, sem a hibabejelentő ügyfélszolgálat explicit megkérdezése esetén sem nyilatkoznak.
> 
> Ez a korlátozás minden DIGINet szolgáltatást igénybe vevő ügyfelet érint.
>
> Felháborodásomnak és közérdekű bejelentésemnek az ad motivációt, hogy az eltitkolt korlátozás miatt nem tudom elérni a DIGINet előfizetés során kialakított szolgáltatás-átadási pontra csatlakoztatott előfizetői végpontomat az UDP/53-as porton (ahogy semelyik másik Digi ügyfél sem).
> 
> A témát mélyen technikai szinten a következő blogpostomban elemeztem:
> 
> https://end.re/hu/2018/08/27/ebp042_mit-szur-a-digi/
> 
> Bejelentésem szükség esetén hatósági eljárás megindítása iránti kérelemmé is átminősíthető, természetesen vállalva a kérelem megindításához szükséges előzetes eljárási illeték megfizetését.
