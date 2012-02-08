<%inherit file="base.mako" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head profile="http://gmpg.org/xfn/11">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		${self.head()}
	</head>
	<body>
		<div id="nav"><%doc>
			<div id="menus">
				<ul><li class="current_page_item"><a href="/">Blog</a></li></ul>
				<ul><li><a href="#">About</a></li></ul>
			</div></%doc>
			<div id="search">
				<script type="text/javascript">
					function Gsitesearch(curobj){curobj.query.value="site:end.re "+curobj.query.value}
				</script>
				<form id="searchform" action="http://www.google.com/search" method="get" onSubmit="Gsitesearch(this)">
					<input type="query" value="Search: type, hit enter" onfocus="if (this.value == 'Search: type, hit enter') {this.value = '';}" onblur="if (this.value == '') {this.value = 'Search: type, hit enter';}" size="35" maxlength="50" name="query" id="s" />
					<!--<input name="q" type="hidden" /> -->
					<!--<input type="submit" value="Search" />-->
					<input type="submit" id="searchsubmit" value="" />
				</form>
			</div>
		</div>
		<div id="wrapper">
			<div id="header">
				<h1><a href="/">${bf.config.blog.name}</a></h1>
				<h2>${bf.config.blog.description}</h2>
				<div class="clear"></div><%doc>
				<!-- place of header image once i find a good one
				<div id="header_image">
					<div id="header_image_border">
						<img src="" width="" height="" alt="" />
					</div>
				</div></%doc>
			</div>
			<hr />
			<div id="content">
				${self.header()}
				${next.body()}
			</div> <!-- End Content -->
% if not self.attr.no_sidebar:
			<div id="sidebar-border">
				<div id="rss"><a href="${bf.util.site_path_helper(bf.config.blog.path,'/feed')}" rel="nofollow" title="RSS Feed">RSS Feed</a></div>
				<div id="sidebar">
					${self.sidebar()}
				</div>
			</div>
% endif
		</div>
		<div class="clear"></div>
		<div id="footer">
			${self.footer()}
		</div> <!-- End Footer -->
	</body>
</html>
<%def name="head()">
  <%include file="head.mako" />
</%def>
<%def name="header()">
  <%include file="header.mako" />
</%def>
<%def name="footer()">
  <%include file="footer.mako" />
</%def>
<%def name="sidebar()">
  <%include file="sidebar.mako" />
</%def>

