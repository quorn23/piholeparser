#!/bin/bash
## This is the central script that ties the others together

## Variables
script_dir=$(dirname $0)
source "$script_dir"/scriptvars/staticvariables.var

## Logo
#bash $AVATARSCRIPT

## Start File Loop
## For .sh files In The mainscripts Directory
for f in $RUNMAINSCRIPTSALL
do

# Dynamic Variables
source $DYNOVARS

## Loop Variables
SCRIPTTEXT=""$BNAMEPRETTYSCRIPTTEXT"."
timestamp=$(echo `date`)

printf "$blue"    "$DIVIDERBAR"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"

## Log Section
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null

## Clear Temp Before
bash $DELETETEMPFILE

## Run Script
bash $f

## Clear Temp After
bash $DELETETEMPFILE

echo "$TAGTHEREPOLOG" | sudo tee --append $RECENTRUN &>/dev/null
echo "" | sudo tee --append $RECENTRUN
printf "$magenta" "$DIVIDERBAR"
echo ""

## End Of Loop
done
