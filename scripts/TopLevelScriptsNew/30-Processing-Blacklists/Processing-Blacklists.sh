#!/bin/bash
## This is the Blacklist Parsing Process

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/../foldervars.var

RECENTRUNBANDAID="$RECENTRUN"
ONEUPBANDAID="$SCRIPTBASEFILENAME"

SCRIPTTEXT="Sorting and Deduping Individual Blacklists."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
for f in $BLACKDOMAINSALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
echo "#### $BASEFILENAME" | sudo tee --append $RECENTRUN &>/dev/null
printf "$cyan"  "Processing $BASEFILENAME"

timestamp=$(echo `date`)
cat -s $f | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILEA
cat $TEMPFILEA >> $BLACKLISTTEMP
HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
echo "$HOWMANYLINES In $BASEFILENAME" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES In $BASEFILENAME"
rm $f
mv $TEMPFILEA $f
echo ""
done

SCRIPTTEXT="Deduplicating Merged List."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $BLACKLISTTEMP ]]
then
cat -s $BLACKLISTTEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILER
rm $BLACKLISTTEMP
mv $TEMPFILER $BLACKLISTTEMP
else
touch $BLACKLISTTEMP
fi
HOWMANYLINES=$(echo -e "`wc -l $BLACKLISTTEMP | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"

echo "____________________________________" | tee --append $RECENTRUN &>/dev/null

## This is a way to skip parsing
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

RECENTRUN="$RECENTRUNBANDAID"

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

BREPOLOGDIRECTORY="$TOPLEVELSCRIPTSLOGSDIR""$SCRIPTBASEFOLDERNAME"/
if
[[ ! -d $BREPOLOGDIRECTORY ]]
then
mkdir $BREPOLOGDIRECTORY
fi

BREPOLOG="$BREPOLOGDIRECTORY""$BASEFILENAME".md
echo "RECENTRUN="$BREPOLOG"" | tee --append $TEMPPARSEVARS &>/dev/null
TAGTHEREPOLOG="[Details If Any]("$TOPLEVELSCRIPTSLOGSDIRGIT""$SCRIPTBASEFOLDERNAME"/"$BASEFILENAME".md)"
TAGTHEUPONEREPOLOG="[Go Up One Level]("$TOPLEVELSCRIPTSLOGSDIRGIT""$ONEUPBANDAID".md)"
# Create Log
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

BLACKLISTSSCRIPTSALL="$COMPLETEFOLDERPATH"/[0-9]*.sh

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

RECENTRUN="$RECENTRUNBANDAID"

echo "List Took $LOOPTIMEDIFF" | sudo tee --append $RECENTRUN &>/dev/null
echo "$TAGTHEREPOLOG" | sudo tee --append $RECENTRUN &>/dev/null
echo "" | sudo tee --append $RECENTRUN &>/dev/null

## End of File Loop
done
