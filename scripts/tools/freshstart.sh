#!/bin/bash

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

## Clean Mirror Folder
rm $MIRROREDLISTSALL

## Clean Parsed Folder
rm $PARSEDLISTSALL

## Revert Killed Lists
for f in $KILLTHELISTALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
mv $f "$MAINLISTSDIR""$BASEFILENAME".lst
done

## Push Changes up to Github
timestamp=$(echo `date`)
WHYYOUDODIS=$(whiptail --inputbox "Why are you doing a manual push?" 10 80 " $timestamp" 3>&1 1>&2 2>&3)
printf "$green"   "Pushing Lists to Github"
git -C $REPODIR pull
git -C $REPODIR remote set-url origin $GITWHERETOPUSH
git -C $REPODIR add .
git -C $REPODIR commit -m "$WHYYOUDODIS"
git -C $REPODIR push -u origin master
