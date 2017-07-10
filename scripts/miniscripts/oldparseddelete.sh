#!/bin/bash
## This Removes Parsed Files That We No Longer Need

## Static Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

printf "$cyan"    "Making List of All .lst Files."
for f in $EVERYLISTFILEWILDCARD
do

## Dynamic Variables
source /etc/piholeparser/scripts/scriptvars/dynamicvariables.var

## Make List Of Every .lst file
echo "$LISTBASENAMETXT" | tee --append $FILETEMP &>/dev/null

done
echo ""

printf "$cyan"    "Making List Of Parsed Files."

## Write contents of parsed directory to a file
ls $PARSEDDIR > $TEMPFILE

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

REMPARSEDFILE="$PARSEDDIR""$source"

if
[[ $source == *.txt ]]
then
rm $REMPARSEDFILE
echo "* $source" | tee --append $TEMPFILEL &>/dev/null
echo "* The $source .lst No Longer Exists. Parsed File Deleted." | tee --append $RECENTRUN &>/dev/null
fi

done

touch $TEMPFILEL
HOWMANYPARSEDDELETED=$(echo -e "`wc -l $TEMPFILEL | cut -d " " -f 1`")

if
[[ $HOWMANYMIRRORDELETED == 0 ]]
then
printf "$red"    "$HOWMANYPARSEDDELETED Lists Deleted."
fi

rm $TEMPFILEM
rm $TEMPFILEL
