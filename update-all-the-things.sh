#!/bin/bash
#
# Update local package managers.
#
# https://github.com/aheckler/update-all-the-things

################
#  CREATE LOG  #
################

CURRENT_DATE=$(date +"%Y%m%d-%H%M%S")

LOG_FILE=${HOME}/update-log-${CURRENT_DATE}.txt

echo "Starting updates..." 1>> ${LOG_FILE}
echo 1>> ${LOG_FILE}

##############
#  HOMEBREW  #
##############

echo "==> Homebrew"
echo "    Updating client"
brew update 1>> ${LOG_FILE}

echo "    Updating packages"
brew upgrade 1>> ${LOG_FILE}

echo "    Cleaning up"
brew prune 1>> ${LOG_FILE}
brew cleanup --force 1>> ${LOG_FILE}

# "brew prune" deletes this directory, which breaks MySQL / MariaDB
# https://github.com/Homebrew/legacy-homebrew/issues/31760
#
# Commenting this out since I don't have MySQL or MariaDB on my new laptop
#
# mkdir /usr/local/etc/my.cnf.d 1>> ${LOG_FILE}

echo 1>> ${LOG_FILE}

###################
#  HOMEBREW CASK  #
###################

echo "==> Homebrew Cask"
echo "    Cleaning up"
brew cask cleanup 1>> ${LOG_FILE}

echo 1>> ${LOG_FILE}

##########
#  ATOM  #
##########

echo "==> Atom Package Manager"
echo "    Updating packages"
apm upgrade --no-confirm --no-color 1>> ${LOG_FILE}

echo 1>> ${LOG_FILE}

#########
#  NPM  #
#########

echo "==> Node Package Manager"
echo "    Updating global packages"
npm update --global --progress false 1>> ${LOG_FILE}

echo 1>> ${LOG_FILE}

##########
#  YARN  #
##########

echo "==> Yarn"
echo "    Clearing package cache"
yarn cache clean 1>> ${LOG_FILE}

echo "    Updating global packages"
yarn global upgrade 1>> ${LOG_FILE}

echo 1>> ${LOG_FILE}

##############
#  COMPOSER  #
##############

echo "==> Composer"
echo "    Updating client"
composer self-update --quiet 1>> ${LOG_FILE}

echo "    Updating global packages"
composer global update --no-progress --quiet 1>> ${LOG_FILE}

echo 1>> ${LOG_FILE}

#########
#  PIP  #
#########

# Need to do some trickery here since pip doesn't
# have a way to upgrade all packages at once.
echo "==> PIP"
echo "    Updating packages"
pip3 install --quiet --upgrade $(pip3 list --outdated --format=json | jq -r .[].name | tr '\n' ' ') 1>> ${LOG_FILE}

##############
#  BREWFILE  #
##############

echo "==> Updating .Brewfile"
brew bundle dump --global --force 1>> ${LOG_FILE}

##############
#  OPEN LOG  #
##############

echo "ALL DONE!" 1>> ${LOG_FILE}

open -t ${LOG_FILE}

exit 0;
