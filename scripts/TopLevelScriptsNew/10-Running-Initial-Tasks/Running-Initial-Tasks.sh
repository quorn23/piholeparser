#!/bin/bash
## This should do some initial housekeeping for the script

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/../foldervars.var

## Start File Loop
## For .sh files In The housekeepingscripts Directory
for f in $INITIALTASKSSCRIPTSALL
do

if
[[ -f $TEMPVARS && -z $INITIALTASKSSCRIPTBASENAME ]]
then
echo "INITIALTASKSSCRIPTBASENAME='"$SCRIPTBASEFILENAME"'" | tee --append $TEMPVARS &>/dev/null
fi

LOOPSTART=$(date +"%s")

## Loop Vars
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
BASEFILENAMENUM=$(echo $BASEFILENAME | sed 's/[0-9]//g')
BASEFILENAMEDASHNUM=$(echo $BASEFILENAME | sed 's/[0-9\-]/ /g')
BNAMEPRETTYSCRIPTTEXT=$(echo $BASEFILENAMEDASHNUM)
BREPOLOG="$INITIALTASKSSCRIPTSLOGSDIR""$BASEFILENAME".md
timestamp=$(echo `date`)

printf "$lightblue"    "$DIVIDERBARB"
echo ""

printf "$cyan"   "$BNAMEPRETTYSCRIPTTEXT $timestamp"
echo ""

## Log Subsection
echo "## $BNAMEPRETTYSCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
TAGTHEREPOLOG="[Details If Any]("$INITIALTASKSSCRIPTSLOGSGIT""$BASEFILENAME".md)"
TAGTHEUPONEREPOLOG="[Go Up One Level]("$TOPLEVELSCRIPTSLOGSDIRGIT""$SCRIPTBASEFILENAME".md)"

## Create Log
if
[[ -f $BREPOLOG ]]
then
rm $BREPOLOG
fi
echo "$MAINREPOFOLDERGITTAG" | tee --append $BREPOLOG &>/dev/null
echo "$MAINRECENTRUNLOGMDGITTAG" | tee --append $BREPOLOG &>/dev/null
echo "$TAGTHEUPONEREPOLOG" | tee --append $BREPOLOG &>/dev/null
echo "____________________________________" | tee --append $BREPOLOG &>/dev/null
echo "# $BNAMEPRETTYSCRIPTTEXT" | tee --append $BREPOLOG &>/dev/null
echo "" | tee --append $BREPOLOG &>/dev/null

## Clear Temp Before
if
[[ -f $DELETETEMPFILE ]]
then
bash $DELETETEMPFILE
else
echo "Error Deleting Temp Files."
exit
fi

## Run Script
bash $f

## Clear Temp After
if
[[ -f $DELETETEMPFILE ]]
then
bash $DELETETEMPFILE
else
echo "Error Deleting Temp Files."
exit
fi

LOOPEND=$(date +"%s")
DIFFTIMELOOPSEC=`expr $LOOPEND - $LOOPSTART`
if
[[ $DIFFTIMELOOPSEC -ge 60 ]]
then
DIFFTIMELOOPMIN=`expr $DIFFTIMELOOPSEC / 60`
LOOPTIMEDIFF="$DIFFTIMELOOPMIN Minutes."
elif
[[ $DIFFTIMELOOPSEC -lt 60 ]]
then
LOOPTIMEDIFF="$DIFFTIMELOOPSEC Seconds."
fi

echo "Process Took $LOOPTIMEDIFF" | sudo tee --append $RECENTRUN &>/dev/null
echo "$TAGTHEREPOLOG" | sudo tee --append $RECENTRUN &>/dev/null
echo "" | tee --append $RECENTRUN

printf "$orange" "$DIVIDERBARB"
echo ""

## End Of Loop
done
