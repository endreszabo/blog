# -*- coding: utf-8 -*-
site.url = "http://end.re"
blog = controllers.blog
blog.enabled = True
blog.path = ""
#blog.name = u"“we live in a fantastic era”"
blog.name = u"end.re"
blog.description = u"endre is sharing his blog with you"
blog.timezone = "UTC"
blog.disqus.enabled = True
blog.disqus.name = "endreszabo"
blog.post_excerpts.enabled=True
blog.post_excerpts.word_length = 25
blog.pagination_dir = "page"
blog.custom_index = False
controllers.tweets.enabled = True
tweets = controllers.tweets
tweets.username = "endre"
tweets.count = 6
tweets.enable_links = 'true'
tweets.ignore_replies = 'false'
tweets.template = ('%text% <a href="http://twitter.c'
	'om/%user_screen_name%/statuses/%id%/">%time%</a>')
