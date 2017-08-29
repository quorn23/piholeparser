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
AVERAGEPARSETIME=$(echo `awk '{ total += $1; count++ } END { print total/count }' $PARSEAVERAGEFILE`)
AVERAGEPARSENUM=$(echo -e "`wc -l $PARSEAVERAGEFILE | cut -d " " -f 1`")
fi

if
[[ -z $AVERAGEPARSETIME ]]
then
AVERAGEPARSETIME="unknown"
fi
echo "AVERAGEPARSETIME='"$AVERAGEPARSETIME"'" | tee --append $TEMPVARS &>/dev/null

if
[[ -z $AVERAGEPARSENUM ]]
then
AVERAGEPARSENUM="unknown"
fi
echo "AVERAGEPARSENUM='"$AVERAGEPARSENUM"'" | tee --append $TEMPVARS &>/dev/null
printf "$yellow"   "Average Parsing Time Of $AVERAGEPARSENUM Lists Was $AVERAGEPARSETIME Seconds."

echo "* Average Parsing Time Of $AVERAGEPARSENUM Lists Was $AVERAGEPARSETIME Seconds." | tee --append $RECENTRUN &>/dev/null

if
ls $PARSEAVERAGEFILE &> /dev/null;
then
rm $PARSEAVERAGEFILE
fi
