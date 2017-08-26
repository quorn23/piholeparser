#!/bin/bash
## This sets up whitelisting

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

## Sort and Dedupe Lists
for f in $WHITELISTDOMAINSALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
source $DYNOVARS
timestamp=$(echo `date`)
cat -s $f | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $WWHITETEMP
rm $f
mv $WWHITETEMP $f
done

## Merge Whitelist into temp file
WHITESORTDEDUPE="Merging the Whitelists for Later."
WHATLISTSMERGE="$WHITELISTDOMAINSALL"
timestamp=$(echo `date`)
printf "$yellow"  "Processed $WHITESORTDEDUPE"
cat -s $WHATLISTSMERGE >> $TEMPFILEJ

## Clean up later, but add other whites
cat -s $LISTWHITELISTDOMAINS >> $TEMPFILEJ

## Dedupe
cat -s $TEMPFILEJ | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $WHITELISTTEMP

## fix me
rm $TEMPFILEJ

HOWMANYLINES=$(echo -e "`wc -l $WHITELISTTEMP | cut -d " " -f 1` Lines In File")
printf "$yellow"  "$HOWMANYLINES"

echo "* "$WHITESORTDEDUPE"." | tee --append $RECENTRUN &>/dev/null
echo "* $HOWMANYLINES" | tee --append $RECENTRUN &>/dev/null
echo "" | tee --append $RECENTRUN &>/dev/null
