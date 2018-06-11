---
címkék:
  - beágyazott
kategóriák:
  - Proof of Concept
  - Otthonautomatizálás
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
  importHighlight: true
#  importAsciinema: true
  postcode: EBP015
slug: "ebp015_enabling-the-second-spi-bus-on-the-raspberry-pi-2-and-3"
draft: false
aliases: ["/hu/ebp015"]
Title: "A második SPI busz használata a Raspberry PI 2-n és 3-on"
Date: 2017-06-24T11:58:18
---

Bár kevesen tudják, a Raspberry Pi 2-es szériától kezdve a SoC-on még egy SPI vezérlő kivezetés is helyet kapott. Ez abban segíthet nekünk, hogy egy új slave esetén ne kelljen az SPI0 buszon osztoznia a már meglévő slavenek.

A lakásautomatizálási feladatok ellátásának egy részét egy RPI2 végzi itthon. A korábban CAN BUS alapú szenzorhálózatot kiegészítettem a mysensors.org féle NRF24L01 ráadiós adóvevővel rendelkező hálózattal. A CAN BUS controller és transceiver hagyományosan az SPI0 buszon futott, az NRF24L01 került az SPI1-re.

A MPC2515 CAN kontroller a kernelben működő drivert használja, egy can0 hálózati eszközt létrehozva.
Az NRF24L01 esetében SPI kommunikációra az spidev stacket használom.

/boot/config.txt
```ini
dtparam=spi=on

dtoverlay=spi-dma
dtoverlay=spi-bcm2835
dtoverlay=mcp2515-can0,oscillator=8000000,interrupt=25
dtoverlay=spi1-1cs
```


