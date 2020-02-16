#!/usr/bin/env zsh

function rmkdir {
  [ -d $1 ] && rm -rf $1
  mkdir -p $1
}

(( # != 0 )) && rmkdir $@
