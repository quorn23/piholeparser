#!/bin/bash
## This Recreates The Valid TLD file

## Variables
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

if
[[ -f $TLDCOMPARED ]]
then
rm $TLDCOMPARED
fi

## Cleanup File
if
[[ -f $VALIDDOMAINTLD ]]
then
mv $VALIDDOMAINTLD $BTEMPFILE
else
touch $BTEMPFILE
fi

printf "$cyan"    "Formatting And Removing Duplicatates From TLD List."

cat $BTEMPFILE | sed '/[/]/d; /\#\+/d; s/\s\+$//; /^$/d; /[[:blank:]]/d; /[.]/d; s/\([A-Z]\)/\L\1/g' > $BFILETEMP
rm $BTEMPFILE

cat -s $BFILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $VALIDDOMAINTLD
rm $BFILETEMP

HOWMANYTLD=$(echo -e "`wc -l $VALIDDOMAINTLD | cut -d " " -f 1`")
printf "$yellow"    "$HOWMANYTLD Valid TLD's Total."
echo ""

## Backup TLD list if not there
if
[[ -f $VALIDDOMAINTLDBKUP ]]
then
rm $VALIDDOMAINTLDBKUP
fi

cp $VALIDDOMAINTLD $VALIDDOMAINTLDBKUP

## Anything New?
printf "$cyan"    "Checking For New TLD's."
gawk 'NR==FNR{a[$0];next} !($0 in a)' $VALIDDOMAINTLDBKUP $VALIDDOMAINTLD > $TLDCOMPARED
HOWMANYTLDNEW=$(echo -e "`wc -l $TLDCOMPARED | cut -d " " -f 1`")
if
[[ "$HOWMANYTLDNEW" != 0 ]]
then
printf "$yellow"    "$HOWMANYTLDNEW New TLD's."
echo "* $HOWMANYTLDNEW New TLD's" | tee --append $RECENTRUN &>/dev/null
else
printf "$yellow"    "No New TLD's"
fi

if
[[ -f $VALIDDOMAINTLDBKUP ]]
then
rm $VALIDDOMAINTLDBKUP
fi

cp $VALIDDOMAINTLD $VALIDDOMAINTLDBKUP

if
[[ -f $TRYNACATCHFIlES ]]
then
rm $TRYNACATCHFIlES
fi
