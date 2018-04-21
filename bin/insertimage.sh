#!/bin/bash

set -o errexit
set -o nounset
shopt -s nullglob

MAXSIZE=1200
MAXTNSIZE=480

POSTSDIR="${BLOG}/content/blog"
POSTFILE=$(find "${POSTSDIR}" -type f -printf "%T@\t%f\n" | sort -nr | head -1 | cut -d$'\t' -f2 | sed -re 's/\..*//')
SLUG=$(find "${POSTSDIR}" -type f -printf "%T@\t%f\n" | sort -nr | head -1 | cut -d$'\t' -f2 | cut -d_ -f2)
DESTDIR="${BLOG}/static/p/${SLUG}"

error() {
	echo $0: $1 - $2
	notify-send -a newpostimage.sh -u low -t 30000 $1 $2
	exit 1
}

if [ $# -gt 0 ]; then
	FN=$1; shift
else
	error fail "Needed filename argument not found"
fi

BFN=$(basename "$FN")
DFN="${DESTDIR}/${BFN}"
TNDFN="${DESTDIR}/tn_${BFN}"

# fixme

mkdir -pv -- ${DESTDIR}
cp -pv -- "${FN}" "${DFN}_tmp"

jhead -ft -dt -autorot -de "${DFN}_tmp" || true
convert -resize ">$MAXSIZE" "${DFN}_tmp" "${DFN}"
convert -resize ">$MAXTNSIZE" "${DFN}_tmp" "${TNDFN}"

echo "{{< img $BFN >}}" # >> "${POSTSDIR}/${POSTFILE}.md"
#echo "{{< img $BFN >}}"# >> "${POSTSDIR}/${POSTFILE}.hu.md"
#echo "{{< img $BFN >}}" >> "${POSTSDIR}/${POSTFILE}"

