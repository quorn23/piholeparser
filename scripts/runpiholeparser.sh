#!/bin/bash
## This is the central script that ties the others together

## Variables
source /etc/piholeparser/scriptvars/variables.var

## Clean directories to avoid collisions
sudo bash /etc/piholeparser/scripts/collisionavoid.sh

## Dependency check
sudo bash /etc/piholeparser/scripts/dependencycheck.sh

## Whitelist domains that will be downloaded from
sudo bash /etc/piholeparser/scripts/whitelistdomainchecks.sh

## Lists compressed in 7zip
sudo bash /etc/piholeparser/scripts/7ziplists.sh

## Lists compressed in tar
sudo bash /etc/piholeparser/scripts/tarlists.sh

## Parse Individual Lists that barely need it
sudo bash /etc/piholeparser/scripts/lightparser.sh

## Parse Lists that really need it
sudo bash /etc/piholeparser/scripts/heavyparser.sh

## Build 1111ALLPARSEDLISTS1111.txt
sudo bash /etc/piholeparser/scripts/createbiglist.sh

## Cleanup
sudo bash /etc/piholeparser/scripts/cleanup.sh

## Push lists
sudo bash /etc/piholeparser/scripts/pushlists.sh

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Script Complete"
timestamp=$(echo `date`)
sudo echo "* Script completed at $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
printf "$magenta" "___________________________________________________________"
echo ""
