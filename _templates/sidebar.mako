					<div class="widget">
						<h3>Twitter</h3>
						<script src="${bf.util.site_path_helper(bf.config.blog.path,'/t.js')}" type="text/javascript"></script>
						<script type="text/javascript" charset="utf-8">
							getTwitters('tweet', {
								id: '${bf.config.tweets.username}',
								count: ${bf.config.tweets.count},
								enableLinks: ${bf.config.tweets.enable_links},
								ignoreReplies: ${bf.config.tweets.ignore_replies},
								clearContents: true,
								template: '${bf.config.tweets.template}',
								});
						</script>
						<div id="tweet" class="clear"></div>
					</div>
					<div class="widget">
						<h3>Flickr</h3>
						<div id="flickr_badge_wrapper"></div>
						<script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?count=9&display=random&size=s&layout=x&source=user&user=61422562%40N03"></script>
						</p>
					</div>
					<%doc>
					<div class="widget">
						<h3>Random stuff</h3>
						<ul>
							<li>1</li>
							<li>2</li>
							<li>3</li>
							<li>4</li>
						</ul>
					</div></%doc>
