# Update All The Things

A simple ZSH script I use for updating software installed via CLI.

Currently, it does the following:

- Removes unused Homebrew dependencies with `brew autoremove`.
- Updates Homebrew and the formula list with `brew update`.
- Upgrades all Homebrew packages with `brew upgrade`.
- Writes a .Brewfile with `brew bundle dump --global --force`.
- Checks for newer Node LTS versions via `n ls-remote lts`.
- Updates global Node packages with `npm update --global`.

Most output is written to a log file and placed on the Desktop.
