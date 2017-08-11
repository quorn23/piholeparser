#!/bin/bash
## This should create the fun info for the run log, and Readme.md

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../scriptvars/staticvariables.var

## Start File Loop
## For .sh files In The cleanupscripts Directory
for f in $ALLENDTASKSCRIPTS
do

# Dynamic Variables
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
source $DYNOVARS

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
