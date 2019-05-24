#!/usr/bin/env zsh

set -e

pushd $(dirname $(greadlink -f $0))
. ./env.zsh
. ./assert-env.zsh

mkdir -p $GITHUB_SYNC_DIR

data_d=../data
github_repos_response_d=$data_d/github-repos-response
github_repos_name_f=$data_d/github-repos-name.txt
local_repos_name_f=$data_d/local-repos-name.txt
comm_f=$data_d/comm.txt
instructions_f=$data_d/instructions.txt

# --------------------------------------------------------------------------- #

# List GitHub repos
./github-list-repos.zsh $github_repos_response_d

# Extract names of active repos
./extract.zsh $github_repos_response_d/* >$github_repos_name_f

# List local repos
ls $GITHUB_SYNC_DIR >$local_repos_name_f

# Compare GitHub and local repos
gcomm $github_repos_name_f $local_repos_name_f >$comm_f

# Prepare fetch/clone/remove instructions
./instruct.zsh <$comm_f >$instructions_f

# Execute instructions in parallel
parallel -a $instructions_f --colsep ' ' ./execute.zsh

popd