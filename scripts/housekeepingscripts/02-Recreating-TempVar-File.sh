#!/bin/bash
## This Recreates The Temporary Variables

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../scriptvars/staticvariables.var

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
