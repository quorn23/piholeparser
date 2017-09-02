#!/bin/bash
## This Recreates The Valid TLD file

## Variables
source ./foldervars.var

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
