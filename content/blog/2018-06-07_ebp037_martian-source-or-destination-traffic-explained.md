---
tags:
  - networking
  - linux
categories:
  - Proof of Concept
params:
  hideTitle: false
  hideMeta: false
  hideComments: false
  hideTOC: true
  postcode: EBP037
slug: "ebp037_martian-source-or-destination-traffic-explained"
aliases: ["/ebp037", "/martian"]
Title: "Linux Kernel Martian Source Logs Explained"
Date: 2018-06-07T08:39:19
---

Quite a bit of our customers' IT guys happen to misinterpret the real meaning of the martian source traffic logs they see on their gateway hosts.

<textarea id="martian-logs" style="width:100%;height:8em;" placeholder="Paste your logs here, then click button below to explain them." onChange="martian_explainer('martian-logs', 'martian-logs-explained');"></textarea>

<input type="button" style="text-align:center" value="Explain those logs to me!" onclick="martian_explainer('martian-logs', 'martian-logs-explained');" />

<div style="background: #ddd;padding:0 5px 0 5px;" id="martian-logs-explained">Paste your logs in the above area and see their explanations here.</div>

<script src="/js/martian-explainer.js"></script>

