#!/bin/bash
## This Removes *.temp files

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

CHECKME=$TEMPCLEANUPB
if
ls $CHECKME &> /dev/null;
then
printf "$red"   "Purging Old Temp Files."
rm $CHECKME
else
printf "$yellow"   "No Temp Files To Remove."
fi
