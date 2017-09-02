#!/bin/bash
## This downloads the valid tld lists

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

SCRIPTTEXT="Checking For Old TLD File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $VALIDDOMAINTLD ]]
then
printf "$cyan"    "Old TLD List Removed."
rm $VALIDDOMAINTLD
echo "* Old TLD List Removed." | tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"    "Old TLD List Not Present."
echo "* Old TLD List Not Present." | tee --append $RECENTRUN &>/dev/null
fi
