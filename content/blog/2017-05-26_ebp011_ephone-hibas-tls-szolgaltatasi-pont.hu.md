---
címkék:
  - voip
kategóriák:
  - magyar internetek
params:
  hideTitle: false
  hideMeta: false
  hideComments: false
  hideTOC: false
  hideNav: false
  hideLicenceButton: false
  hideFooterNote: false
  hideHeader: false
#  indexImage: bridge.jpg
#  indexImagePercent: 20
#  importHighlight: true
#  importAsciinema: true
  postcode: EBP011
slug: "ebp011_ephone-hibas-tls-szolgaltatasi-pont"
draft: true
aliases: ["/hu/ebp011"]
Title: "Ephone hibás TLS szolgáltatási pont"
Date: 2017-05-26T09:07:12
lastmod: 2018-05-09T10:40:00
---
Nagy sajnálatomra úgy tűnik, hogy kedvenc ITSP-szolgáltatóm, az Ephone ~~Magyarország Kft.~~ Schweiz GmbH kezdeti bíztató jelek ellenére mégsem a magyar internetek fostengerében üdítő kivételt képező igényesség koronázatlan unikornisa. Immáron több, mint egy éve, hogy bejelentettem, hogy "kilóg a lóláb" és ideális lenne ha minimum az elvárható szinten működne a (régi) honlapjuk, ha már egyszer szolgáltatják. Levelemre válasz szinte azonnal jött.<!--more-->

	Subject: [Ügyszám: #12502] Elektronikus ügyfélszolgálat: hibás TLS
	szolgáltatási pont
	From: "Molnár Péter" <info@ephone.ch>
	Date: 05/23/2016 02:40 PM
	To: endre@[redacted]

	Kedves Endre!

	Kizárólag az ephone.ch oldalon vagyunk elérhetőek jelenleg, a .hu-t hamarosan
	átvesszük és újat rakunk a helyére.

	Köszönjük észrevételét!

	On Hétfő 2016. Máj 23 14:34:52, endre@[redacted] wrote:
	> Kedves Ephone,
	> 
	> Kérem, legyenek kedvesek az "Elektronikus ügyfélszolgálat" TLS-es
	> szolgáltatási pontját fixálni, mert jelenleg cleartext forgalmat vár és /-re való
	> lekérdezésre a virtualhostok könyvtárát adja vissza:
	>
	> http://www.ephone.hu:443/
	>
	> -- Endre

	--
	Üdvözlettel:
	Molnár Péter
	--------------------
	Ephone - Support
	Ügyfélszolgálati elérhetőség:
	0036-1-550-77-77
	www.ephone.ch

A problémára a megoldás azóta várat magára, ahogy az alább is látható.

A probléma gyökere kb. az lehet, hogy a cégváltással párhuzamosan elhanyagolódni látszik a magyar elődcég ephone.hu címen található honlapja. Egy szűk szavú közleményen túl azonban a korábbi linkek túlnyomó többsége még mindig él. Én rutinos prepaid felhasználóként mindig a jobbfelső sarokban található "Elektronikus ügyfélszolgálat" linkre nyargaltam az egyenleg feltöltéshez.

{{< img src="s0.png" >}}

Tavaly ilyenkor azonban a szokásos login form helyett az alábbi Firefox TLS-hibaüzenet jelenet meg:

{{< img src="s1.png" >}}

Egy rövid `curl`-os nyomozás után azonban fény derült arra, hogy itt szó nincs semmiféle TLS-ről. Egyszerűen cleartext HTTP-n vár kéréseket a túloldal. A [`http://www.ephone.hu:443/`](http://www.ephone.hu:443/) címet megnyitva a következő tartalommal találtam szembe magam.

{{< img src="s2.png" >}}

Korábban javasoltam ismerősöknek az Ephone szolgáltatásait, mert alapvetően meg vagyok elégedve velük. A szolgáltatás jó, stabil, korrekt ár-érték arányú, az ügyfélszolgálat nem várakoztat és mindig készséges. A fentiek fényében azonban alapvető szakmai kompetenciák rendelkezésre állásának hiánya merül fel bennem, ami hosszú távon nem biztos, hogy előnyére válik a szolgáltatónak.

**Update**: elhelyeztek egy `This site has no content.` tartalmú index.html-t a kérdéses szolgáltatási pont root-jában.

