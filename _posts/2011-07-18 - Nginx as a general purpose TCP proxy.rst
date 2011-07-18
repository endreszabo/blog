---
Title: Nginx as a general purpose TCP proxy
Date: 2011/07/18 21:16:00
---
Nginx is well known for its powerful HTTP reverse-proxy features. Altough Nginx does its job well in pretty lot of situations, there are always a need for a general TCP proxy stuff. Sadly this feature does not come boundled in with the stock Nginx.

This is where 3rd party patches come in. There are quite some great patches out there, in this post I will write about ``nginx_tcp_proxy_module`` made by Weibin Yao from China (he has 13 different promising patches and modules for nginx, definitely worth a check).

Similarly to http upstreaming, this module also lets you use more that one upstream real-servers, with the ability to health-check every real-server with a protocol choice of:

- smtp,
- ssl hello packet,
- http (with response code checking),
- mysql,
- pop3,
- imap and general tcp handshake.

A simply tcp proxy configuration entry looks like this (taken from README):

::

    tcp {

        upstream cluster {
            # simple round-robin
            server 127.0.0.1:3306;
            server 127.0.0.1:1234;

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


