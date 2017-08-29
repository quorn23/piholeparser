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

if
[[ -f $VALIDDOMAINTLD ]]
then
rm $VALIDDOMAINTLD
echo "* Old TLD List Removed." | tee --append $RECENTRUN &>/dev/null
else
echo "* Old TLD List Not Present." | tee --append $RECENTRUN &>/dev/null
fi
