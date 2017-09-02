#!/bin/bash
## TLD didnt pass

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
if
[[ -f $TEMPVARS ]]
then
source $TEMPVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi

RECENTRUN="$ENDTASKSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

if
[[ -f $TRYNACATCHFIlES ]]
then
printf "$yellow"  "Removing duplicates."
cat -s $TRYNACATCHFIlES | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' >> $FILETEMP
HOWMANYLINES=$(echo -e "`wc -l $FILETEMP | cut -d " " -f 1`")
printf "$yellow"    "$HOWMANYLINES Lines After Deduping."
echo "* $HOWMANYLINES Lines After Deduping. $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "____________________________________________________" | tee --append $RECENTRUN &>/dev/null
for source in `cat $FILETEMP`;
do
echo "* $source" | tee --append $RECENTRUN &>/dev/null
done
rm $FILETEMP
else
printf "$yellow"  "Either all lines past TLD test, or the file is missing."
fi
