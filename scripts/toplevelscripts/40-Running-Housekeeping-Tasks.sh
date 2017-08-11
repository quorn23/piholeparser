#!/bin/bash
## This should do some initial housekeeping for the script

## Variables
script_dir=$(dirname $0)
STATICVARS="$script_dir"/../scriptvars/staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

## Start File Loop
## For .sh files In The housekeepingscripts Directory
for f in $ALLHOUSEKEEPINGSCRIPTS
do

# Dynamic Variables
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
if
[[ -f $DYNOVARS ]]
then
source $DYNOVARS
else
echo "Dynamic Vars File Missing, Exiting."
exit
fi

## Loop Variables
SCRIPTTEXT=""$BNAMEPRETTYSCRIPTTEXT"."
timestamp=$(echo `date`)

printf "$lightblue"    "$DIVIDERBARB"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""

## Log Subsection
echo "### $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null

## Clear Temp Before
bash $DELETETEMPFILE

## Run Script
bash $f

## Clear Temp After
bash $DELETETEMPFILE

echo "" | tee --append $RECENTRUN
printf "$orange" "$DIVIDERBARB"
echo ""

## End Of Loop
done
