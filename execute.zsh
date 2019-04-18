#!/usr/bin/env zsh

instruction=$1
repo=$2

print $(tput bold)"$instruction $(tput setaf 2)$repo"$(tput sgr0)
repo_dir="$GITHUB_SYNC_DIR/$repo"
case "$instruction" in
  "clone"  )
    ssh_url="git@github.com:$GITHUB_SYNC_ORG/$repo.git"
    git clone "$ssh_url" "$repo_dir" --depth 1
    ;;
  "remove" )
    rm -rf "$repo_dir"
    print "Removed '$repo_dir'"
    ;;
  "fetch"  )
    pushd "$repo_dir"
      is_shallow="$(git rev-parse --is-shallow-repository)"
      print "$repo is shallow: $is_shallow"
      case "$is_shallow" in
        "true" )
          git fetch origin master:master \
            --depth 1 \
            --update-head-ok \
            --force
          ;;
        "false" )
          git fetch origin master:master
          ;;
      esac
    popd
    ;;
esac
