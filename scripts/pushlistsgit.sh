#!/bin/bash
## This script pushes lists to Github if selected in var

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

## Push Changes up to Github
printf "$blue"    "___________________________________________________________"
echo ""
{ if 
[ "$version" = "github" ]
then
printf "$green"   "Pushing Lists to Github"
timestamp=$(echo `date`)
sudo git -C $REPODIR remote set-url origin https://"$GITHUBUSERNAME":"$GITHUBPASSWORD"@"GITREPOSITORYURL"
sudo git -C $REPODIR add .
sudo git -C $REPODIR commit -m "Update lists $timestamp"
sudo git -C $REPODIR push -u origin master
elif
[ "$version" = "local" ]
then
printf "$red"   "Not Pushing Lists to Github"
fi }

printf "$magenta" "___________________________________________________________"
echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
