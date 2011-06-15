---
title: Nginx Alternative Root With Conditional Autoindex
date: 2011/05/02 09:03:00
tags: nginx
categories: nginx
---
I've made the following nginx setup to make my virtual host instance more advanced. It has the following features:

- blogofile "_site" directory served from a completely different directory than the regular htdocs root. Blog content has preference over the other files, so if the requested file is not found in the blog root, it falls back to the regular root.
- there is a feature for conditional autoindexing (I don't like to expse my files by default): if I put a .index file into a directory, it will be autoindexed, otherwise nginx returns a 404 error (as instead on the 403).
- Handles error_page idoms well

So far my development server has this configuration:

::

    server {
        listen [::]:80;
        server_name end.re;
        charset utf-8;
        access_log /var/www/end.re/logs/nginx.log csv-http;
        root /var/www/end.re/blog/_site;
        index index.html index.xml;
        error_page 400 403 404 /error_pages/404.html;
        error_page 500 502 504 /error_pages/500.html;
        error_page 503 /error_pages/503.html;
        autoindex on;
        autoindex_exact_size off;

        recursive_error_pages   off;
        location ~* ^/(404\.html|500\.html|503\.html)$ {
            log_not_found off;
            error_page 404 = @error;
        }
        location /error_pages {
            internal;
        }
        location / {
            try_files $uri $uri/ @fallback;
        }
        location @fallback {
            root /var/www/end.re/htdocs;
            try_files $uri $uri/ @error;
            log_not_found off;
            if (-d $request_filename) {
                set $req D;
            }
            if (!-f $request_filename/.index) {
                set $req "${req}N";
            }
            if (-f $request_filename/index.html) {
                set $req OK;
            }
            if ($req = DN) {
                return 404;
            }
        }
        location @error {
            log_not_found on;
            root /var/www/end.re/blog/_site/error_pages;
        }
    }

Please see my `FuSi rx900 experiences </fusi-rx900/>`_ for a conditinonally autoindexed directory example.
