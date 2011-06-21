% if post and hasattr(post, "title"):
		<title>${post.title} :: ${bf.config.blog.name}</title>
% elif hasattr(self, 'page_title'):
		<title>${self.page_title} :: ${bf.config.blog.name}</title>
% else:
		<title>${bf.config.blog.name}</title>
% endif		
		<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="${bf.util.site_path_helper(bf.config.blog.path,'/feed')}" />
		<link rel="alternate" type="application/atom+xml" title="Atom 1.0" href="${bf.util.site_path_helper(bf.config.blog.path,'/feed/atom')}" />
		<link rel='stylesheet' href="${bf.util.site_path_helper(bf.config.blog.path,'/c.css')}" type="text/css" />
