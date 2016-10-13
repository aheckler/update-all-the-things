#!/bin/bash

date=$(date +"%Y%m%d-%H%M%S")
log_file=/Users/Adam/Desktop/update-log-$date.txt

echo "Starting updates..." &>> $log_file
echo &>> $log_file

echo "==> Homebrew" &>> $log_file
echo "    Updating client" &>> $log_file
brew update &>> $log_file
echo "    Updating packages" &>> $log_file
brew upgrade &>> $log_file
echo "    Cleaning up" &>> $log_file
brew prune &>> $log_file
brew cleanup --force &>> $log_file
echo &>> $log_file

# "brew prune" deletes this directory, which breaks MySQL / MariaDB
# https://github.com/Homebrew/legacy-homebrew/issues/31760
mkdir /usr/local/etc/my.cnf.d &>> $log_file

echo "==> Homebrew Cask" &>> $log_file
echo "    Cleaning up" &>> $log_file
brew cask cleanup &>> $log_file
echo &>> $log_file

echo "==> Atom Package Manager" &>> $log_file
echo "    Updating packages" &>> $log_file
apm update --no-confirm --no-color &>> $log_file
echo "    Cleaning up" &>> $log_file
apm clean --no-color &>> $log_file
apm dedupe --no-color &>> $log_file
echo &>> $log_file

echo "==> Node Package Manager" &>> $log_file
echo "    Updating global packages" &>> $log_file
npm -g update &>> $log_file
echo &>> $log_file

echo "==> Composer" &>> $log_file
echo "    Updating client" &>> $log_file
composer self-update &>> $log_file
echo "    Updating global packages" &>> $log_file
composer global update --no-progress &>> $log_file
echo &>> $log_file

echo "==> Ruby Gems" &>> $log_file
echo "    Updating sources" &>> $log_file
gem sources --update &>> $log_file
echo "    Updating system" &>> $log_file
gem update --system &>> $log_file
echo "    Updating gems" &>> $log_file
gem update &>> $log_file
echo "    Cleaning up" &>> $log_file
gem cleanup --quiet &>> $log_file
echo &>> $log_file

echo "ALL DONE!" &>> $log_file

open -t $log_file

exit 0;
