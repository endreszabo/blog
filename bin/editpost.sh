#!/bin/bash

ranger --cmd='sort mtime' --choosefiles=/tmp/rangerfiles $BLOG/content/blog

mapfile files < /tmp/rangerfiles

vimdiff ${files[*]}

rm /tmp/rangerfiles

