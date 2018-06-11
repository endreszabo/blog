---
title: "The pdnsapp - part 1"
date: "2015-07-09T05:59:00"
categories:
  - Proof of Concept
tags:
  - dns
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
  postcode: EBP005
slug: "ebp005_the-pdnsapp-part1.html"
aliases: ['/ebp005']
---

One of my projects called `pdnsapp` is a [Python](https://www.python.org/) based microframework aimed to help develop DNS based applications, very much like [Flask](http://flask.pocoo.org) or [Bottle](http://bottlepy.org/) do for HTTP or like [Lamson](http://lamsonproject.org/) does with SMTP. Like most of the frameworks of this kind it needs an 'application server' to run. This server for `pdnsapp` is currently [PowerDNS](http://www.powerdns.com/). For basic functionality it has no dependencies other than the Python standard libraries.<!--more-->

The framework features:

- **Routing**: nicely maps DNS queries to python functions using easy to understand [python decorators](https://wiki.python.org/moin/PythonDecorators#What_is_a_Decorator).
- **Utilities**: comes with helper classes and functions for easier request processing.
- **Testing**: a near-complete test suite guarantees glitch-free operation of the framework, available for online and offline testing of functions.

## Example: 'Hello World' in pdnsapp:

```python
from dns import match, run
from dnstypes import *

@match(fqdn='hello.end.re', type='TXT')
def hello_world(request):
    return TXT('Hello World!')
    
if __name__ == '__main__':
    run()
```

This script spits back a `TXT` record containing a `Hello World!` string for every DNS query asking for the name `hello.end.re` and type of `TXT` *or* `ANY`.

### Make it work:

- Let PowerDNS run `pdnsapp` as a [PIPE backend](https://doc.powerdns.com/md/authoritative/backend-pipe/) by specifying to launch the pipe backend as well as the original backend(s) and the script name to run `pdnsapp` in file `/etc/powerdns/pdns.d/pdns.local`:

```
[...]
launch=[...],pipe
pipe-command=/etc/powerdns/pdnsapp/pdnsapp.py
```

- Restart PowerDNS. After that you can ask your nameserver to see our new example function working with the command:

```sh
# dig -t txt hello.end.re @127.0.0.1

; <<>> DiG 9.8.4-rpz2+rl005.12-P1 <<>> -t txt hello.end.re @127.0.0.1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 29241
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; WARNING: recursion requested but not available

;; QUESTION SECTION:
;hello.end.re.			IN	TXT

;; ANSWER SECTION:
hello.end.re.		86400	IN	TXT	"Hello World!"

;; Query time: 54 msec
```

## Download and install

Install `pdnsapp` from its [GitHub repo](https://github.com/endreszabo/pdnsapp) by cloning it right in place with the following command:

```
# cd /etc/powerdns
# git clone https://github.com/endreszabo/pdnsapp.git
```

## Okay, but what is it good for?

Simply put: *it brings dynamism to the formerly static world of DNS.* 

It can fulfill tasks from a simple what-is-my-ip-address responder application to an automatic A-PTR address mapper for ISPs handling vast amount of IP addresses or to a more complex, truly stateful DNS based loadbalancing solution that returns IP addresses of the least loaded frontend servers.

### But DNS records are cached for hours or days

Well, DNS itself was designed to be *static*. And by static it means DNS records usually have hours to days time-to-live, thus caching nameservers would not expect a record's value to change within this period. We can make DNS records more dynamic by drastically reducing their TTL.

