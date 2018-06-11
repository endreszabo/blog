---
tags:
  - nginx
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
  postcode: EBP006
  importHighlight: true
  importAsciinema: false
slug: "ebp006_nginx-as-a-general-purpose-tcp-proxy"
draft: false
aliases: ["/ebp006"]
Title: "Nginx as a general purpose TCP proxy"
Date: 2011-07-18T11:00:18
---

Nginx is well known for its powerful HTTP reverse-proxy features. Altough Nginx does its job well in pretty lot of situations, there are always a need for a general TCP proxy stuff. Sadly this feature does not come boundled in with the stock Nginx.

This is where 3rd party patches come in. There are quite some great patches out there, in this post I will write about `nginx_tcp_proxy_module` made by [Weibin Yao](https://github.com/yaoweibin) from China (he has 13 different promising patches and modules for nginx, definitely worth a check).

Similarly to http upstreaming, this module also lets you use more that one upstream real-servers, with the ability to health-check every real-server with a protocol choice of:

* SMTP,
* SSL hello packet,
* HTTP (with response code checking),
* MySQL,
* POP3,
* IMAP,
* ... and general TCP handshake.

A simple tcp proxy configuration entry looks like this (taken from README):

```
tcp {

    upstream cluster {
        # simple round-robin
        server 192.168.0.100:3306;
        server 192.168.0.101:3306;

        check interval=3000 rise=2 fall=5 timeout=1000;

        #check interval=3000 rise=2 fall=5 timeout=1000 type=ssl_hello;
        #check interval=3000 rise=2 fall=5 timeout=1000 type=http;
        #check_http_send "GET / HTTP/1.0\r\n\r\n";
        #check_http_expect_alive http_2xx http_3xx;
    }

    server {
        listen 8888;
        proxy_pass cluster;
    }
}
```

