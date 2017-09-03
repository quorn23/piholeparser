!/bin/bash
## average parsing time

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/foldervars.var
PARSEAVERAGEFILELINES
if
[[ -f $PARSEAVERAGEFILELINES ]]
then
AVERAGEPARSELINES=$(echo `awk '{ total += $1; count++ } END { print total/count }' $PARSEAVERAGEFILELINES`)
AVERAGEPARSENUMLINES=$(echo -e "`wc -l $PARSEAVERAGEFILELINES | cut -d " " -f 1`")
fi

if
[[ -z $AVERAGEPARSELINES ]]
then
AVERAGEPARSELINES="unknown"
fi
echo "AVERAGEPARSELINES='"$AVERAGEPARSELINES"'" | tee --append $TEMPVARS &>/dev/null

if
[[ -z $AVERAGEPARSENUMLINES ]]
then
AVERAGEPARSENUMLINES="unknown"
fi
echo "AVERAGEPARSENUMLINES='"$AVERAGEPARSENUMLINES"'" | tee --append $TEMPVARS &>/dev/null
printf "$yellow"   "Average Parsing Time Of $AVERAGEPARSENUMLINES Lists Was $AVERAGEPARSELINES Seconds."

echo "* Average Parsing Time Of $AVERAGEPARSENUMLINES Lists Was $AVERAGEPARSELINES Seconds." | tee --append $RECENTRUN &>/dev/null

if
ls $PARSEAVERAGEFILELINES &> /dev/null;
then
rm $PARSEAVERAGEFILELINES
fi
