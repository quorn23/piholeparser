#!/bin/bash
## Sets The Beginning Script Time

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

timestamp=$(echo `date`)
STARTTIME=$(echo `date`)
echo "STARTTIME='$timestamp'" | tee --append $TEMPVARS &>/dev/null

STARTIMEVAR=$(echo $STARTIME)
STARTTIMESTAMP=$(date +"%s")

echo "STARTIMEVAR='"$STARTIMEVAR"'" | tee --append $TEMPVARS &>/dev/null
echo "STARTTIMESTAMP=$STARTTIMESTAMP" | tee --append $TEMPVARS &>/dev/null

printf "$yellow" "Script Started At $STARTTIME"

echo "* Start Time Set To $timestamp" | tee --append $RECENTRUN &>/dev/null
