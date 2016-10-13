#!/bin/bash
#
# Update local package managers.
#
# https://github.com/aheckler/update-all-the-things

################
#  CREATE LOG  #
################

date=$(date +"%Y%m%d-%H%M%S")
log_file=/Users/Adam/Desktop/update-log-$date.txt

echo "Starting updates..." 1>> $log_file
echo 1>> $log_file

##############
#  HOMEBREW  #
##############

echo "==> Homebrew"
echo "    Updating client"
brew update 1>> $log_file

echo "    Updating packages"
brew upgrade 1>> $log_file

echo "    Cleaning up"
brew prune 1>> $log_file
brew cleanup --force 1>> $log_file

# "brew prune" deletes this directory, which breaks MySQL / MariaDB
# https://github.com/Homebrew/legacy-homebrew/issues/31760
mkdir /usr/local/etc/my.cnf.d 1>> $log_file

echo 1>> $log_file

###################
#  HOMEBREW CASK  #
###################

echo "==> Homebrew Cask"
echo "    Cleaning up"
brew cask cleanup 1>> $log_file

echo 1>> $log_file

##########
#  ATOM  #
##########

echo "==> Atom Package Manager"
echo "    Updating packages"
apm update --no-confirm --no-color 1>> $log_file

echo "    Cleaning up"
apm clean --no-color 1>> $log_file
apm dedupe --no-color 1>> $log_file

echo 1>> $log_file

#########
#  NPM  #
#########

echo "==> Node Package Manager"
echo "    Updating global packages"
npm -g update 1>> $log_file

echo 1>> $log_file

##############
#  COMPOSER  #
##############

echo "==> Composer"
echo "    Updating client"
composer self-update 1>> $log_file

echo "    Updating global packages"
composer global update --no-progress 1>> $log_file

echo 1>> $log_file

###############
#  RUBY GEMS  #
###############

echo "==> Ruby Gems"
echo "    Updating sources"
gem sources --update 1>> $log_file

echo "    Updating system"
gem update --system 1>> $log_file

echo "    Updating gems"
gem update 1>> $log_file

echo "    Cleaning up"
gem cleanup --quiet 1>> $log_file

echo 1>> $log_file

##############
#  OPEN LOG  #
##############

echo "ALL DONE!" 1>> $log_file

open -t $log_file

exit 0;
