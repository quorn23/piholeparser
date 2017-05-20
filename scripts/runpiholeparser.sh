#!/bin/bash
## This will run the parser

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

## Re-Build 1111ALLPARSEDLISTS1111.lst
sudo bash /etc/piholeparser/scripts/rebuildall.sh

## Process lists that have to be extracted
sudo bash /etc/piholeparser/scripts/compressedlistsdownload.sh
#sudo bash /etc/piholeparser/scripts/parsercompressed.sh

## Parse Individual Lists and Build 1111ALLPARSEDLISTS1111.txt
sudo bash /etc/piholeparser/scripts/parser.sh

## Cleanup
sudo bash /etc/piholeparser/scripts/cleanup.sh

## Push 1111ALLPARSEDLISTS1111 to localhost
sudo bash /etc/piholeparser/scripts/listlocal.sh

## Make sure we are in the correct directory
cd /etc/piholeparser

## Push Changes up to Github
printf "$blue"    "___________________________________________________________"
echo ""
{ if 
[ "$version" = "github" ]
then
printf "$green"   "Pushing Lists to Github"
sudo git config --global user.name ""$GITHUBUSERNAME""
sudo git config --global user.email $GITHUBEMAIL
sudo git remote set-url origin https://"$GITHUBUSERNAME":"$GITHUBPASSWORD"@github.com/deathbybandaid/piholeparser.git
sudo git add .
timestamp=`date`
sudo git commit -m "Update lists $timestamp"
sudo git push -u origin master
else
printf "$red"   "Not Pushing Lists to Github"
fi }
printf "$magenta" "___________________________________________________________"
echo ""

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Script Complete"
echo ""
printf "$magenta" "___________________________________________________________"
echo ""
