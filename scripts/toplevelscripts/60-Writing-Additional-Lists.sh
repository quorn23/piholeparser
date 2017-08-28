#!/bin/bash
## This Sets up the writing of additional lists

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

RECENTRUN="$TOPLEVELLOGSDIR""$SCRIPTBASEFILENAME".md

## Start File Loop
## For .sh files In The listgen Directory
for f in $ALLLISTGENSCRIPTS
do

LOOPSTART=$(date +"%s")

## Loop Vars
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
BASEFILENAMENUM=$(echo $BASEFILENAME | sed 's/[0-9]//g')
BASEFILENAMEDASHNUM=$(echo $BASEFILENAME | sed 's/[0-9\-]/ /g')
BNAMEPRETTYSCRIPTTEXT=$(echo $BASEFILENAMEDASHNUM)
TAGTHEREPOLOG="[Details If Any]("$LISTGENSCRIPTSLOGDIRRAW""$BASEFILENAME".md)"
BREPOLOG="$LISTGENSCRIPTSLOGDIR""$BASEFILENAME".md
timestamp=$(echo `date`)

printf "$lightblue"    "$DIVIDERBARB"
echo ""
printf "$cyan"   "$BNAMEPRETTYSCRIPTTEXT $timestamp"
echo ""

## Log Subsection
echo "## $BNAMEPRETTYSCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null

## Create Log
if
[[ -f $BREPOLOG ]]
then
rm $BREPOLOG
fi
echo "# $BNAMEPRETTYSCRIPTTEXT" | tee --append $BREPOLOG
echo "" | tee --append $BREPOLOG

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
DIFFTIMELOOP=`expr $DIFFTIMESEC / 60`
if
[[ $DIFFTIMELOOPSEC -ge 60 && $DIFFTIME -gt 0 ]]
then
LOOPTIMEDIFF="$DIFFTIMELOOP Minutes."
elif
[[ $DIFFTIMELOOPSEC -lt 60 && $DIFFTIME -eq 0 ]]
then
LOOPTIMEDIFF="$DIFFTIMELOOPSEC Seconds."
fi

echo "Process Took $LOOPTIMEDIFF" | sudo tee --append $RECENTRUNA &>/dev/null
echo "$TAGTHEREPOLOG" | sudo tee --append $RECENTRUN &>/dev/null
echo "" | tee --append $RECENTRUN
printf "$orange" "$DIVIDERBARB"
echo ""

## End Of Loop
done
