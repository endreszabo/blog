---
tags:
  - dns
  - firewall
categories:
  - Proof of Concept
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
  postcode: EBP013
slug: "ebp013_filtering-dns-noise-with-netfilter-bpf-matcher"
draft: true
aliases: ["/ebp013"]
Title: "Filtering DNS noise with Netfilter BPF matcher"
Date: 2017-06-08T15:12:21
---
IPv4:

```sh
$ nfbpf_compile RAW 'ip[0x3c:4]&0xfffffffc=0x36d7830 and ip[0x40:4]&0xfffffffc=0x36d7830) or (ip[0x3c:4]=0x3697363 and ip[0x40:4]=0x36f7267) or ip[0x3c:4]=0xff00'
```

IPv6:
```sh
$ nfbpf_compile RAW '(ip6[0x3c:4]&0xfffffffc=0x36d7830 and ip6[0x40:4]&0xfffffffc=0x36d7830) or (ip6[0x3c:4]=0x3697363 and ip6[0x40:4]=0x36f7267) or ip6[0x3c:4]=0xff00'
```

```python
#!/usr/bin/env python2
from sys import argv
from subprocess import Popen, PIPE

def expression(fqdn, ipv6=False):
	chunks=[]
	expressions=[]
	if ipv6:
		offset=0x3c
	else:
		offset=0x28
	#this (appending lists) could be more pythonic
	for part in fqdn.split('.'):
		chunks+=[chr(len(part)), part]
	chunks+="\x00"
	fqdn=''.join(chunks)
	parts=[fqdn[i:i+4] for i in range(0, len(fqdn), 4)]
	for part in parts:
		if ipv6:
			if len(part)==3:
				expressions.append("ip6[0x%x:4]&0x%s00=0x%s00" % (offset, 'ff'*len(part), ''.join(map(lambda x: "%02x" % ord(x), list(part)))))
			else:
				expressions.append("ip6[0x%x:%d]&0x%s=0x%s" % (offset, len(part), 'ff'*len(part), ''.join(map(lambda x: "%02x" % ord(x), list(part)))))
		else:
			if len(part)==3:
				expressions.append("ip[0x%x:4]&0x%s00=0x%s00" % (offset, 'ff'*len(part), ''.join(map(lambda x: "%02x" % ord(x), list(part)))))
			else:
				expressions.append("ip[0x%x:%d]&0x%s=0x%s" % (offset, len(part), 'ff'*len(part), ''.join(map(lambda x: "%02x" % ord(x), list(part)))))
		offset+=4
	return ' and '.join(expressions)

def bpf(expression):
	print expression
	compiler=Popen(['nfbpf_compile','RAW',expression], stdout=PIPE)
	(output, err) = compiler.communicate()
	exit_code = compiler.wait()
	return output.rstrip()

for fqdn in argv[1:]:
	print("iptables  -m comment --comment '%s' -m bpf --bytecode '%s'" % (fqdn, bpf(expression(fqdn))))
	print("ip6tables -m comment --comment '%s' -m bpf --bytecode '%s'" % (fqdn, bpf(expression(fqdn, ipv6=True))))

```

