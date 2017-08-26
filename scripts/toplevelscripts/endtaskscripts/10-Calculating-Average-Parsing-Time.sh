#!/bin/bash
## average parsing time

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

RECENTRUN="$ENDTASKSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

if
[[ -f $PARSEAVERAGEFILE ]]
then
AVERAGEPARSETIMESEC=$(echo `awk '{ total += $1; count++ } END { print total/count }' $PARSEAVERAGEFILE`)
AVERAGEPARSETIME=`expr $AVERAGEPARSETIMESEC / 60`
fi

if
[[ -z $AVERAGEPARSETIME ]]
then
AVERAGEPARSETIME="unknown"
fi

printf "$yellow"   "Average Parsing Time Was $AVERAGEPARSETIME Minutes."

echo "AVERAGEPARSETIME='"$AVERAGEPARSETIME"'" | tee --append $TEMPVARS &>/dev/null

echo "* Average Parsing Time Was $AVERAGEPARSETIME Minutes." | tee --append $RECENTRUN &>/dev/null

CHECKME=$PARSEAVERAGEFILE
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
