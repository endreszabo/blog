# Default to build css, and html and push to staging server
all: staging
# Tiers
prod: render_webpage install_prod
staging: render_webpage install_staging
pgnd: render_css pgnd_server
#
render_webpage: render_css render_html
pgnd_server:
	hugo server --bind 0.0.0.0 --verbose --baseURL http://127.0.0.1:1313/ --log --i18n-warnings --buildDrafts --buildFuture
install_staging:
	./deploy.sh staging
install_prod:
	./deploy.sh prod
render_css:
	scss -r compass -t compressed themes/hugo-theme-end.re/sass/screen.scss static/css/screen.css
render_html:
	hugo --log --verbose --i18n-warnings --cleanDestinationDir

