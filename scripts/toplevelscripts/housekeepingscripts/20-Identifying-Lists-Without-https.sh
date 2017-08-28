#!/bin/bash
## This Generates a list of which blacklists don't use https

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

RECENTRUN="$HOUSEKEEPINGSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md
RECENTRUNWITHOUTHTTPSMD="$HOUSEKEEPINGSCRIPTSLOGDIRRAW""$SCRIPTBASEFILENAME".md
echo "RECENTRUNWITHOUTHTTPSMD='"$RECENTRUNWITHOUTHTTPSMD"'" | tee --append $TEMPVARS &>/dev/null

if 
[[ -f $NOHTTPSLISTS ]]
then
rm $NOHTTPSLISTS
printf "$red"   "Old https-less List Removed"
echo "Old https-less List Purged." | tee --append $RECENTRUN &>/dev/null
echo "" | tee --append $RECENTRUN &>/dev/null
echo "___________________________________________________________________" | tee --append $RECENTRUN &>/dev/null
fi

## Start File Loop
## For Every .lst File
for f in $EVERYLISTFILEWILDCARD
do

BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)

for source in `cat $f`;
do

if
[[ $source != https* ]]
then
echo "* $BASEFILENAME" | tee --append $RECENTRUN &>/dev/null
echo "* $BASEFILENAME" | tee --append $NOHTTPSLISTS &>/dev/null
fi

## End Source Loop
done

## End File Loop
done

if 
[[ -f $NOHTTPSLISTS ]]
then
printf "$yellow"   "https-less List Recreated."
HOWMANYLISTSWITHOUTHTTPS=$(echo -e "`wc -l $NOHTTPSLISTS | cut -d " " -f 1`")
HOWMANYLISTSWITHOUTHTTPSB=$(expr $HOWMANYLISTSWITHOUTHTTPS - 1)
echo ""
printf "$red"    "$HOWMANYLISTSWITHOUTHTTPSB Lists Do NOT Use HTTPS. See Log For Details."
else
printf "$green"   "All Lists Use https."
echo "All Lists Use https." | tee --append $NOHTTPSLISTS &>/dev/null
fi
