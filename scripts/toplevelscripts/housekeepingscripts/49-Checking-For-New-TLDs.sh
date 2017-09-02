#!/bin/bash
## This checks for new tld's

## Variables
source ./foldervars.var

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
