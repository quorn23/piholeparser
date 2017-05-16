#!/bin/bash
timestamp=`date --rfc-3339=seconds`
cd /etc/piholeparser

## Pull new lists on github
sudo git pull

## Process lists that have to be extracted
#sudo bash /etc/piholeparser/compressedconvert.sh

## Parse Lists
sudo bash /etc/piholeparser/bigparser.sh

## Push Changes up to Github
sudo git config --global user.name "Your Name"
sudo git config --global user.email you@example.com
sudo git remote set-url origin https://USERNAME:PASSWORD@github.com/deathbybandaid/piholeparser.git
sudo git add .
sudo git commit -m "Update lists $timestamp"
sudo git push -u origin master


## Notes
## copy this file out of the main directory and edit credentials
##
## Create Cron with
# 20 0 * * * sudo bash /etc/piholeparsergithub.sh
