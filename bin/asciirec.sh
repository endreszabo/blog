#!/bin/bash

set -o errexit
set -o nounset

if [ $# -gt 0 ]; then
	name=$1; shift
else
	echo -n 'recording name:'; read name
fi

asciinema rec -t $name -w 2.5 /tmp/asciinema-${name}.json

mv /tmp/asciinema-${name}.json $BLOG/static/ar/${name}.json

# stolen from http://stackoverflow.com/questions/26357639/find-last-modified-file-and-get-the-result-in-a-variable
lastpost=$(find $BLOG/content/blog -name "*.markdown" -type f -printf "%Ts %p\n" | sort -n | tail -1 | sed -r -e 's/^[0-9]+ //')

echo "{{< asciinema src=\"$name\" title=\"$name\" >}}" >> $lastpost
sed 's/^  useasciinema: false/  useasciinema: true/' -i $lastpost

echo -e "Rec done, stuff moved and shortcode appended to:\n$lastpost"

