#!/bin/bash
## This is the Blacklist Parsing Process

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/../foldervars.var

RECENTRUNBANDAID="$RECENTRUN"
ONEUPBANDAID="$SCRIPTBASEFOLDERNAME"

SCRIPTTEXT="Sorting and Deduping Individual Blacklists."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
echo ""

if
ls $BLACKDOMAINSALL &> /dev/null;
then

for f in $BLACKDOMAINSALL
do

source=`cat $f`

SOURCEDOMAIN=`echo $source | awk -F/ '{print $3}'`
if
[[ -n $SOURCEDOMAIN ]]
then
echo "$SOURCEDOMAIN" | tee --append $BLACKSCRIPTDOMAINS &>/dev/null
fi

done
HOWMANYLINES=$(echo -e "`wc -l $BLACKSCRIPTDOMAINS | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"
echo ""
else
echo "No Blacklists Present."
fi
