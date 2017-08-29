#!/bin/bash
## This Checks if parsing method has changed

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

SCRIPTTEXT="Finding The most recently modified Parsing Script File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
YOUNGESTPARSINGFILE=$(echo `ls -t $ACTUALPARSINGSCRIPTSDIR | awk '{printf("%s",$0);exit}'`)
YOUNGESTPARSINGFILEB="$ACTUALPARSINGSCRIPTSDIR""$YOUNGESTPARSINGFILE"
YOUNGFILEMODIFIEDLAST=$(stat -c %z "$YOUNGESTPARSINGFILEB")
YOUNGFILEMODIFIEDTIME=$(date --date="$YOUNGFILEMODIFIEDLAST" +%s)
printf "$yellow"    "The Most Recently Updated Parsing Script is $YOUNGESTPARSINGFILE"
echo "* The Most Recently Updated Parsing Script is $YOUNGESTPARSINGFILE" | sudo tee --append $RECENTRUN &>/dev/null

SCRIPTTEXT="Checking For Time Anchor File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $TIMEANCHORFILE ]]
then
echo "Time Anchor File Present." | sudo tee --append $RECENTRUN &>/dev/null
source $TIMEANCHORFILE
printf "$yellow"  "Time Anchor is set to $TIMEANCHORSTAMP"
else
echo "Time Anchor Not Present. Using $YOUNGESTPARSINGFILE Modified Time." | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "Time Anchor Not Present. Using $YOUNGESTPARSINGFILE Modified Time."
TIMEANCHORSTAMP=$YOUNGFILEMODIFIEDTIME
fi

SCRIPTTEXT="Comparing Time."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ $YOUNGFILEMODIFIEDTIME -gt $TIMEANCHORSTAMP ]]
then
printf "$green"   "Parsing Method Changed."
echo "Parsing Method Changed." | sudo tee --append $RECENTRUN &>/dev/null
EXECUTEORDERSIXTYSIX=true
else
printf "$yellow"   "Parsing Method Has Not Changed."
echo "Parsing Method Has Not Changed." | sudo tee --append $RECENTRUN &>/dev/null
fi

SCRIPTTEXT="Updating Time Anchor File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $TIMEANCHORFILE ]]
then
rm $TIMEANCHORFILE
fi

echo "## This is a time anchor file" | tee --append $TIMEANCHORFILE &>/dev/null
echo "## This is the Timestamp that the parsing process last changed" | tee --append $TIMEANCHORFILE &>/dev/null
echo "TIMEANCHORSTAMP='"$YOUNGFILEMODIFIEDTIME"'" | tee --append $TIMEANCHORFILE &>/dev/null

if
[[ EXECUTEORDERSIXTYSIX == true ]]
then
SCRIPTTEXT="Resetting For a Re-Parse."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
fi

if
[[ EXECUTEORDERSIXTYSIX == true ]]
then
{ if
ls $PARSEDLISTSALL &> /dev/null;
then
echo "* Resetting Parsed Lists For Reprocessing" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"   "Resetting Parsed Lists For Reprocessing."
rm $PARSEDLISTSALL
fi }
fi

if
[[ EXECUTEORDERSIXTYSIX == true ]]
then
{ if
ls $KILLTHELISTALL &> /dev/null;
then
echo "* Resetting Killed Lists For Reprocessing" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"   "Resetting Killed Lists For Reprocessing."
for f in $KILLTHELISTALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
BUNDEADPARSELIST="$MAINLISTSDIR""$BASEFILENAME".lst
mv $f $BUNDEADPARSELIST
done
fi }
fi
