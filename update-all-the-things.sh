#!/usr/local/bin/bash
clear

date=$(date +"%Y%m%d-%H%M%S")
log_file=~/Desktop/update-log-$date.txt

echo "Starting updates..."
echo

echo "==> OS X"
echo "    Updating applications"
sudo softwareupdate -i -a &>> $log_file
echo

echo "==> Homebrew"
echo "    Updating client"
brew update &>> $log_file
echo "    Updating packages"
brew upgrade --all &>> $log_file
echo "    Cleaning up"
brew prune &>> $log_file
brew cleanup --force &>> $log_file
echo

echo "==> Homebrew Cask"
echo "    Cleaning up"
brew cask cleanup &>> $log_file
echo

echo "==> Atom Package Manager"
echo "    Updating packages"
apm update --no-confirm --no-color &>> $log_file
echo "    Cleaning up"
apm clean --no-color &>> $log_file
apm dedupe --no-color &>> $log_file
echo

echo "==> Node Package Manager"
echo "    Updating global packages"
npm -g update &>> $log_file
echo

echo "==> Composer"
echo "    Updating client"
composer self-update &>> $log_file
echo

exit 0
