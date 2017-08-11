#!/bin/bash
## average parsing time

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
