#!/bin/bash
## This Removes Mirrored Files That We No Longer Need

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

printf "$cyan"    "Making List of All .lst Files."
for f in $EVERYLISTFILEWILDCARD
do

## Dynamic Variables
source $DYNOVARS

## Make List Of Every .lst file
echo "$LISTBASENAMETXT" | tee --append $FILETEMP &>/dev/null

done
echo ""

printf "$cyan"    "Making List Of Mirror Files."

## Write contents of Mirror directory to a file
ls $MIRRORDIR > $TEMPFILE

## Ignore readme.md
cat $TEMPFILE | sed '/README.md/d' > $TEMPFILEN
echo ""

printf "$cyan"    "Comparing Lists."

## Compare
gawk 'NR==FNR{a[$0];next} !($0 in a)' $FILETEMP $TEMPFILEN > $TEMPFILEM
rm $TEMPFILE
rm $FILETEMP
rm $TEMPFILEN
echo ""

for source in `cat $TEMPFILEM`;
do

REMMIRRORFILE="$MIRRORDIR""$source"

if
[[ $source == *.txt ]]
then
rm $REMMIRRORFILE
echo "* $source" | tee --append $TEMPFILEL &>/dev/null
echo "* The $source .lst No Longer Exists. Mirrored File Deleted." | tee --append $RECENTRUN &>/dev/null
fi

done

touch $TEMPFILEL
HOWMANYMIRRORDELETED=$(echo -e "`wc -l $TEMPFILEL | cut -d " " -f 1`")

if
[[ "$HOWMANYMIRRORDELETED" == 0 ]]
then
printf "$green"    "$HOWMANYMIRRORDELETED Lists Deleted."
else
printf "$red"    "$HOWMANYMIRRORDELETED Lists Deleted."
fi

rm $TEMPFILEM
rm $TEMPFILEL
