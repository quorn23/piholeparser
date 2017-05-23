#!/bin/bash
## This is the central script that ties the others together

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scripts/colors.var

## Make sure we are in the correct directory
cd /etc/piholeparser

## Dependency check
sudo bash /etc/piholeparser/scripts/dependencycheck.sh

## Clean directories to avoid collisions
sudo bash /etc/piholeparser/scripts/collisionavoid.sh

## Whitelist domains that will be downloaded from
sudo bash /etc/piholeparser/scripts/whitelistdomainchecks.sh

## Process lists that have to be extracted
sudo bash /etc/piholeparser/scripts/compressedlists.sh

## Parse Individual Lists and Build 1111ALLPARSEDLISTS1111.txt
sudo bash /etc/piholeparser/scripts/parser.sh

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
