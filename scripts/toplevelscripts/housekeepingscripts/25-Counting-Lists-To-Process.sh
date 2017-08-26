#!/bin/bash
## This Recreates The SourceList

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
[[ -f $BIGAPLSOURCE ]]
then
rm $BIGAPLSOURCE
printf "$red"    "Purging Old Source List."
echo "Old Source List Purged." | tee --append $RECENTRUN &>/dev/null
fi

## Collect all the sources into one file
printf "$cyan"    "Merging Sources."
cat $EVERYLISTFILEWILDCARD | sort > $TEMPFILE

## Math Time
HOWMANYSOURCELISTS=$(echo -e "`wc -l $TEMPFILE | cut -d " " -f 1`")
HOWMANYSOURCE="$HOWMANYSOURCELISTS Lists Processed By The Script."

## Save to Tempvars
echo "HOWMANYSOURCELISTS='"$HOWMANYSOURCELISTS"'" | tee --append $TEMPVARS &>/dev/null
echo "HOWMANYSOURCE='"$HOWMANYSOURCE"'" | tee --append $TEMPVARS &>/dev/null

## Log Activity
echo "* $HOWMANYSOURCE" | tee --append $RECENTRUN &>/dev/null

## Terminal Display
printf "$yellow"    "$HOWMANYSOURCE"

## Remove Empty Lines
cat $TEMPFILE | sed '/^$/d' > $BIGAPLSOURCE
