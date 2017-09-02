#!/bin/bash
## This is the Parsing Process

## Variables
source ./foldervars.var

## This is a way to skipp parsing
if
[[ -n $FULLSKIPPARSING ]]
then
printf "$magenta"    "Devmode Parsing Skip Enabled."
echo "Devmode Parsing Skip Enabled." | sudo tee --append $RECENTRUN &>/dev/null
exit
fi

## Process Every .lst file within the List Directories
for f in $BLACKLSTALL
do

## Variables
source ./foldervars.var

## Clear Temp Before
if
[[ -f $DELETETEMPFILE ]]
then
bash $DELETETEMPFILE
else
echo "Error Deleting Temp Files."
exit
fi

if
[[ -f $TEMPPARSEVARS ]]
then
rm $TEMPPARSEVARS
fi

printf "$lightblue"    "$DIVIDERBAR"
echo ""

LOOPSTART=$(date +"%s")

## Declare File Name
FILEBEINGPROCESSED=$f
echo "FILEBEINGPROCESSED="$FILEBEINGPROCESSED"" | tee --append $TEMPPARSEVARS &>/dev/null

BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
echo "BASEFILENAME="$BASEFILENAME"" | tee --append $TEMPPARSEVARS &>/dev/null
echo "## $BASEFILENAME" | sudo tee --append $RECENTRUN &>/dev/null

BREPOLOG="$BLACKLISTSSCRIPTSLOGSDIR""$BASEFILENAME".md
echo "RECENTRUN="$BREPOLOG"" | tee --append $TEMPPARSEVARS &>/dev/null
TAGTHEREPOLOG="[Details If Any]("$BLACKLISTSSCRIPTSLOGSDIRGIT""$BASEFILENAME".md)"
TAGTHEUPONEREPOLOG="[Go Up One Level]("$TOPLEVELLOGSDIRRAW""$SCRIPTBASEFILENAME".md)"

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
echo "# $BASEFILENAME" | sudo tee --append $BREPOLOG &>/dev/null

printf "$green"    "Processing $BASEFILENAME List."
echo "" 

for p in $BLACKLISTSSCRIPTSALL
do

PBASEFILENAME=$(echo `basename $p | cut -f 1 -d '.'`)
PBASEFILENAMEDASHNUM=$(echo $PBASEFILENAME | sed 's/[0-9\-]/ /g')
PBNAMEPRETTYSCRIPTTEXT=$(echo $PBASEFILENAMEDASHNUM)

if
[[ -f $TEMPPARSEVARS ]]
then
source $TEMPPARSEVARS
fi

if
[[ -z $FULLSKIPPARSING && -f $FILEBEINGPROCESSED ]]
then
printf "$cyan"  "$PBNAMEPRETTYSCRIPTTEXT"
echo "## $PBNAMEPRETTYSCRIPTTEXT" | sudo tee --append $BREPOLOG &>/dev/null
bash $p
echo ""
fi

## End of parsing Loop
done

## Dead List Alive
if
[[ -n $UNDEADLIST && -f $FILEBEINGPROCESSED ]]
then
mv $FILEBEINGPROCESSED $BUNDEADPARSELIST
fi

## Clear Temp After
if
[[ -f $DELETETEMPFILE ]]
then
bash $DELETETEMPFILE
else
echo "Error Deleting Temp Files."
exit
fi

printf "$orange" "$DIVIDERBARB"

if
[[ -f $TEMPPARSEVARS ]]
then
rm $TEMPPARSEVARS
fi

unset FULLSKIPPARSING
unset UNDEADLIST

if
[[ -f $BORIGINALFILETEMP ]]
then
rm $BORIGINALFILETEMP
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

## Variables
source ./foldervars.var

echo "List Took $LOOPTIMEDIFF" | sudo tee --append $RECENTRUN &>/dev/null
echo "$TAGTHEREPOLOG" | sudo tee --append $RECENTRUN &>/dev/null
echo "" | sudo tee --append $RECENTRUN &>/dev/null

## End of File Loop
done
