#!/bin/bash
## This Recreates The Temporary Variables

## Variables
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

if
[[ -f $TEMPVARS ]]
then
rm $TEMPVARS
printf "$red"   "Purging Old TempVars File."
echo "Old TempVars File Purged." | tee --append $RECENTRUN &>/dev/null
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
