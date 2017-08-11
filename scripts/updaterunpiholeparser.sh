#!/bin/bash
## This script resides outside of the main directory 
## for the purpose of updating without worrying about being overwritten
##
## This File will not be updated often.

## Variables
REPONAMED=piholeparser
MAINVAR=./"$REPONAMED".var
if
[[ -f "$MAINVAR" ]]
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
echo "$REPONAME Directory Missing. Cloning Now."
echo ""
git clone $GITREPOSITORYURLB $REPODIR
fi

SCRIPTVARSDIR="$REPODIR"scripts/scriptvars/

echo "___________________________________________________________"
echo ""
echo "Updating Repository."
echo ""
git -C $REPODIR pull
echo ""
echo "___________________________________________________________"
echo ""

STATICVARS="$REPODIR"scripts/scriptvars/staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

## RunParser
if
[[ -f $RUNPIHOLEPARSERSCRIPT ]]
then
bash $RUNPIHOLEPARSERSCRIPT
else
echo "$RUNPIHOLEPARSERSCRIPT Missing, Exiting."
exit
fi
