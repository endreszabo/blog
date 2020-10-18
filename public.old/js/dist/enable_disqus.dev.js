"use strict";

var enable_disqus = function enable_disqus() {
  var disqus_config = function disqus_config() {
    this.page.url = "https://end.re/{{ lower $.Page.Params.params.postcode }}";
    this.page.identifier = "{{ lower $.Page.Params.params.postcode }}";
  };

  var d = document,
      s = d.createElement('script');
  s.src = 'https://endreszabo.disqus.com/embed.js';
  s.setAttribute('data-timestamp', +new Date());
  (d.head || d.body).appendChild(s);
};