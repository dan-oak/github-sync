# GitHub Sync – `git clone` for a GitHub Organization

GitHub Sync is a ZSH script to clone or pull all GitHub repositories from any organization.

It was written because I had to use simple Unix tools like `grep` on most of the repositories in a company I worked, which was more than 1K and some of them weighted gigabytes.

There are a bunch of examples out there about how to do just `git clone` in an one-liner, but they all work for small organizations only. See for example: [Stack Overflow](https://stackoverflow.com/questions/19576742/how-to-clone-all-repos-at-once-from-github).

This repo contains an advanced version of those one-liners:
- ✅ **Clone all organization repositories even if your organization has 1K+ of them. As fast as possible, in parralel.**
- ✅ **Clone and pull in [Shallow mode](https://git-scm.com/docs/shallow) if the size of all your repositories is too big.**
- ✅ **Both of the above functionalities are executed with one command which decides which repos to clone, which to pull and which to delete if they no longer exist.**
- ✅ **Configure a repository name patterns to filter.**
- 🤷‍♂️ And if that's not enough, then as a bonus you have **an example of macOS LaunchAgent to execute the cloning and pulling regularly.**

## Install and Use

You need GNU `coreutils` (works with version 8) installed with prefix "g" and GNU `parralel` (works with version 20191122). E.g. on macOS: `brew install coreutils parralel`.

Copy `src/config.template.zsh` to `src/config.zsh` and fill in the variables, your GitHub API token to use for the script, and filters if any needed.

To create a scheduled task on MacOS modify and use `bin/generate-launchd-plist.zsh` and run it, e.g. `launchctl load ~/Library/LaunchAgents/dev.danoak.github-sync.plist`.

Any form of constructive feedback or suggestions are welcomed in [Issues](https://github.com/danylo-dubinin/github-sync/issues).
