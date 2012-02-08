---
title: Dummy domains for testing DNS stuff
date: 2012/02/08 16:03:00
tags: dns
categories: dns
---
I've made a plenty of domains with full of various intentional mistakes for testing DNS implementations, and also for sanity checks while making a check script that will operate very much like `ISZT regcheck 'Domi' <http://www.domain.hu/domain/regcheck/>`_. Maybe I'll call it OpenDomi as ISZT refused to open the source of Domi. Here are the domains and description of mistakes they have:

.. csv-table::
    :header-rows: 1
    :widths: 22, 70

	"domain","mistake"
	"test00.y7.hu","valid domain without MX records"
	"test01.y7.hu","valid domain with only 1 NS"
	"test02.y7.hu","domain with only 1 NS that doesn't match SOA MNAME"
	"test03.y7.hu","domain with 3 Nses, 1 doesn't exist"
	"test04.y7.hu","domain with 3 Nses, 1 not auth for zone"
	"test05.y7.hu","domain with 3 Nses, 1 not auth for zone"
	"test06.y7.hu","domain with SOA record having less than the required fields"
	"test07.y7.hu","domain with SOA record having MNAME field removed"
	"test08.y7.hu","domain with SOA record having confusing MNAME field"
	"test09.y7.hu","domain with different SOA serials on NSes"
	"test10.y7.hu","domain with non-working RNAME address"
	"test11.y7.hu","domain with non-working RNAME mail domain"
	"test12.y7.hu","domain with no SOA record at all"
	"test13.y7.hu","domain with SOA fields out of RIPE recommendation ranges"
	"test14.y7.hu","domain with MX records not having A records"
	"test15.y7.hu","domain with MX record not having A records"
	"test16.y7.hu","domain with MX record not accepting mail for domain"
	"test17.y7.hu","domain with an NS record being a CNAME"
	"test18.y7.hu","domain not delegated on parent"
	"test19.y7.hu","domain with NSes pointing to the same address"
	"test20.y7.hu","domain with NSes different from parent delegation"
	"test21.y7.hu","domain with NS GLUEs different from parent delegation"

Feel free to use these domains for your tests.
