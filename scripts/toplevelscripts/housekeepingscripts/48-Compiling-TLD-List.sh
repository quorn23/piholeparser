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

CHECKME=$ALLTLDMLISTSDIR
if
ls $CHECKME &> /dev/null;
then
cat $ALLTLDMLISTSDIR >> $VALIDDOMAINTLD
else
touch $VALIDDOMAINTLD
fi

if
[[ -f $TLDCOMPARED ]]
then
rm $TLDCOMPARED
echo "Old TLD Comparison Removed." | sudo tee --append $RECENTRUN &>/dev/null
else
echo "Old TLD Comparison Not Present." | sudo tee --append $RECENTRUN &>/dev/null
fi

printf "$cyan"    "Formatting TLD List."
if
[[ -f $VALIDDOMAINTLD ]]
then
cat $VALIDDOMAINTLD | sed '/[/]/d; /\#\+/d; s/\s\+$//; /^$/d; /[[:blank:]]/d; /[.]/d; s/\([A-Z]\)/\L\1/g' > $TEMPFILEF
rm $VALIDDOMAINTLD
else
touch $TEMPFILEF
fi

printf "$cyan"    "Removing Duplicatates From TLD List."
if
[[ -f $TEMPFILEF ]]
then
cat -s $TEMPFILEF | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $VALIDDOMAINTLD
rm $TEMPFILEF
else
touch $VALIDDOMAINTLD
fi

HOWMANYTLD=$(echo -e "`wc -l $VALIDDOMAINTLD | cut -d " " -f 1`")
echo "HOWMANYTLDTOTAL='"$HOWMANYTLD"'" | tee --append $TEMPVARS &>/dev/null
printf "$yellow"    "$HOWMANYTLD Valid TLD's Total."
echo "$HOWMANYTLD Valid TLD's Total." | sudo tee --append $RECENTRUN &>/dev/null
