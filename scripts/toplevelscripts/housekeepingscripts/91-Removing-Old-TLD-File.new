#!/bin/bash
## This downloads the valid tld lists

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
[[ -f $VALIDDOMAINTLD ]]
then
rm $VALIDDOMAINTLD
echo "Old TLD List Removed." | tee --append $RECENTRUN &>/dev/null
fi
