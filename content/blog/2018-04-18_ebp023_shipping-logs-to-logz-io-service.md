---
tags:
  - logging
categories:
  - Tutorial
params:
  hideTitle: false
  hideMeta: false
  hideComments: false
  hideTOC: true
  postcode: EBP023
  indeximage: logzio-logo.png
slug: "ebp023_shipping-logs-to-logz.io-service"
draft: true

aliases: ["/ebp023"]
Title: "Shipping logs to the logz.io service"
Date: 2018-04-17T09:43:18
---

Some of you may have heard of [Logz.io](https://logz.io/), a yet-another-company that provides *ELK as a Service*.

Let's check 'em out, how uniqe is it, I though to myself.

After registration you are taken to the wiki entry that lets you configure your stuff to ship your logs logz.io ingest servers.

While it looks prettry comprehensive, they evidently missed out the good old Unix player here, `syslog-ng`.

Seeing configuration guides for all these "next-gen", "cloud-native", "serverless" totally hyped piece of craps without mentioning `syslog-ng` at all I feel being kinda old school.

So this post is the missing manual on how to ship logs to logz.io using `syslog-ng`.

Logz.io uses the all-new RFC5424 "The Syslog Protocol" for transporting the messages, but with a little, out of standard exception: you have to prepend all raw messages with a token that identifies your stream.

```
template t_logzio {
	template("[stCycjLkSdMSYyrgTtnJTsGeYawruUJM] <${PRI}>1 $ISODATE $HOST ${PROGRAM} ${PID} - [type=TYPE] ${MSG}\n");
	template_escape(no);
};

destination d_network_logzio {
	network("listener.logz.io" port(5001)
		transport(tls)
		ts-format(rfc3339)
		template(t_logzio)
		flags(no-multi-line)
		tls(
			ca-dir("/etc/syslog-ng/tls/ca.d")
			peer-verify(required-trusted)
			trusted-dn("CN=*.logz.io, OU=PositiveSSL Wildcard, OU=Domain Control Validated")
		)
	);

};

log {
	source(s_base);
	source(s_remote);
#//	source(s_remote-tls);
	destination(d_network_logzio);
};
```

