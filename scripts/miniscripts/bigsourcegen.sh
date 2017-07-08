#!/bin/bash
## This Recreates The SourceList

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

CHECKME=$BIGAPLSOURCE
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

cat $EVERYLISTFILEWILDCARD | sort > $TEMPFILE

HOWMANYSOURCELISTS=$(echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1`")
HOWMANYSOURCE="$HOWMANYSOURCELISTS lists to be processed by the script."

echo "HOWMANYSOURCELISTS='"$HOWMANYSOURCELISTS"'" | tee --append $TEMPVARS &>/dev/null
echo "HOWMANYSOURCE='"$HOWMANYSOURCE"'" | tee --append $TEMPVARS &>/dev/null
echo "$HOWMANYSOURCE"
echo "* $HOWMANYSOURCE $timestamp" | tee --append $RECENTRUN &>/dev/null

sed '/^$/d' $TEMPFILE > $FILETEMP

mv $FILETEMP $BIGAPLSOURCE
