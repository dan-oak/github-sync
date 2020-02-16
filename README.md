# GitHub Sync

GitHub Sync clones and updates all repositories from an organization in shallow mode, which significantly reduces
downloaded size, in the same time keeping active repositories on which you are working on with full history and always
latest master branches.

```zsh
./github-sync
```

The same command to update all master branches, remove deleted and archived
repositories.

## Requirements

- Git
- ZSH
- GNU coreutils
  - `date`
  - `cp`
- GNU parallel

See also:
- [How to replace Mac OS X utilities with GNU core utilities?]

## Setup

Copy `src/config.template.zsh` to `src/config.zsh` and fill in the variables.

To create a scheduled task on MacOS modify and use `bin/generate-launchd-plist.zsh` and run
`launchctl load ~/Library/LaunchAgents/dev.danoak.github-sync.plist`.

## See also

- <https://github.com/whiteinge/ok.sh> - A GitHub API client library written in POSIX sh

[How to replace Mac OS X utilities with GNU core utilities?]: https://apple.stackexchange.com/questions/69223/how-to-replace-mac-os-x-utilities-with-gnu-core-utilities
