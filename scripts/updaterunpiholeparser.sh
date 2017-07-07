#!/bin/bash
## This script resides outside of the main directory 
## for the purpose of updating without worrying about being overwritten
##
## This File will not be updated often.

DIRECTORY=/etc/piholeparser/

if
[[ ! -d "$DIRECTORY" ]]
then
echo "piholeparser Directory Missing. Cloning Now."
echo ""
git clone https://github.com/deathbybandaid/piholeparser.git
elif
[[ -d "$DIRECTORY" ]]
then
## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var
## Pull new lists on github
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Updating Repository."
git -C $REPODIR pull
printf "$magenta" "___________________________________________________________"
echo ""
fi

## RunParser
sudo bash $RUNPIHOLEPARSERSCRIPT
