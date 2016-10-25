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
mkdir /usr/local/etc/my.cnf.d 1>> ${LOG_FILE}

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

##############
#  COMPOSER  #
##############

echo "==> Composer"
echo "    Updating client"
composer self-update --quiet 1>> ${LOG_FILE}

echo "    Updating global packages"
composer global update --no-progress --quiet 1>> ${LOG_FILE}

echo 1>> ${LOG_FILE}

###############
#  RUBY GEMS  #
###############

echo "==> Ruby Gems"
echo "    Updating sources"
gem sources --update 1>> ${LOG_FILE}

echo "    Updating system"
gem update --system 1>> ${LOG_FILE}

echo "    Updating gems"
gem update 1>> ${LOG_FILE}

echo "    Cleaning up"
gem cleanup --quiet 1>> ${LOG_FILE}

echo 1>> ${LOG_FILE}

##############
#  OPEN LOG  #
##############

echo "ALL DONE!" 1>> ${LOG_FILE}

open -t ${LOG_FILE}

exit 0;
