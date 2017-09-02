#!/bin/bash
## This checks for new tld's

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

RECENTRUN="$HOUSEKEEPINGSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

SCRIPTTEXT="Making Backup Copy of TLD List."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ ! -f $VALIDDOMAINTLDBKUP && -f $VALIDDOMAINTLD ]]
then
cp $VALIDDOMAINTLD $VALIDDOMAINTLDBKUP
elif
[[ -f $VALIDDOMAINTLDBKUP && -f $VALIDDOMAINTLD ]]
then
rm $VALIDDOMAINTLDBKUP
cp $VALIDDOMAINTLD $VALIDDOMAINTLDBKUP
fi
echo ""

SCRIPTTEXT="Checking For New TLDs."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $VALIDDOMAINTLDBKUP && -f $VALIDDOMAINTLD ]]
then
gawk 'NR==FNR{a[$0];next} !($0 in a)' $VALIDDOMAINTLDBKUP $VALIDDOMAINTLD > $TLDCOMPARED
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
