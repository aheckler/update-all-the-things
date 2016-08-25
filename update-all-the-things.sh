#!/usr/local/bin/bash

date=$(date +"%Y%m%d-%H%M%S")
log_file=/Users/Adam/Desktop/update-log-$date.txt

echo "Starting updates..."  &>> $log_file
echo  &>> $log_file

echo "==> Homebrew"  &>> $log_file
echo "    Updating client"  &>> $log_file
/usr/local/bin/brew update &>> $log_file
echo "    Updating packages"  &>> $log_file
/usr/local/bin/brew upgrade --all &>> $log_file
echo "    Cleaning up"  &>> $log_file
/usr/local/bin/brew prune &>> $log_file
/usr/local/bin/brew cleanup --force &>> $log_file
echo  &>> $log_file

echo "==> Homebrew Cask"  &>> $log_file
echo "    Cleaning up"  &>> $log_file
/usr/local/bin/brew cask cleanup &>> $log_file
echo  &>> $log_file

echo "==> Atom Package Manager"  &>> $log_file
echo "    Updating packages"  &>> $log_file
/usr/local/bin/apm update --no-confirm --no-color &>> $log_file
echo "    Cleaning up"  &>> $log_file
/usr/local/bin/apm clean --no-color &>> $log_file
/usr/local/bin/apm dedupe --no-color &>> $log_file
echo  &>> $log_file

echo "==> Node Package Manager"  &>> $log_file
echo "    Updating global packages"  &>> $log_file
/usr/local/bin/npm -g update &>> $log_file
echo  &>> $log_file

echo "==> Composer"  &>> $log_file
echo "    Updating client"  &>> $log_file
/usr/local/bin/composer self-update &>> $log_file
echo "    Updating global packages"  &>> $log_file
/usr/local/bin/composer global update &>> $log_file
echo  &>> $log_file

echo "ALL DONE!"  &>> $log_file

/usr/local/bin/subl $log_file

exit 0;
