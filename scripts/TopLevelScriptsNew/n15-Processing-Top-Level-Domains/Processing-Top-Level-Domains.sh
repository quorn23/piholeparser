#!/bin/bash
## This downloads the valid tld lists

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/../foldervars.var

for f in $TLDLSTALL
do

## Variables
source "$SCRIPTDIR"/foldervars.var

## Clear Temp Before
if
[[ -f $DELETETEMPFILE ]]
then
bash $DELETETEMPFILE
else
echo "Error Deleting Temp Files."
exit
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

BREPOLOGDIRECTORY="$TOPLEVELSCRIPTSLOGSDIR""$SCRIPTDIRNAME"/
if
[[ ! -d $BREPOLOGDIRECTORY ]]
then
mkdir $BREPOLOGDIRECTORY
fi

BREPOLOG="$BREPOLOGDIRECTORY""$BASEFILENAME".md
echo "RECENTRUN="$BREPOLOG"" | tee --append $TEMPPARSEVARS &>/dev/null
TAGTHEREPOLOG="[Details If Any]("$TOPLEVELSCRIPTSLOGSDIRGIT""$SCRIPTDIRNAME"/"$BASEFILENAME".log)"
TAGTHEUPONEREPOLOG="[Go Up One Level]("$TOPLEVELSCRIPTSLOGSDIRGIT""$SCRIPTDIRNAME".md)"


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
echo "## Processing $BASEFILENAME List." | sudo tee --append $BREPOLOG &>/dev/null
echo "" 

TLDLISTSSCRIPTSALL="$COMPLETEFOLDERPATH"/[0-9]*.sh

for p in $TLDLISTSSCRIPTSALL
do

PBASEFILENAME=$(echo `basename $p | cut -f 1 -d '.'`)
PBASEFILENAMEDASHNUM=$(echo $PBASEFILENAME | sed 's/[0-9\-]/ /g')
PBNAMEPRETTYSCRIPTTEXT=$(echo $PBASEFILENAMEDASHNUM)

printf "$cyan"  "$PBNAMEPRETTYSCRIPTTEXT"
echo "## $PBNAMEPRETTYSCRIPTTEXT" | sudo tee --append $BREPOLOG &>/dev/null
bash $p
echo ""

## End of parsing Loop
done

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

echo "List Took $LOOPTIMEDIFF" | sudo tee --append $RECENTRUN &>/dev/null
echo "$TAGTHEREPOLOG" | sudo tee --append $RECENTRUN &>/dev/null
echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$orange" "$DIVIDERBARB"
echo ""

done

SCRIPTTEXT="Checking For Old TLD File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $VALIDDOMAINTLD ]]
then
printf "$cyan"    "Old TLD List Removed."
rm $VALIDDOMAINTLD
echo "* Old TLD List Removed." | tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"    "Old TLD List Not Present."
echo "* Old TLD List Not Present." | tee --append $RECENTRUN &>/dev/null
fi

SCRIPTTEXT="Merging Individual TLD Lists."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
CHECKME=$MIRROREDTLDLISTSSUBALL
if
ls $CHECKME &> /dev/null;
then
cat $MIRROREDTLDLISTSSUBALL >> $VALIDDOMAINTLD
else
touch $VALIDDOMAINTLD
fi
HOWMANYLINES=$(echo -e "`wc -l $VALIDDOMAINTLD | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"

SCRIPTTEXT="Removing Old TEMP TLD If Present."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $TLDCOMPARED ]]
then
rm $TLDCOMPARED
echo "Old TLD Comparison Removed." | sudo tee --append $RECENTRUN &>/dev/null
else
echo "Old TLD Comparison Not Present." | sudo tee --append $RECENTRUN &>/dev/null
fi

SCRIPTTEXT="Formatting TLD List."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $VALIDDOMAINTLD ]]
then
cat $VALIDDOMAINTLD | sed '/[/]/d; /\#\+/d; s/\s\+$//; /^$/d; /[[:blank:]]/d; /[.]/d; s/\([A-Z]\)/\L\1/g' > $TEMPFILEF
rm $VALIDDOMAINTLD
else
touch $TEMPFILEF
fi
HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEF | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"

SCRIPTTEXT="Removing Duplicatates From TLD List."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $TEMPFILEF ]]
then
cat -s $TEMPFILEF | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $VALIDDOMAINTLD
rm $TEMPFILEF
else
touch $VALIDDOMAINTLD
fi
HOWMANYLINES=$(echo -e "`wc -l $VALIDDOMAINTLD | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null

echo "____________________________________" | sudo tee --append $RECENTRUN &>/dev/null

HOWMANYTLD=$(echo -e "`wc -l $VALIDDOMAINTLD | cut -d " " -f 1`")
echo "HOWMANYTLDTOTAL='"$HOWMANYTLD"'" | tee --append $TEMPVARS &>/dev/null

printf "$yellow"    "$HOWMANYTLD Valid TLD's Total."
echo "$HOWMANYTLD Valid TLD's Total." | sudo tee --append $RECENTRUN &>/dev/null

SCRIPTTEXT="Making Backup Copy of TLD List."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ ! -f $TLDBKUP && -f $VALIDDOMAINTLD ]]
then
cp $VALIDDOMAINTLD $TLDBKUP
elif
[[ -f $TLDBKUP && -f $VALIDDOMAINTLD ]]
then
rm $TLDBKUP
cp $VALIDDOMAINTLD $TLDBKUP
fi
echo ""

SCRIPTTEXT="Checking For New TLDs."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $TLDBKUP && -f $VALIDDOMAINTLD ]]
then
gawk 'NR==FNR{a[$0];next} !($0 in a)' $TLDBKUP $VALIDDOMAINTLD > $TLDCOMPARED
{ if
[[ -f $TLDCOMPARED ]]
then
HOWMANYTLDNEW=$(echo -e "`wc -l $TLDCOMPARED | cut -d " " -f 1`")
else
HOWMANYTLDNEW="0"
fi }
fi

if
[[ -n $HOWMANYTLDNEW && "$HOWMANYTLDNEW" != 0 ]]
then
printf "$yellow"    "$HOWMANYTLDNEW New TLD's."
echo "* $HOWMANYTLDNEW New TLD's" | tee --append $RECENTRUN &>/dev/null
else
printf "$yellow"    "No New TLD's"
HOWMANYTLDNEW="No"
echo "* No New TLD's" | tee --append $RECENTRUN &>/dev/null
fi
echo "HOWMANYTLDNEW='"$HOWMANYTLDNEW"'" | tee --append $TEMPVARS &>/dev/null
