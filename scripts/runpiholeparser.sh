#!/bin/bash
## This is the central script that ties the others together

## Version
source /etc/piholeparser.var

## Variables
source /etc/piholeparser/scriptvars/variables.var

## Make sure we are in the correct directory
cd /etc/piholeparser

## Dependency check
sudo bash /etc/piholeparser/scripts/dependencycheck.sh

## Clean directories to avoid collisions
sudo bash /etc/piholeparser/scripts/collisionavoid.sh

## Whitelist domains that will be downloaded from
sudo bash /etc/piholeparser/scripts/whitelistdomainchecks.sh

## Lists compressed in 7zip
sudo bash /etc/piholeparser/scripts/7ziplists.sh

## Lists compressed in tar
sudo bash /etc/piholeparser/scripts/tarlists.sh

## Parse Individual Lists
sudo bash /etc/piholeparser/scripts/lightparser.sh
sudo bash /etc/piholeparser/scripts/parser.sh

## Build 1111ALLPARSEDLISTS1111.txt
sudo bash /etc/piholeparser/scripts/createbiglist.sh

## remove domains from 1111ALLPARSEDLISTS1111 that cause issues
sudo bash /etc/piholeparser/scripts/domainflags.sh

## Cleanup
sudo bash /etc/piholeparser/scripts/cleanup.sh

## Push lists
sudo bash /etc/piholeparser/scripts/pushlists.sh

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Script Complete"
echo ""
printf "$magenta" "___________________________________________________________"
echo ""
