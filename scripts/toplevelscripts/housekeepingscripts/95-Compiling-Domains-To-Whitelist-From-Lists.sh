#!/bin/bash
## This sets up whitelisting for domains in .lst files

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

## Quick File Check
WHATITIS="Whitelist File"
CHECKME=$LISTWHITELISTDOMAINS
timestamp=$(echo `date`)

printf "$yellow"  "Checking For $WHATITIS"
echo ""

if
ls $CHECKME &> /dev/null;
then
printf "$red"  "Removing $WHATITIS"
echo ""
rm $CHECKME
touch $CHECKME
echo "* $WHATITIS removed $timestamp" | tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"  "$WHATITIS not there. Not Removing."
echo ""
touch $CHECKME
echo "* $WHATITIS not there, not removing. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

## Create The List
for f in $EVERYLISTFILEWILDCARD
do

for source in `cat $f`;
do

UPCHECK=`echo $source | awk -F/ '{print $3}'`
echo "$UPCHECK" | tee --append $LISTWHITELISTDOMAINS &>/dev/null

done
done
