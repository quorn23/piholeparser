#!/bin/bash
## This Removes *.temp files

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

SCRIPTTEXT="Checking For Old Temp Files."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
CHECKME=$TEMPCLEANUPB
if
ls $CHECKME &> /dev/null;
then
printf "$red"   "Purging Old Temp Files."
rm $TEMPCLEANUPB
echo "* Old Temp Files Purged." | tee --append $RECENTRUN &>/dev/null
else
printf "$yellow"   "No Temp Files To Remove."
echo "* No Temp Files To Purge." | tee --append $RECENTRUN &>/dev/null
fi
