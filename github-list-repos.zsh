#!/usr/bin/env zsh

# $1 - directory where to store a response from GitHub
# $2 - max number of repos to pull
# Sorting is by last updated time

dir=$1
./rmkdir.zsh $dir

per_page_default=200

url="$GITHUB_SYNC_API_REPOS?sort=pushed&per_page=$per_page_default"
page=1

response_headers_f=$(mktemp)
trap "rm -f $response_headers_f" 0 2 3 15

while [[ -n $url ]] {
  out_f=$dir/page-$page.json
  curl $url \
    -H @headers.txt \
    -D $response_headers_f \
    -o $out_f
  url=$(sed -nE 's/^Link: .*<(.+)>; rel="next".*/\1/p' $response_headers_f)
  (( page++ ))
}

# https://developer.github.com/v3/repos/#list-organization-repositories
