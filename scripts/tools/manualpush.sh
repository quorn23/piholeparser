#!/bin/bash
## This script pushes lists to Github manually

## Variables
script_dir=$(dirname $0)
STATICVARS="$script_dir"/../scriptvars/staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

## Push Changes up to Github
timestamp=$(echo `date`)
WHYYOUDODIS=$(whiptail --inputbox "Why are you doing a manual push?" 10 80 "Change Made Offline $timestamp" 3>&1 1>&2 2>&3)
printf "$green"   "Pushing Lists to Github"
git -C $REPODIR pull
git -C $REPODIR remote set-url origin $GITWHERETOPUSH
git -C $REPODIR add .
git -C $REPODIR commit -m "$WHYYOUDODIS"
git -C $REPODIR push -u origin master
