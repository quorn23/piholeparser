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

SCRIPTTEXT="Sorting and Deduping Individual Whitelists."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
for f in $WHITELISTDOMAINSALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
echo "#### $BASEFILENAME" | sudo tee --append $RECENTRUN &>/dev/null
printf "$cyan"  "Processing $BASEFILENAME"
source $DYNOVARS
timestamp=$(echo `date`)
cat -s $f | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $WWHITETEMP
cat $WWHITETEMP >> $WHITELISTTEMP
HOWMANYLINES=$(echo -e "`wc -l $WWHITETEMP | cut -d " " -f 1`")
echo "$HOWMANYLINES In $BASEFILENAME" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES In $BASEFILENAME"
rm $f
mv $WWHITETEMP $f
echo ""
done

SCRIPTTEXT="Deduplicating Merged  List."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $WHITELISTTEMP ]]
then
cat -s $WHITELISTTEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILET
rm $WHITELISTTEMP
mv $TEMPFILET $WHITELISTTEMP
else
touch $WHITELISTTEMP
fi
HOWMANYLINES=$(echo -e "`wc -l $WHITELISTTEMP | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"

if
[[ -f $DBBWHITELIST ]]
then
rm $DBBWHITELIST
fi

if
[[ -f $WHITELISTTEMP ]]
then
cp $WHITELISTTEMP $DBBWHITELIST
fi
