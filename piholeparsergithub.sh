#!/bin/bash
timestamp=`date --rfc-3339=seconds`
cd /etc/piholeparser
sudo git pull
sudo bash /etc/piholeparser/bigparser.sh
sudo git remote set-url origin https://USERNAME:PASSWORD@github.com/deathbybandaid/piholeparser.git
sudo git add .
sudo git commit -m "Update lists $timestamp"
sudo git push -u origin master


## Notes
## copy this file out of the main directory and edit credentials
##
## Create Cron with
# 20 0 * * * sudo bash /etc/piholeparsergithub.sh
