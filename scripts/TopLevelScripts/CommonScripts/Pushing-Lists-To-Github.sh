#!/bin/bash
## This Pushes Changes To Github

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

## Push Changes up to Github
if 
[ "$version" = "github" ]
then
printf "$green"   "Pushing Lists to Github"
timestamp=$(echo `date`)
printf "$green"    "$(git -C $REPODIR remote set-url origin $GITWHERETOPUSH)"
printf "$green"    "$(git -C $REPODIR add .)"
printf "$green"    "$(git -C $REPODIR commit -m "Update lists $timestamp")"
printf "$green"    "$(git -C $REPODIR push -u origin master)"
elif
[ "$version" = "local" ]
then
printf "$yellow"   "Not Pushing Lists to Github"
fi
