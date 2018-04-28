#!/bin/bash
## This is the Parsing Process

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/../foldervars.var

RECENTRUNBANDAID="$RECENTRUN"

#!/bin/bash
## This sets up blacklisting for domains in .lst files

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/foldervars.var

## Quick File Check
timestamp=$(echo `date`)

SCRIPTTEXT="Checking For Blacklist File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $BLACKSCRIPTDOMAINS ]]
then
printf "$red"  "Removing Blacklist File."
echo ""
rm $BLACKSCRIPTDOMAINS
touch $BLACKSCRIPTDOMAINS
echo "* Blacklist File removed $timestamp" | tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"  "Blacklist File not there. Not Removing."
echo ""
touch $BLACKSCRIPTDOMAINS
echo "* Blacklist File not there, not removing. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
echo ""

SCRIPTTEXT="Pulling Domains From Lists."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null

if
ls $BLACKLSTALL &> /dev/null;
then

for f in $BLACKLSTALL
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

SCRIPTTEXT="Deduping List."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $BLACKSCRIPTDOMAINS ]]
then
cat -s $BLACKSCRIPTDOMAINS | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILEH
rm $BLACKSCRIPTDOMAINS
mv $TEMPFILEH $BLACKSCRIPTDOMAINS
else
touch $BLACKSCRIPTDOMAINS
fi
HOWMANYLINES=$(echo -e "`wc -l $BLACKSCRIPTDOMAINS | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"


SCRIPTTEXT="Sorting and Deduping Individual Blacklists."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
echo ""

if
ls $BLACKLSTALL &> /dev/null;
then

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

else
echo "No Blacklists Present."
fi

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
