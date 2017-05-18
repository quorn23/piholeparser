#!/bin/bash
## This will parse lists and upload to Github

## Timestamp
timestamp=`date`

## Colors
source /etc/piholeparser/scripts/colors.var

## Dependency check
sudo bash /etc/piholeparser/scripts/dependencycheck.sh

## Clean directories to avoid collisions
sudo bash /etc/piholeparser/scripts/collisionavoid.sh

## Make sure we are in the correct directory
cd /etc/piholeparser

## Pull new lists on github
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Updating Repository."
sudo git pull
printf "$magenta" "___________________________________________________________"
echo ""

## Re-Build 1111ALLPARSEDLISTS1111.lst
sudo bash /etc/piholeparser/scripts/rebuildALLPARSEDLISTS1111.sh

## Process lists that have to be extracted
sudo bash /etc/piholeparser/scripts/compressedconvert.sh

## Parse Lists
sudo bash /etc/piholeparser/scripts/advancedparser.sh

## Parse Big List
sudo bash /etc/piholeparser/scripts/advancedparserlocal.sh
sudo cp /etc/piholeparser/parsedall/*.txt /etc/piholeparser/parsed/

## Cleanup
sudo bash /etc/piholeparser/scripts/cleanup.sh

## Push 1111ALLPARSEDLISTS1111 to localhost
sudo bash /etc/piholeparser/scripts/1111ALLPARSEDLISTS1111local.sh

## Push Changes up to Github
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Pushing Lists to Github"
sudo git config --global user.name "deathbybandaid"
sudo git config --global user.email sam@deathbybandaid.net
sudo git remote set-url origin https://Deathbybandaid:Bandaid1701@github.com/deathbybandaid/piholeparser.git
sudo git add .
sudo git commit -m "Update lists $timestamp"
sudo git push -u origin master
printf "$magenta" "___________________________________________________________"
echo ""
