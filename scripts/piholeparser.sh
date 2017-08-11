#!/bin/bash
## This script resides outside of the main directory 
## for the purpose of updating without worrying about being overwritten
##
## This File will not be updated often.

## Variables
script_dir=$(dirname $0)
REPONAMED=$(basename $0)
MAINVAR="$script_dir"/"$REPONAMED".var
CHECKME=$MAINVAR
if
ls $CHECKME &> /dev/null;
then
echo "Main Vars Check Successful"
source $MAINVAR
else
echo "Main Vars File Missing, Exiting."
exit
fi

if
[[ ! -d "$REPODIR" ]]
then
echo ""
echo "piholeparser Directory Missing. Cloning Now."
echo ""
git clone $GITREPOSITORYURL $REPODIR
elif
[[ -d "$REPODIR" ]]
then
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Updating Repository."
git -C $REPODIR pull
printf "$magenta" "___________________________________________________________"
echo ""
fi

source "$REPODIR"/scripts/scriptvars/staticvariables.var

## RunParser
sudo bash $RUNPIHOLEPARSERSCRIPT
