---
title: "Thoughts on everyday endiannes"
date: 2011-11-11T11:11:11
postcode: ebp004
slug: "ebp004_thoughts-on-everyday-endianness"
categories:
  - Half Baked Ideas
tags: 
  - endianness
params:
  hideTitle: false
  hideMeta: false
  hideComments: false
  hideTOC: true
  hideNav: false
  hideLicenceButton: false
  hideFooterNote: false
  hideHeader: false
#  indexImage: bridge.jpg
#  indexImagePercent: 20
#  importHighlight: true
#  importAsciinema: true
  postcode: EBP004
  indeximage: oh-god.png
aliases: ['/ebp004']
draft: false
---

Just a quick note on 11/11/11: I'd like to express how awesome big-endian is in all aspects of life. In Hungary we use big-endian for pretty much everything (very much like Japan), eg. representing dates, family and given names and addresses.

<!--more-->

For example, in hungarian language, the date of today is usually expressed like:

	longest form: 2011. november 11, péntek. (YYYY-MM-DD, day-of-week)
	shortest form: 11.11.11 (YY.MM.DD.)

It can be much easier to interpret a date that comes in front of you while browsing the net when it starts with a year, because it will hardly represent a middle-endian date (YYYY-dd-mm), while dates ending with year can be confusing, because if the day part is lesser than 13, you can't be sure if month or day comes first (mm/dd/yyyy or dd/mm/yyyy).

In Hungarian names, the Family name (thus the most significant) comes first and then the given name, and maiden/middle (least significant) name last. People with three names is quite uncommon though.

An address specification is like the following (Parlament of Hungary in this case):

	Budapest
	V. kerület
	Kossuth tér 2
	1051

Budapest (most significan data) is the capitcal city of Hungary, 'V. kerület' means 5th district, Kussuth ter stands for Kossuth square, and 2 is the house number (least significant). 1051 is the post code (here is some redundancy as post codes specifies a region of the country so if someone misses to specify the city or the district, its letter still can be delivered to the right address).

Soon there will be 11:11:11 UTC that can be representated as `2011-11-11T11:11:11Z` according to the ISO8601 standard. The standard is pretty straightforward, no confusion at all.

So please, let's use big-endian representation every where. Please.
