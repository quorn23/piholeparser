#!/bin/bash
## This sets up blacklisting

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/foldervars.var

SCRIPTTEXT="Sorting and Deduping Individual Blacklists."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
for f in $BLACKDOMAINSALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
echo "#### $BASEFILENAME" | sudo tee --append $RECENTRUN &>/dev/null
printf "$cyan"  "Processing $BASEFILENAME"

timestamp=$(echo `date`)
cat -s $f | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILEA
cat $TEMPFILEA >> $BLACKLISTTEMP
HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
echo "$HOWMANYLINES In $BASEFILENAME" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES In $BASEFILENAME"
rm $f
mv $TEMPFILEA $f
echo ""
done

SCRIPTTEXT="Deduplicating Merged List."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $BLACKLISTTEMP ]]
then
cat -s $BLACKLISTTEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILER
rm $BLACKLISTTEMP
mv $TEMPFILER $BLACKLISTTEMP
else
touch $BLACKLISTTEMP
fi
HOWMANYLINES=$(echo -e "`wc -l $BLACKLISTTEMP | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"
