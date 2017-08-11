#!/bin/bash
## This is the central script that ties the others together

## Variables
script_dir=$(dirname $0)
STATICVARS="$script_dir"/scriptvars/staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

## Logo
bash $AVATARSCRIPT

## Start File Loop
## For .sh files In The mainscripts Directory
for f in $ALLTOPLEVELSCRIPTS
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
