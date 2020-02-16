#!/usr/bin/env zsh

instruction=$1
repo=$2

depth=3

log_ctx=repo=$repo
log $(tput bold)"$instruction $(tput setaf 2)$repo"$(tput sgr0)
repo_dir="$DIR/$repo"

case "$instruction" in
  "clone"  )
    ssh_url="git@github.com:$ORG/$repo.git"
    git clone "$ssh_url" "$repo_dir" --depth $depth |& log
    log "$(tput setaf 244)Status$(tput sgr0)"
    git -C "$repo_dir" status |& log
    ;;
  "remove" )
    mkdir -p "$DIR/.archive"
    cp -r --backup=numbered "$repo_dir" "$DIR/.archive/"
    rm -rf "$repo_dir"
    log "Removed '$repo_dir'"
    ;;
  "fetch"  )
    pushd "$repo_dir"
      is_shallow=$(git rev-parse --is-shallow-repository)
      log "$repo is shallow: $is_shallow"
      branch=$(git rev-parse --abbrev-ref HEAD)
      log "branch: $branch"
      if [[ $branch == "master" ]] {
        log "$(tput setaf 244)Stash$(tput sgr0)"
        git stash --all |& log
        log "$(tput setaf 244)Fetch$(tput sgr0)"
        case "$is_shallow" in
          "true" )
            git fetch origin master:master \
              --depth $depth \
              --update-head-ok \
              --force \
              |& log
            ;;
          "false" )
            git fetch origin master:master \
              --update-head-ok \
              --force \
              |& log
            ;;
          * )
            log "Error"
            ;;;
        esac
        log "$(tput setaf 244)Checkout master$(tput sgr0)"
        git checkout master |& log
        log "$(tput setaf 244)Reset$(tput sgr0)"
        git reset --hard origin/master |& log
      } else {
        log "Skipping: Current branch is not master: $branch"
      }
      log "$(tput setaf 244)Status$(tput sgr0)"
      git status |& log
    popd
    ;;
esac
