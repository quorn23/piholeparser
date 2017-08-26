#!/bin/bash
## This Recreates The Temporary Variables

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

RECENTRUN="$HOUSEKEEPINGSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

if
[[ -f $TEMPVARS ]]
then
rm $TEMPVARS
printf "$red"   "Purging Old TempVars File."
echo "Old TempVars File Purged." | tee --append $RECENTRUN &>/dev/null
fi

CHECKME=$TEMPCLEANUPC
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

echo "## Vars that we don't keep" | tee --append $TEMPVARS &>/dev/null

if
[[ -f $TEMPVARS ]]
then
printf "$yellow"   "TempVars File Recreated."
echo "TempVars File Recreated." | tee --append $RECENTRUN &>/dev/null
else
printf "$red"   "TempVars File Missing, Exiting."
exit
fi
