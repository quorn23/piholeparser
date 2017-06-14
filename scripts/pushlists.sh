#!/bin/bash
## This script pushes lists to localhost,
## and Github, if that's the version in the var file

## Variables
source /etc/piholeparser/scriptvars/variables.var
timestamp=$(echo `date`)
sudo echo "## Pushing Lists $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Push Changes up to Pihole Web Server"

sudo cp -p $BIGAPL $BIGAPLLOCALHOST

printf "$magenta" "___________________________________________________________"
echo ""

## Push Changes up to Github
printf "$blue"    "___________________________________________________________"
echo ""
{ if 
[ "$version" = "github" ]
then
printf "$green"   "Pushing Lists to Github"
timestamp=$(echo `date`)
sudo git config --global user.name ""$GITHUBUSERNAME""
sudo git config --global user.email $GITHUBEMAIL
sudo git -C /etc/piholeparser/ remote set-url origin https://"$GITHUBUSERNAME":"$GITHUBPASSWORD"@github.com/deathbybandaid/piholeparser.git
sudo git -C /etc/piholeparser/ add .
sudo git -C /etc/piholeparser/ commit -m "Update lists $timestamp"
sudo git -C /etc/piholeparser/ push -u origin master
elif
[ "$version" = "local" ]
then
printf "$red"   "Not Pushing Lists to Github"
fi }

printf "$magenta" "___________________________________________________________"
echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
