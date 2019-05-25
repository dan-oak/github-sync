#!/usr/bin/env zsh

# Produce three tab-separated columns:
#   repo names got from GitHub API which are not found locally,
#   repo names which are not present upstream but found locally,
#   repo names which are found from both resources

repos_info_dir=$1
repos_dir=$2
comm \
  <(jq --raw-output '.[].name' $repos_info_dir/* | sort) \
  <(ls $repos_dir)
