#!/bin/sh
hexo g
# msg=`git log -1 --pretty=oneline | awk '{print $2}'`
# sed -i -e "s/msg: [^\]*/msg: $msg/" _config.yml
hexo d