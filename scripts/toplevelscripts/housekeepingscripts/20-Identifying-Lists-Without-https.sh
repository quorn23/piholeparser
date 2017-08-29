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

SCRIPTTEXT="Checking For Old https-Less File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if 
[[ -f $NOHTTPSLISTS ]]
then
rm $NOHTTPSLISTS
printf "$red"   "Old https-less List Removed"
echo "* Old https-less List Purged." | tee --append $RECENTRUN &>/dev/null
else
echo "* Old https-less List Does Not Exist." | tee --append $RECENTRUN &>/dev/null
fi
echo ""

echo "" | tee --append $RECENTRUN &>/dev/null
echo "___________________________________________________________________" | tee --append $RECENTRUN &>/dev/null

SCRIPTTEXT="Lists That Do NOT use https."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null

## Start File Loop
## For Every .lst File
if
ls $EVERYLISTFILEWILDCARD &> /dev/null;
then
for f in $EVERYLISTFILEWILDCARD
do

BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)

for source in `cat $f`;
do

if
[[ $source != https* ]]
then
printf "$red"    "$BASEFILENAME"
echo "* $BASEFILENAME" | tee --append $NOHTTPSLISTS &>/dev/null
fi

## End Source Loop
done

## End File Loop
done
fi
echo ""

SCRIPTTEXT="Checking List."
printf "$cyan"    "$SCRIPTTEXT"
if 
[[ -f $NOHTTPSLISTS ]]
then
printf "$yellow"   "https-less List Recreated."
HOWMANYLISTSWITHOUTHTTPS=$(echo -e "`wc -l $NOHTTPSLISTS | cut -d " " -f 1`")
printf "$red"    "$HOWMANYLISTSWITHOUTHTTPS Lists Do NOT Use HTTPS. See Log For Details."
cat $NOHTTPSLISTS >> $RECENTRUN
rm $NOHTTPSLISTS
else
printf "$green"   "All Lists Use https."
echo "All Lists Use https." | tee --append $RECENTRUN &>/dev/null
HOWMANYLISTSWITHOUTHTTPS="No"
fi

echo "HOWMANYLISTSWITHOUTHTTPS='"$HOWMANYLISTSWITHOUTHTTPS"'" | tee --append $TEMPVARS &>/dev/null

##################
##   TLD        ##
##################

SCRIPTTEXT="Checking For Old https-Less File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if 
[[ -f $NOHTTPSLISTS ]]
then
rm $NOHTTPSLISTS
printf "$red"   "Old https-less List Removed"
echo "* Old https-less List Purged." | tee --append $RECENTRUN &>/dev/null
else
echo "* Old https-less List Does Not Exist." | tee --append $RECENTRUN &>/dev/null
fi
echo ""

echo "" | tee --append $RECENTRUN &>/dev/null
echo "___________________________________________________________________" | tee --append $RECENTRUN &>/dev/null

SCRIPTTEXT="TLD Lists That Do NOT use https."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null

## Start File Loop
## For Every .lst File
if
ls $VALIDDOMAINTLDLINKS &> /dev/null;
then
for f in $VALIDDOMAINTLDLINKS
do

BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)

for source in `cat $f`;
do

if
[[ $source != https* ]]
then
printf "$red"    "$BASEFILENAME"
echo "* $BASEFILENAME" | tee --append $NOHTTPSLISTS &>/dev/null
fi

## End Source Loop
done

## End File Loop
done
fi
echo ""

SCRIPTTEXT="Checking List."
printf "$cyan"    "$SCRIPTTEXT"
if 
[[ -f $NOHTTPSLISTS ]]
then
printf "$yellow"   "https-less List Recreated."
HOWMANYLISTSWITHOUTHTTPS=$(echo -e "`wc -l $NOHTTPSLISTS | cut -d " " -f 1`")
printf "$red"    "$HOWMANYLISTSWITHOUTHTTPS Lists Do NOT Use HTTPS. See Log For Details."
cat $NOHTTPSLISTS >> $RECENTRUN
rm $NOHTTPSLISTS
else
printf "$green"   "All Lists Use https."
echo "All TLD Lists Use https." | tee --append $RECENTRUN &>/dev/null
HOWMANYLISTSWITHOUTHTTPS="No"
fi
