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

# Commenting out these lines because I've installed
# Node and NPM via n (https://github.com/tj/n) now,
# and I didn't have any global packages anyway. :)

# echo "==> Node Package Manager"
# echo "    Updating NPM"
# npm install --global --progress false npm@latest 1>> ${LOG_FILE}
#
# echo "    Updating global packages"
# npm update --global --progress false 1>> ${LOG_FILE}
#
# echo 1>> ${LOG_FILE}

##########
#  YARN  #
##########

# Commenting this out because I never use Yarn.

# echo "==> Yarn"
# echo "    Clearing package cache"
# yarn cache clean 1>> ${LOG_FILE}
#
# echo "    Updating global packages"
# yarn global upgrade 1>> ${LOG_FILE}
#
# echo 1>> ${LOG_FILE}

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

echo "==> PIP"
echo "    Updating client"
pip install --quiet --upgrade pip 1>> ${LOG_FILE}

echo "    Updating packages"

# Need to do some trickery here since pip doesn't
# have a way to upgrade all packages at once, and
# it returns an error if there's nothing to update.

PIP_OUTDATED_PKGS=$(pip3 list --outdated --format=json | jq -r .[].name)
if [[ -z "PIP_OUTDATED_PKGS" ]]; then
	pip install --quiet --upgrade $(pip3 list --outdated --format=json | jq -r .[].name | tr '\n' ' ') 1>> ${LOG_FILE}
fi

############
#  WP-CLI  #
############

echo "==> WP-CLI"

# WP-CLI is installed by Homebrew,
# so no need to update here.

# echo "    Updating WP-CLI"
# wp cli update --yes 1>> ${LOG_FILE}

echo "    Updating packages"
wp package update 1>> ${LOG_FILE}

echo 1>> ${LOG_FILE}

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
