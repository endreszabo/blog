# defaults
CSS=/a/s.css
# Default to build css, and html and push to staging server
all: staging
render_webpage: render_css render_html
render_prod_webpage: render_css render_prod_html
minimize: minify_text gzip_text remove_backups
optimize_static: optimize_images
# Tiers
prod:                 clean render_prod_webpage minimize install_prod
staging:              clean render_webpage      minimize install_staging
staging_nonminimized: clean render_webpage               install_staging
pgnd: render_css_uncompressed pgnd_server
#preparing
clean:
	rm -r public/ && mkdir public
#deploying
pgnd_server:
	hugo server --bind 0.0.0.0 --verbose --baseURL http://127.0.0.1:1313/ --log --i18n-warnings --buildDrafts --buildFuture
install_staging:
	bin/deploy.sh staging
install_prod:
	bin/deploy.sh prod
#source handling
render_css:
	#scss -r compass themes/hugo-theme-end.re/sass/screen.scss static$(CSS)
	#scss themes/hugo-theme-end.re/sass/screen.scss static$(CSS)
	sassc -t compressed themes/hugo-theme-end.re/sass/screen.scss static$(CSS)
render_css_uncompressed:
	#scss -r compass themes/hugo-theme-end.re/sass/screen.scss static$(CSS)
	#scss themes/hugo-theme-end.re/sass/screen.scss static$(CSS)
	sassc themes/hugo-theme-end.re/sass/screen.scss static$(CSS)
render_prod_html:
	hugo --log --verbose --i18n-warnings --cleanDestinationDir --baseURL https://end.re
render_html:
	hugo --log --verbose --i18n-warnings --cleanDestinationDir
minify_text:
	minify -v -r public/ -o public/
gzip_text:
	#FIXME: WTF is happening with print0 (no css or js compressed)
	#find public/ -type f -iname \*.html -or -iname \*.css -or -iname \*.js -or -iname \*.xml -print0 | xargs --null --no-run-if-empty --verbose gzip -9vk --
	find public/ -type f -iname \*.html -or -iname \*.css -or -iname \*.js -or -iname \*.xml -or -iname \*.svg | xargs --null -d $$'\n' --no-run-if-empty --verbose gzip -9vk --
#gzip actually keeps mod time needed by nginx to check if 'content is the same'
#IFS=$$'\0' find public/ -type f -iname \*.html -or -iname \*.css -or -iname \*.js -or -iname \*.xml| while read fn;do gzip -9vk -- "$$fn" && touch -r "$$fn" "$${fn}.gz";done
# Misc stuff
remove_backups:
	find public/ -type f -iname \*.bak -delete
optimize_images:
	find static/ -type f -iname \*.gif -or -iname \*.png | xargs --null --delimiter=$$'\n' --max-args=1 --no-run-if-empty --verbose optipng -v -preserve -backup -o7 || true
git_prepare:
	cp .gitignore.head .gitignore
	grep -rlie '^draft: true' -- content/blog/ >> .gitignore
git_commit:
	git add -A .
	git commit
git: git_prepare git_commit
