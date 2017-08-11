#!/bin/bash
## This Removes Parsed Files That We No Longer Need

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
if
[[ -f $DYNOVARS ]]
then
source $DYNOVARS
else
echo "Dymamic Vars File Missing, Exiting."
exit
fi


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
[[ "$HOWMANYPARSEDDELETED" == 0 ]]
then
printf "$green"    "$HOWMANYPARSEDDELETED Lists Deleted."
else
printf "$red"    "$HOWMANYPARSEDDELETED Lists Deleted."
fi

rm $TEMPFILEM
rm $TEMPFILEL
