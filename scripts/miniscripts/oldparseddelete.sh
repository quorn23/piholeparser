#!/bin/bash
## This Removes Parsed Files That We No Longer Need

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

for f in $EVERYLISTFILEWILDCARD
do
source /etc/piholeparser/scripts/scriptvars/dynamicvariables.var
TEMPOFILE="$TEMPDIR"TEMPOFILE.txt
TEMPOFILEB="$TEMPDIR"TEMPOFILEB.txt
LISTBASENAMETXT="$BASEFILENAME".txt
echo "$LISTBASENAMETXT" | tee --append $FILETEMP &>/dev/null
done

ls $PARSEDDIR > $TEMPFILE
cat $TEMPFILE | sed '/README.md/d' > $TEMPOFILE
gawk 'NR==FNR{a[$0];next} !($0 in a)' $FILETEMP $TEMPOFILE > $TEMPOFILEB

for source in `cat $TEMPOFILEB`;
do
REMPARSEDFILE="$PARSEDDIR""$source"
if
[[ $source == *.txt ]]
then
rm $REMPARSEDFILE
printf "$red"    "The $source .lst No Longer Exists. Parsed File Deleted."
fi
done
