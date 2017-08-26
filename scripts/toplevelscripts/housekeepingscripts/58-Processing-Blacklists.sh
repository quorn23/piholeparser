#!/bin/bash
## This sets up blacklisting

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
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

RECENTRUN="$HOUSEKEEPINGSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

## Sort And Dedupe Lists
for f in $BLACKLISTDOMAINSALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
source $DYNOVARS
timestamp=$(echo `date`)
cat -s $f | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BBLACKTEMP
rm $f
mv $BBLACKTEMP $f
done

## Merge Lists
BLACKSORTDEDUPE="Merging the Blacklists for Later."
WHATLISTSMERGE="$BLACKLISTDOMAINSALL"
timestamp=$(echo `date`)
printf "$yellow"  "Processed $BLACKSORTDEDUPE"
cat -s $WHATLISTSMERGE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BLACKLISTTEMP
HOWMANYLINES=$(echo -e "`wc -l $BLACKLISTTEMP | cut -d " " -f 1` Lines In File")
printf "$yellow"  "$HOWMANYLINES"

echo "* "$BLACKSORTDEDUPE"." | tee --append $RECENTRUN &>/dev/null
echo "* $HOWMANYLINES" | tee --append $RECENTRUN &>/dev/null
echo "" | tee --append $RECENTRUN &>/dev/null
