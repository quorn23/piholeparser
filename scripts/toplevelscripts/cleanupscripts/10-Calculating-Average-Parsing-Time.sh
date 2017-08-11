#!/bin/bash
## average parsing time

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

AVERAGEPARSETIMESEC=`awk '{ total += $1; count++ } END { print total/count }' $PARSEAVERAGEFILE`
AVERAGEPARSETIME=`expr $AVERAGEPARSETIMESEC / 60`

printf "$yellow"   "Average Parsing Time Was $AVERAGEPARSETIME Minutes."

echo "AVERAGEPARSETIME='"$AVERAGEPARSETIME"'" | tee --append $TEMPVARS &>/dev/null

echo "* Average Parsing Time Was $AVERAGEPARSETIME Minutes." | tee --append $RECENTRUN &>/dev/null

CHECKME=$PARSEAVERAGEFILE
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
