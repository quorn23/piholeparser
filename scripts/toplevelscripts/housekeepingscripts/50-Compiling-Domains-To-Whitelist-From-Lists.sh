#!/bin/bash
## This sets up whitelisting for domains in .lst files

## Variables
script_dir=$(dirname $0)
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
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

## Quick File Check
timestamp=$(echo `date`)

printf "$yellow"  "Checking For Whitelist File"
echo ""

if
[[ -f $LISTWHITELISTDOMAINS ]]
then
printf "$red"  "Removing Whitelist File."
echo ""
rm $LISTWHITELISTDOMAINS
touch $LISTWHITELISTDOMAINS
echo "* Whitelist File removed $timestamp" | tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"  "Whitelist File not there. Not Removing."
echo ""
touch $LISTWHITELISTDOMAINS
echo "* Whitelist File not there, not removing. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

## Create The List
for f in $EVERYLISTFILEWILDCARD
do

source=`cat $f`

SOURCEDOMAIN=`echo $source | awk -F/ '{print $3}'`
if
[[ -n $SOURCEDOMAIN ]]
then
echo "$SOURCEDOMAIN" | tee --append $LISTWHITELISTDOMAINS &>/dev/null
fi

done
