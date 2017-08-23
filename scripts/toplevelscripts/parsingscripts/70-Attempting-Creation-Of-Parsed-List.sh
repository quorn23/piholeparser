#!/bin/bash
## 

## Variables
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
if
[[ -f $TEMPPARSEVARS ]]
then
source $TEMPPARSEVARS
else
echo "Temp Parsing Vars File Missing, Exiting."
exit
fi

## Delete Parsed file if current parsing method empties it
if 
[[ -f $KILLTHELIST && -f $PARSEDFILE ]]
then
printf "$red"  "Current Parsing Method Emptied File. Old File Removed."
rm $PARSEDFILE
elif
[[ ! -f $KILLTHELIST && -f $PARSEDFILE ]]
then
printf "$green"  "Old Parsed File Removed."
rm $PARSEDFILE
fi

## Remove mirror if we killed the list
if 
[[ -f $KILLTHELIST && -f $MIRROREDFILE ]]
then
printf "$red"  "Current Parsing Method Emptied File. Mirror File Removed."
rm $MIRROREDFILE
fi

## Github has a 100mb limit, and empty files are useless
if 
[[ "$PARSEDFILESIZEBYTES" -eq 0 ]]
then
printf "$red"     "Not Creating Parsed File. Nothing To Create!"
elif
[[ "$PARSEDFILESIZEMB" -ge "$GITHUBLIMITMB" ]]
then
printf "$red"     "Parsed File Too Large For Github."
echo "* $BASEFILENAME list was $FETCHFILESIZEMB MB, and too large to upload on github. $timestamp" | tee --append $RECENTRUN &>/dev/null
elif
[[ "$FETCHFILESIZEMB" -lt "$GITHUBLIMITMB" && -f $BPARSEDFILETEMP ]]
then
printf "$green"  "Creating Parsed File."
cp $BPARSEDFILETEMP $PARSEDFILE
fi
