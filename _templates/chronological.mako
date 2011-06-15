<%! no_sidebar=0 %><%inherit file="site.mako" />
% for post in posts:
  <%include file="post.mako" args="post=post" />
% endfor
% if prev_link or next_link:
	<div id="pagination">
% endif
% if prev_link:
 <a href="${prev_link}">« Previous Page</a>
% endif
% if prev_link and next_link:
 | 
% endif
% if next_link:
 <a href="${next_link}">Next Page »</a>
% endif
% if prev_link or next_link:
	</div>
% endif
