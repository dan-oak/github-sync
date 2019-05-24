# GitHub Sync

How to work locally in your repositories as usual but get all other ones from
your org without cloning the whole git history?

```zsh
zsh github-sync.zsh
```

The same command to update all master branches, remove deleted and archived
repositories.

## Requirements

- Unix
- ZSH
- Git
- GNU coreutils
- GNU parallel

## Setup

`setup.zsh` will guide you through a couple of environment variables to be
set. Alternatively `cp env.template.zsh env.zsh`, edit it and `source env.zsh`.

## See also

- <https://github.com/whiteinge/ok.sh> - A GitHub API client library written
in POSIX sh
