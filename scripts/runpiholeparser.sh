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
sudo bash /etc/piholeparser/scripts/rebuild1111ALLPARSEDLISTS1111.sh

## Process lists that have to be extracted
{ if [ "$version" = "github" ]
then
sudo bash /etc/piholeparser/scripts/compressedconvertgithub.sh
elif [ "$version" = "local" ]
then
sudo bash /etc/piholeparser/scripts/compressedconvertlocal.sh
fi }

## Parse Individual Lists
{ if [ "$version" = "github" ]
then
sudo bash /etc/piholeparser/scripts/advancedparser.sh
fi }

## Parse Big List
sudo bash /etc/piholeparser/scripts/advancedparserall.sh
{ if [ "$version" = "github" ]
then
sudo cp /etc/piholeparser/parsedall/*.txt /etc/piholeparser/parsed/
fi }

## Cleanup
sudo bash /etc/piholeparser/scripts/cleanup.sh

## Push 1111ALLPARSEDLISTS1111 to localhost
sudo bash /etc/piholeparser/scripts/1111ALLPARSEDLISTS1111local.sh

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
