#!/usr/bin/env zsh

set -e

profile=${1:-""}

pushd $(dirname $(greadlink -f $0))

fpath=(./fnc $fpath)
autoload \
  log \
  github-list-repos \
  extract \
  filter \
  instruct \
  execute \

. $(which env_parallel.zsh)

if [[ $profile == "" ]] {
  . $(pwd)/config.zsh
} else {
  . $(pwd)/config.${profile}.zsh
}
export GITHUB_SYNC_API_REPOS=https://api.github.com/orgs/$ORG/repos

mkdir -p $DIR
data_d=../data
github_repos_response_d=$data_d/github-repos-response
github_repos_name_f=$data_d/github-repos-name.txt
github_filtered_repos_name_f=$data_d/github-filtered-repos-name.txt
local_repos_name_f=$data_d/local-repos-name.txt
comm_f=$data_d/comm.txt
instructions_f=$data_d/instructions.txt

# --------------------------------------------------------------------------- #

log_ctx=main
log "Working directory: $(pwd)"

log "List GitHub repos"
github-list-repos $github_repos_response_d
log "Saved to $github_repos_response_d"

log "Extract names of active repos"
extract $github_repos_response_d/* >$github_repos_name_f
log "Saved to $github_repos_name_f"

log "Filter names of active repos"
filter <$github_repos_name_f >$github_filtered_repos_name_f
log "Saved to $github_filtered_repos_name_f"

log "List local repos"
ls $DIR >$local_repos_name_f
log "Saved to $local_repos_name_f"

log "Compare GitHub and local repos"
gcomm $github_filtered_repos_name_f $local_repos_name_f >$comm_f
log "Saved to $comm_f"

log "Prepare fetch/clone/remove instructions"
instruct <$comm_f >$instructions_f
log "Saved to $instructions_f"

if ((GITHUB_SYNC_DEBUG)) {
  log "Execute instructions DEBUG"
  while read instruction; do execute ${=instruction}; done < $instructions_f
} else {
  log "Execute instructions in parallel"
  env_parallel \
    --env ORG --env DIR --env execute --env log \
    -a $instructions_f --colsep ' ' execute
}

log_ctx=report
log "Success"
log "Executed instructions: $(wc -l < $instructions_f)"

popd
