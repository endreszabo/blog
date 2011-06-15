<%page args="post"/>
<div class="post" id="id">
  <a name="${post.slug}"></a>
    <h2 class="title"><a href="${post.permapath()}" rel="bookmark" title="Permanent Link to ${post.title}">${post.title}</a></h2>
    <div class="post-info-top">
      <span class="post-info-date">Posted on ${post.date.strftime("%Y-%m-%d at %H:%M %Z")} | tags: 
<% 
   category_links = []
   for category in post.categories:
       if post.draft:
           #For drafts, we dont write to the category dirs, so just write the categories as text
           category_links.append(category.name)
       else:
           category_links.append("<a href='%s'>%s</a>" % (category.path, category.name))
%>
${", ".join(category_links)}</span>
% if bf.config.blog.disqus.enabled:
	  <span id="gotocomments"><a href="${post.permalink}#disqus_thread" rel="nofollow" title="Go to comments ?">Go to comments</a></span>
% endif
    </div>
    <div class="clear"></div>
    <div class="entry">
      ${self.post_prose(post)}
    </div>
  </div>
<%def name="post_prose(post)">
  ${post.content}
</%def>
