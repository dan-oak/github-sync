#!/usr/bin/env zsh

if (($# == 0)) {
  while {read -r l} {
    d=`date --utc '+%Y-%m-%dT%H:%M:%S.%3NZ'`
    if ! [[ $l =~ '^ *$' ]] {
      print -r "$d | $log_ctx | $l"
    }
  }
} else {
  d=`date --utc '+%Y-%m-%dT%H:%M:%S.%3NZ'`
  if ! [[ $@ =~ '^ *$' ]] {
    print -r "$d | $log_ctx | $@"
  }
}
