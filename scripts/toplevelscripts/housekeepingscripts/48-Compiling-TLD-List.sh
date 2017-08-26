#!/bin/bash
## This Recreates The Valid TLD file

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

if
[[ -f $TLDCOMPARED ]]
then
rm $TLDCOMPARED
fi

## Cleanup File
if
[[ -f $VALIDDOMAINTLD ]]
then
mv $VALIDDOMAINTLD $TEMPFILEJ
else
touch $TEMPFILEJ
fi

printf "$cyan"    "Formatting And Removing Duplicatates From TLD List."

cat $TEMPFILEJ | sed '/[/]/d; /\#\+/d; s/\s\+$//; /^$/d; /[[:blank:]]/d; /[.]/d; s/\([A-Z]\)/\L\1/g' > $TEMPFILEF
rm $TEMPFILEJ

cat -s $TEMPFILEF | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $VALIDDOMAINTLD
rm $TEMPFILEF

HOWMANYTLD=$(echo -e "`wc -l $VALIDDOMAINTLD | cut -d " " -f 1`")
printf "$yellow"    "$HOWMANYTLD Valid TLD's Total."
echo ""
