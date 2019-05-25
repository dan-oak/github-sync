# GitHub Sync

GitHub Sync clones and updates all repositories from an organization in shallow mode, which significantly reduces downloaded size, in the same time keeping active repositories on which you are working on with full history and always latest master branches.

Setup guide included on the first run:

```zsh
./github-sync
```

The same command to update all master branches, remove deleted and archived
repositories.

## Requirements

Unix, ZSH, Git, GNU coreutils, GNU parallel

## Setup

`bin/setup.zsh` will guide you through a couple of environment variables to be
set. Alternatively `cp bin/env.template.zsh bin/env.zsh`, edit it and
`source bin/env.zsh`.

## See also

- <https://github.com/whiteinge/ok.sh> - A GitHub API client library written
in POSIX sh
