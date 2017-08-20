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

## What type of source?
if
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.7z ]]
then
SOURCETYPE=sevenzip
elif
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.tar.gz ]]
then
SOURCETYPE=tar
elif
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.zip ]]
then
SOURCETYPE=zip
elif
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.php ]]
then
SOURCETYPE=php
elif
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.txt ]]
then
SOURCETYPE=text
elif
[[ -z $FULLSKIPPARSING && -n PINGTESTFAILED && -f $MIRROREDFILE ]]
then
SOURCETYPE=usemirrorfile
else
SOURCETYPE=unknown
fi

## Add to tempvars
echo "SOURCETYPE="$SOURCETYPE"" | tee --append $TEMPPARSEVARS &>/dev/null

## Terminal Display
timestamp=$(echo `date`)
if
[[ -z $FULLSKIPPARSING && -n $SOURCEIP && -n $UPCHECK && -n $SOURCETYPE ]]
then
printf "$cyan"    "Fetching $SOURCETYPE List From $UPCHECK Located At The IP address Of "$SOURCEIP"."
elif
[[ -z $FULLSKIPPARSING && $SOURCETYPE == usemirrorfile ]]
then
printf "$cyan"    "Attempting To Fetch List From Git Repo Mirror."
echo "* $BASEFILENAME List Unavailable To Download. Attempted to use Mirror. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
