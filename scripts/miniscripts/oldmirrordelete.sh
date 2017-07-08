#!/bin/bash
## This Recreates The Temporary Variables

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

ls $MIRRORDIR > $TEMPFILE
cat $TEMPFILE | sed '/README.md/d' > $TEMPOFILE
gawk 'NR==FNR{a[$0];next} !($0 in a)' $FILETEMP $TEMPOFILE > $TEMPOFILEB

for source in `cat $TEMPOFILEB`;
do
REMMIRRORFILE="$MIRRORDIR""$source"
if
[[ $source == *.txt ]]
then
rm $REMMIRRORFILE
printf "$red"    "The $source .lst No Longer Exists. Mirror File Deleted."
fi
done
