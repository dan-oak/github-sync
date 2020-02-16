#!/usr/bin/env zsh

while {read -r l} {
  if (($(FILTER $l))) {
    print $l
  }
}
