#!/bin/bash
#
# Update local package managers.
#
# https://github.com/aheckler/update-all-the-things

################
#  CREATE LOG  #
################

CURRENT_DATE=$(date +"%Y%m%d-%H%M%S")

LOG_FILE=${HOME}/Desktop/update-log-${CURRENT_DATE}.txt

echo "Starting updates..." 1>> ${LOG_FILE}
echo 1>> ${LOG_FILE}

##############
#  HOMEBREW  #
##############

if [[ $(command -v brew) ]]; then
	echo "==> Homebrew"
	echo "    Updating client"
	brew update 1>> ${LOG_FILE}

	echo "    Updating packages"
	brew upgrade 1>> ${LOG_FILE}

	echo "    Cleaning up"
	brew prune 1>> ${LOG_FILE}
	brew cleanup 1>> ${LOG_FILE}

	echo 1>> ${LOG_FILE}
else
	echo "==> Skipping Homebrew, not installed"
fi

##########
#  ATOM  #
##########

if [[ $(command -v apm) ]]; then
	echo "==> Atom Package Manager"
	echo "    Updating packages"
	apm upgrade --no-confirm --no-color 1>> ${LOG_FILE}

	echo 1>> ${LOG_FILE}
else
	echo "==> Skipping Atom, not installed"
fi

#########
#  NPM  #
#########

if [[ $(command -v npm) ]]; then
	echo "==> Node Package Manager"
	echo "    Updating NPM"
	npm install --global --progress false npm@latest 1>> ${LOG_FILE}

	echo "    Updating global packages"
	npm update --global --progress false 1>> ${LOG_FILE}

	echo 1>> ${LOG_FILE}
else
	echo "==> Skipping NPM, not installed"
fi

##########
#  YARN  #
##########

if [[ $(command -v yarn) ]]; then
	echo "==> Yarn"
	echo "    Clearing package cache"
	yarn cache clean 1>> ${LOG_FILE}

	echo "    Updating global packages"
	yarn global upgrade 1>> ${LOG_FILE}

	echo 1>> ${LOG_FILE}
else
	echo "==> Skipping Yarn, not installed"
fi

##############
#  COMPOSER  #
##############

if [[ $(command -v composer) ]]; then
	echo "==> Composer"
	echo "    Updating client"
	composer self-update --quiet 1>> ${LOG_FILE}

	echo "    Updating global packages"
	composer global update --no-progress --quiet 1>> ${LOG_FILE}

	echo 1>> ${LOG_FILE}
else
	echo "==> Skipping Composer, not installed"
fi

#########
#  PIP  #
#########

if [[ $(command -v pip) ]]; then
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
else
	echo "==> Skipping PIP, not installed"
fi

############
#  WP-CLI  #
############

if [[ $(command -v wp) ]]; then
	echo "==> WP-CLI"

	# WP-CLI is installed by Homebrew,
	# so no need to update here.

	# echo "    Updating WP-CLI"
	# wp cli update --yes 1>> ${LOG_FILE}

	echo "    Updating packages"
	wp package update 1>> ${LOG_FILE}

	echo 1>> ${LOG_FILE}
else
	echo "==> Skipping WP-CLI, not installed"
fi

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
