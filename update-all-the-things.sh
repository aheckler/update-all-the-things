#!/bin/zsh
#
# Update software installed via CLI.
#
# https://github.com/aheckler/update-all-the-things

############
#  PROMPT  #
############

echo
echo "This script does the following:"
echo
echo " -> brew autoremove"
echo " -> brew update"
echo " -> brew upgrade"
echo " -> brew bundle dump --global --force"
echo " -> tldr --update"
echo " -> npm update --global"
echo

if read -q "?Do you want to continue [y/N]? "; then
else
	echo
	echo
	echo "Operation aborted. Exiting..."
	echo
	exit;
fi

##############
#  LOG FILE  #
##############

CURRENT_DATE=$(date +"%Y%m%d-%H%M%S")

LOG_FILE=${HOME}/Desktop/update-log-${CURRENT_DATE}.txt

echo "Starting updates..." >> ${LOG_FILE}
echo >> ${LOG_FILE}

##############
#  HOMEBREW  #
##############

echo
echo
echo "==> Homebrew"

echo "    Removing unused dependencies"
brew autoremove >> ${LOG_FILE}

echo "    Updating Homebrew and formula list"
brew update >> ${LOG_FILE}

echo "    Updating installed packages"
brew upgrade >> ${LOG_FILE}

echo "    Updating .Brewfile"
brew bundle dump --global --force >> ${LOG_FILE}

echo >> ${LOG_FILE}

##########
#  TLDR  #
##########

echo
echo "==> tldr"

echo "    Updating database"
tldr --update >> ${LOG_FILE}

##########
#  NODE  #
##########

# echo
# echo "==> Node"

# echo "    Checking latest Node LTS version"

# Get the currently installed Node version.
#
# Cuts 2 characterss off the start of the string
# since Node outputs the version as `vXX.XX.XX`.
# INSTALLED_NODE=$(node --version | cut -c 2-)

# Get the latest LTS Node version via `n`.
# LATEST_LTS_NODE=$(n ls-remote lts)

# Compare the two version strings.
# if [[ ${INSTALLED_NODE} == ${LATEST_LTS_NODE} ]]; then
#     echo "    Node is on the latest LTS version. :)"
# else
# 	echo
# 	echo "    #############################################"
#     echo "    #  NODE NEEDS UPDATED TO THE LATEST LTS!!!  #"
# 	echo "    #############################################"
# 	echo
# fi

# echo "    Updating NPM to latest version"
# npm install --global --progress=false npm@latest
#
# echo "    Updating global NPM packages"
# npm update --global --progress=false

##############
#  OPEN LOG  #
##############

echo "ALL DONE!" >> ${LOG_FILE}

open -t ${LOG_FILE}

exit 0;
