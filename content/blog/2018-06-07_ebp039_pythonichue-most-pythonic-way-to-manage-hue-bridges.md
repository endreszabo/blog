---
tags:
  - python
  - homeautomation
categories:
  - Proof of Concept
params:
  hideTitle: false
  hideMeta: false
  hideComments: false
  hideTOC: true
  hideNav: false
  hideLicenceButton: false
  hideFooterNote: false
  hideHeader: false
  postcode: EBP039
  indexImage: bridge.jpg
  indexImagePercent: 20
  importHighlight: true
  importAsciinema: true
slug: "ebp039_pythonichue-most-pythonic-way-to-manage-hue-bridges"
draft: true
aliases: ["/ebp039", "/pythonichue"]
Title: "PythonicHue: the most pythonic way to manage hue bridges"
Date: 2018-06-07T15:00:18
---

Hue is a smart lighting line made by Philips. It consist of smart bulbs, remotes, sensors and their controlling	hub called the Hue bridge. The whole Hue ecosystem is very well supported both officially and by 3rd parties. Lots of great apps and other management tools exist. Yet, this summer, after a long ongoing research I found no one app that can manage the Hue bridge ruleset fairly well. Even the pay version apps lack the full complete support for rule attributes. Also, there are quite a few language dependt frameworks that can help with dealing different types of Hue bridge objects.

After all I decided to make a Hue management framework that converts your exising Hue settings to valid python code that can be changed and ran again to actuate the changes in the hub.<!--more-->

This eventually led PythonicHue, my approach of Hue bridge management, with the aim to be the most complete, yet very versatile framework. The ultimate goal is to create a Single Source of Truth, so it would also become an excellent backup solution that the Hue ecosystem is in short of.

This is how a light object is represented at the Hue API:

```json
{
  "state": {
    "on": true,
    "bri": 254,
    "hue": 8418,
    "sat": 140,
    "effect": "none",
    "xy": [
       0.4573,
       0.4100
    ],
    "ct": 366,
    "alert": "none",
    "colormode": "ct",
    "mode": "homeautomation",
    "reachable": false
  },
  "swupdate": {
    "state": "noupdates",
    "lastinstall": null
  },
  "type": "Extended color light",
  "name": "Hue color lamp 1",
  "modelid": "LCT010",
  "manufacturername": "Philips",
  "productname": "Hue color lamp",
  "capabilities": {
    "certified": true,
    "control": {
      "mindimlevel": 1000,
      "maxlumen": 806,
      "colorgamuttype": "C",
      "colorgamut": [
        [
           0.6915,
           0.3083
        ],
        [
           0.1700,
           0.7000
        ],
        [
           0.1532,
           0.0475
        ]
      ],
      "ct": {
        "min": 153,
        "max": 500
      }
    },
    "streaming": {
      "renderer": true,
      "proxy": true
    }
  },
  "config": {
    "archetype": "sultanbulb",
    "function": "mixed",
    "direction": "omnidirectional"
  },
  "uniqueid": "00:17:88:01:02:6f:7d:33-0b",
  "swversion": "1.29.0_r21169",
  "swconfigid": "6A139B19",
  "productid": "Philips-LCT010-1-A19ECLv4"
}

```

This is how you define a light, representing the actual usefil information of the above:

```python
bridge.add_light(Light(
        ## Read-write variables
        name = 'Hue color lamp 1', # A unique, editable name given to the light.
        ## Readonly variables (for PythonicHue object reference only)
        uniqueid = '00:17:88:01:02:6f:7d:33-0b', # Unique id of the device. The MAC address of the device with a unique endpoint id in the form: AA:BB:CC:DD:EE:FF:00:11-XX
        ## 6-characters serial number printed on light (optional)
        serial = 'EDITME', # 6-characters serial number printed on light used for (re)adopting lights when restoring from backup (optional)
))
```
