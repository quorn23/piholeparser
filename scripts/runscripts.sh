#!/bin/bash
## This is the central script that ties the others together

## Variables
SCRIPTDIR=$(dirname $0)
source "$SCRIPTDIR"/foldervars.var

## Run Logs
if
[[ -f $RUNLOGSCRIPT ]]
then
bash $RUNLOGSCRIPT
fi

## Logo
if
[[ -f $AVATARSCRIPT ]]
then
bash $AVATARSCRIPT
else
echo "Deathbybandaid Logo Missing."
fi

echo ""

## Start File Loop
## For .sh files In The mainscripts Directory
for f in $ALLTOPLEVELSCRIPTS
do

LOOPSTART=$(date +"%s")

## Loop Vars
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
BASEFILENAMENUM=$(echo $BASEFILENAME | sed 's/[0-9]//g')
BASEFILENAMEDASHNUM=$(echo $BASEFILENAME | sed 's/[0-9\-]/ /g')
BNAMEPRETTYSCRIPTTEXT=$(echo $BASEFILENAMEDASHNUM)
TAGTHEREPOLOG="[Details If Any]("$TOPLEVELSCRIPTSLOGSDIRGIT""$BASEFILENAME".md)"
BREPOLOG="$TOPLEVELSCRIPTSLOGSDIR""$BASEFILENAME".md
timestamp=$(echo `date`)

printf "$blue"    "$DIVIDERBAR"
echo ""
printf "$cyan"   "$BNAMEPRETTYSCRIPTTEXT $timestamp"

## Log Section
echo "## $BNAMEPRETTYSCRIPTTEXT $timestamp" | tee --append $MAINRECENTRUNLOGMD &>/dev/null

## Create Log
if
[[ -f $BREPOLOG ]]
then
rm $BREPOLOG
fi
echo "$MAINREPOFOLDERGITTAG" | tee --append $BREPOLOG &>/dev/null
echo "$MAINRECENTRUNLOGMDGITTAG" | tee --append $BREPOLOG &>/dev/null
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

echo "Process Took $LOOPTIMEDIFF" | sudo tee --append $MAINRECENTRUNLOGMD &>/dev/null
echo "$TAGTHEREPOLOG" | sudo tee --append $MAINRECENTRUNLOGMD &>/dev/null
echo "" | sudo tee --append $MAINRECENTRUNLOGMD

printf "$magenta" "$DIVIDERBAR"
echo ""

## End Of Loop
done

## Push Changes To Github
if
[[ -f $PUSHTOGITHUBSCRIPT ]]
then
bash $PUSHTOGITHUBSCRIPT
fi
