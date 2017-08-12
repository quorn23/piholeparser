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

## Check if file is modified since last download
if 
[[ -f $MIRROREDFILE && -z $PINGTESTFAILED ]]
then
SOURCEMODIFIEDLAST=$(curl --silent --head $source | awk -F: '/^Last-Modified/ { print $2 }')
SOURCEMODIFIEDTIME=$(date --date="$SOURCEMODIFIEDLAST" +%s)
LOCALFILEMODIFIEDLAST=$(stat -c %z "$MIRROREDFILE")
LOCALFILEMODIFIEDTIME=$(date --date="$LOCALFILEMODIFIEDLAST" +%s)
DIDWECHECKONLINEFILE=true
fi

if
[[ -f $MIRROREDFILE && -z $PINGTESTFAILED && -n $DIDWECHECKONLINEFILE && $LOCALFILEMODIFIEDTIME -lt $SOURCEMODIFIEDTIME ]]
then
printf "$yellow"    "File Has Changed Online."
elif
[[ -f $MIRROREDFILE && -z $PINGTESTFAILED && -n $DIDWECHECKONLINEFILE && $LOCALFILEMODIFIEDTIME -ge $SOURCEMODIFIEDTIME ]]
then
FULLSKIPPARSING=true
printf "$green"    "File Not Updated Online. No Need To Process."
fi
