#!/bin/bash
## This should do some initial housekeeping for the script

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

## Start File Loop
## For .sh files In The housekeepingscripts Directory
for f in $RUNHOUSEKEEPINGSCRIPTSALL
do

# Dynamic Variables
source /etc/piholeparser/scripts/scriptvars/dynamicvariables.var

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
