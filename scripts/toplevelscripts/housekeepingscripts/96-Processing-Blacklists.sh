#!/bin/bash
## This sets up blacklisting

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

WHATITIS="Blacklist File"
CHECKME=$LISTWHITELISTDOMAINS
timestamp=$(echo `date`)
printf "$yellow"  "Checking For $WHATITIS"
echo ""

## Quick File Check
if
ls $CHECKME &> /dev/null;
then
printf "$red"  "Removing $WHATITIS"
echo ""
rm $CHECKME
touch $CHECKME
echo "* $WHATITIS removed $timestamp" | tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"  "$WHATITIS not there. Not Removing."
echo ""
touch $CHECKME
echo "* $WHATITIS not there, not removing. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

## Sort And Dedupe Lists
for f in $BLACKLISTDOMAINSALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
source $DYNOVARS
WHATLISTTOSORT=$f
BLACKSORTDEDUPE="$BASEFILENAME Domains."
timestamp=$(echo `date`)
#printf "$yellow"  "Processing $BLACKSORTDEDUPE."
cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BBLACKTEMP
HOWMANYLINES=$(echo -e "`wc -l $BBLACKTEMP | cut -d " " -f 1` Lines In File")
#echo "$HOWMANYLINES"
rm $WHATLISTTOSORT
mv $BBLACKTEMP $WHATLISTTOSORT
#echo ""
done

## Merge Lists
BLACKSORTDEDUPE="Merging the Blacklists for Later."
WHATLISTSMERGE="$BLACKLISTDOMAINSALL"
timestamp=$(echo `date`)
printf "$yellow"  "Processed $BLACKSORTDEDUPE"
cat -s $WHATLISTSMERGE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BLACKLISTTEMP
HOWMANYLINES=$(echo -e "`wc -l $BLACKLISTTEMP | cut -d " " -f 1` Lines In File")
echo "$HOWMANYLINES"
echo "* "$BLACKSORTDEDUPE"." | tee --append $RECENTRUN &>/dev/null
echo "* $HOWMANYLINES" | tee --append $RECENTRUN &>/dev/null
echo ""
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$orange" "___________________________________________________________"
echo ""
