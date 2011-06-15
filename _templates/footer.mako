			<div id="footer-inside"><% from datetime import datetime %>
				<p>
					Copyright&nbsp;&copy;&nbsp;${datetime.utcnow().strftime("%Y")}&nbsp;Endre Szabó
					&nbsp;|&nbsp;Rendered by <a href="http://www.blogofile.com">Blogofile</a>
					&nbsp;|&nbsp;Ported theme <a href="http://zww.me" title="designed by zwwooooo">zBench</a>
					&nbsp;|&nbsp;RSS for <a href="${bf.util.site_path_helper(bf.config.blog.path,'feed')}">entries</a>
% if bf.config.blog.disqus.enabled:
					and <a href="http://${bf.config.blog.disqus.name}.disqus.com/latest.rss">comments</a>
% endif
				</p>
				<span id="back-to-top">&Delta; <a href="#nav" rel="nofollow" title="Back to top">Top</a></span>
% if bf.config.blog.disqus.enabled:
				<script type="text/javascript">
					//<![CDATA[
					(function() {
						var links = document.getElementsByTagName('a');
						var query = '?';
						for(var i = 0; i < links.length; i++) {
							if(links[i].href.indexOf('#disqus_thread') >= 0) {
								query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
							}
						}
						document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/${bf.config.blog.disqus.name}/get_num_replies.js'+query+'"></'+'script>');
					})();
					//]]>
			</script>
% endif
