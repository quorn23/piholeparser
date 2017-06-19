#!/bin/bash
## This script pushes lists to Github if selected in var

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

## Push Changes up to Github
{ if 
[ "$version" = "github" ]
then
printf "$green"   "Pushing Lists to Github"
timestamp=$(echo `date`)
sudo git -C $REPODIR remote set-url origin $GITWHERETOPUSH
sudo git -C $REPODIR add .
sudo git -C $REPODIR commit -m "Update lists $timestamp"
sudo git -C $REPODIR push -u origin master
elif
[ "$version" = "local" ]
then
printf "$red"   "Not Pushing Lists to Github"
fi }

WHATITIS="web host lists directory"
CHECKME=$BIGAPLLOCALHOSTDIR
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo echo "* $WHATITIS Already there no need to mkdir. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo mkdir $CHECKME
sudo echo "* $WHATITIS Created. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

## Copy it over
sudo cp -p $BIGAPL $BIGAPLLOCALHOST
