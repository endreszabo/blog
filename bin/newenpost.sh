#!/bin/bash

set -o errexit
set -o nounset
shopt -s nullglob

if [ $# -gt 0 ]; then
	title=$1; shift
else
	echo -n 'post title: '; read title
fi

POSTSDIR="${BLOG}/content/blog"
TODAY="$(date +"%Y-%m-%dT%H:%M:%S")"
SLUG="$(echo "$title" | sed -e 's/\(.*\)/\L\1/' -e 's/ /-/g')"
FN="$POSTSDIR/${TODAY%%T*}_${SLUG}"
POSTS=($POSTSDIR/*.{md,markdown})
POSTCODE=$(printf "%03d" $((${#POSTS[*]} + 1)))

cat \
	<(echo ---) \
	<(grep -v '^---' $BLOG/archetypes/blog.md | sed -re "s/^(slug: \"ebp)000_\"/\1${POSTCODE}_${SLUG}\"/" -e "s/^(  postcode: EBP)000/\1${POSTCODE}/") \
	<(echo "aliases: [\"/ebp${POSTCODE}\"]") \
	<(echo "$title" | sed -e 's/^/Title: "/' -e 's/$/"/') \
	<(echo "Date: ${TODAY}") \
	<(echo ---) \
	> ${FN}.md 

vimdiff "${FN}".md

