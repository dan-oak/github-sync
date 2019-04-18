#!/usr/bin/env zsh

set -e
. ./assert-env.zsh

mkdir -p $GITHUB_SYNC_DIR

# For debug purposes
github_repos_response_d=./github-repos-response
github_repos_name_f=./github-repos-name.txt
local_repos_name_f=./local-repos-name.txt
comm_f=./comm.txt
instructions_f=./instructions.txt

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
