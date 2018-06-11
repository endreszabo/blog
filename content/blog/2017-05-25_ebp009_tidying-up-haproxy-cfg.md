---
tags:
  - haproxy
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
#  importHighlight: true
#  importAsciinema: true
  postcode: EBP009
  indeximage: terrific.jpg
slug: "ebp009_tidying-up-haproxy.cfg"
draft: true
aliases: ["/ebp009"]
Title: "Tidying up haproxy.cfg"
Date: 2017-05-25T10:18:12
---
I made a little perl script that I can keep `haproxy.cfg` nice and tidy with. This script lets you not only separate config file parts into `conf.d`-like files but provides some simple, yet useful Jinja2 like `{{templating|function}}`s as well as the ability to transparently join multiple lines the right way just as it should have been done from the beginning of time. In this Let's Encrypt-heated encrypt-everything-era this script also comes handy when one have to deal with enormous amount of TLS certificates. Lorem ipsum dolor sit amet kasdf emwmfwos smdmwe sdlwe sd fkekw s, asdfmwe  asdf from sunshine asdf  kaskdfk asdfk wjf jwjakkasd fkef .<!--more-->

```perl
#!/usr/bin/env perl
use strict;
use warnings;

# template function
sub certlist($){
    my $dir=shift;
    opendir(my $dh, '/etc/haproxy/'.$dir) || die "Can't open TLS dir '$dir': $!";
    my @certs = grep{/-bundle$/}readdir($dh);
    my $certlist = join(' ',map{$_="crt /etc/haproxy/$dir/".$_} @certs);
    if (-e $dir.'/ca.cer') {
        $certlist.=' ca-file /etc/haproxy/'.$dir.'/ca.cer';
    }
    closedir $dh;
    return $certlist;
}

my $ls=0;
while(<>) {
    s/^ {4,8}/\t/;
    s/\{\{ *tls *\| *([\S\/]+) *\}\}/certlist($1)/e;
    s/^[\t\s]+/ / if $ls;
    if (m/\\$/) {
        s/\s*[\\\r\n]+$//;
        $ls=1;
    } else {
        $ls=0;
    }
    print;
}
```
