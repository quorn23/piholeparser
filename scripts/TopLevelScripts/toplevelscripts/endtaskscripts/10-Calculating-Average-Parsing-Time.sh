#!/bin/bash
## average parsing time

## Variables
source ./foldervars.var

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
