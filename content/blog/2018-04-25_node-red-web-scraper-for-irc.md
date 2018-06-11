---
tags:
  - node-red
  - irc
categories:
  - Proof of Concept
params:
  hideTitle: false
  hideMeta: false
  hideComments: false
  hideTOC: true
  postcode: EBP031
slug: "ebp031_node-red-web-scraper-for-irc"
draft: true

aliases: ["/ebp031"]
Title: "Node-RED based webpage title scraper for IRC"
Date: 2018-04-25T07:35:27
---

```js
let msg_size_limit=300;
msg.payload_old=msg.payload;
if (msg.endtag)
    msg.endtag=" \u0002||\u0002 " + msg.endtag;
msg.payload=(
    (msg.tag?"\u0002(("+msg.tag+"))\u0002 ":'')+
    (msg.retval.filter(f=>f).join(" \u0002||\u0002 "))
).replace(/\n/gm," ");
if (msg.payload.length>msg_size_limit-msg.endtag.length-1)
    msg.payload=msg.payload.substr(0,msg_size_limit-msg.endtag.length)+"…";
msg.payload+=msg.endtag;
msg.topic=msg.to;
return msg;
```
