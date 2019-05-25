#!/usr/bin/env zsh

empty_vars=()
for var (
  GITHUB_SYNC_TOKEN
  GITHUB_SYNC_ORG
  GITHUB_SYNC_DIR
  GITHUB_SYNC_API_REPOS
) if (( ! ${(P)#var} )) empty_vars+=($var)
if (( $#empty_vars > 0 )) {
  print "Please set: ${(j:, :)empty_vars}."
  print "setup.zsh can guide you if needed."
  exit 1
}

# References
# - `${(P)var}` - Parameter name replacement:
#   when `var=x; x=y`, then `${(P)var}` is `y`
#   [stackoverflow](https://stackoverflow.com/a/47842741/2601742)
#   [zsh docs](http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags)
# - `${#var}` - length
# - `${(j:s:)a}` - join all elements of array `a` with string `s`
#    http://zsh.sourceforge.net/Doc/Release/Expansion.html
