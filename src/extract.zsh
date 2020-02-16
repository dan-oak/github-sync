#!/usr/bin/env zsh

jq --raw-output --from-file extract.jq $@ \
  | sort
