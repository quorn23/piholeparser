#!/bin/bash
## This Recreates The SourceList

## Variables
script_dir=$(dirname $0)
STATICVARS="$script_dir"/../../scriptvars/staticvariables.var
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


CHECKME=$BIGAPLSOURCE
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
printf "$red"    "Purging Old Source List."
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
echo "* $HOWMANYSOURCE $timestamp" | tee --append $RECENTRUN &>/dev/null

## Terminal Display
printf "$yellow"    "$HOWMANYSOURCELISTS Lists To Be Processed By The Script."

## Remove Empty Lines
cat $TEMPFILE | sed '/^$/d' > $BIGAPLSOURCE
