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

## Find The most recently modified parsing.sh
YOUNGESTPARSINGFILE=$(echo `ls -t $ACTUALPARSINGSCRIPTSDIR | awk '{printf("%s",$0);exit}'`)
YOUNGESTPARSINGFILEB="$ACTUALPARSINGSCRIPTSDIR""$YOUNGESTPARSINGFILE"
YOUNGFILEMODIFIEDLAST=$(stat -c %z "$YOUNGESTPARSINGFILEB")
YOUNGFILEMODIFIEDTIME=$(date --date="$YOUNGFILEMODIFIEDLAST" +%s)

if
[[ -f $TIMEANCHORFILE ]]
then
source $TIMEANCHORFILE
else
TIMEANCHORSTAMP=$YOUNGFILEMODIFIEDTIME
fi

if
[[ $YOUNGFILEMODIFIEDTIME -gt $TIMEANCHORSTAMP ]]
then
printf "$green"   "Parsing Method Changed."
EXECUTEORDERSIXTYSIX=true
else
printf "$yellow"   "Parsing Method Has Not Changed."
fi

## update timestamp on anchor file
if
[[ -f $TIMEANCHORFILE ]]
then
rm $TIMEANCHORFILE
echo "## This is a time anchor file" | tee --append $TIMEANCHORFILE &>/dev/null
echo "## This is the Timestamp that the parsing process last changed" | tee --append $TIMEANCHORFILE &>/dev/null
echo "TIMEANCHORSTAMP='"$YOUNGFILEMODIFIEDTIME"'" | tee --append $TIMEANCHORFILE &>/dev/null
fi

if
[[ -n EXECUTEORDERSIXTYSIX && ls $PARSEDLISTSALL &> /dev/null ]]
then
rm $PARSEDLISTSALL
fi

if
[[ -n EXECUTEORDERSIXTYSIX && ls $KILLTHELISTALL &> /dev/null ]]
then
for f in $KILLTHELISTALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
BUNDEADPARSELIST="$MAINLISTSDIR""$BASEFILENAME".lst
mv $f $BUNDEADPARSELIST
done
fi
