#!/bin/bash
## This Recreates The Temporary Variables

## Variables
script_dir=$(dirname $0)
STATICVARS="$script_dir"/../../scriptvars/staticvariables.var
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
source $TEMPVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi

CHECKME=$TEMPVARS
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
printf "$red"   "Purging Old TempVars File."
fi

echo "## Vars that we don't keep" | tee --append $TEMPVARS &>/dev/null

CHECKME=$TEMPVARS
if
ls $CHECKME &> /dev/null;
then
printf "$yellow"   "TempVars File Recreated."
fi
