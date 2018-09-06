#!/bin/bash

BLOG=/home/e/src/blog 
POSTCODE=$(printf "ebp%03d" ${1:-$(cat $BLOG/data/blogcounter)})
STATICPATH="${BLOG}/static/p/${POSTCODE}"

echo $POSTCODE

umask 0022

#TMPDIR=$(mktemp -d -p ~/tmp/blog/ -- blogpaste-"${POSTCODE}"-XXXXXX)

mkdir -p "${STATICPATH}" || true
tar xzpvf - -C "${STATICPATH}" 2>&1 | sed -re 's/(.*)/{{< img src="\1" title="\1" class="center" \/>}}/' | tee -a ${BLOG}/content/blog/*_${POSTCODE}_*.md

#echo $TMPDIR

#trap "rm -rv -- ${TMPDIR}" 0
