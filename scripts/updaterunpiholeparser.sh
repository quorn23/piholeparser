#!/bin/bash
## This script resides outside of the main directory 
## for the purpose of updating without worrying about being overwritten
##
## This File will not be updated often.

DIRECTORY=/etc/piholeparser/

VERSIONVARIABLE=/etc/piholeparser.var
VERSIONVARDL=https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/scripts/scriptvars/piholeparser.var
CHECKME=$VERSIONVARIABLE
if
ls $CHECKME &> /dev/null;
then
:
else
wget -q -O $VERSIONVARIABLE $VERSIONVARDL
echo "version=local" | tee --append $VERSIONVARIABLE
fi

if
[[ ! -d "$DIRECTORY" ]]
then
echo ""
echo "piholeparser Directory Missing. Cloning Now."
echo ""
git clone https://github.com/deathbybandaid/piholeparser.git $DIRECTORY
## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var
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
