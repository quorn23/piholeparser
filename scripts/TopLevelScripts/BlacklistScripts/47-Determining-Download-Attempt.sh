#!/bin/bash
## How should we download

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
[[ -z $SKIPDOWNLOAD && $source == *.7z ]]
then
SOURCETYPE=sevenzip
elif
[[ -z $SKIPDOWNLOAD && $source == *.tar.gz ]]
then
SOURCETYPE=tar
elif
[[ -z $SKIPDOWNLOAD && $source == *.zip ]]
then
SOURCETYPE=zip
elif
[[ -z $SKIPDOWNLOAD && $source == "file:///"* ]]
then
SOURCETYPE=localfile
elif
[[ -z $SKIPDOWNLOAD && $source == *"?"* ]]
then
SOURCETYPE=webpage
elif
[[ -z $SKIPDOWNLOAD && $source == *"="* ]]
then
SOURCETYPE=webpage
elif
[[ -z $SKIPDOWNLOAD && $source == *.php ]]
then
SOURCETYPE=webpage
elif
[[ -z $SKIPDOWNLOAD && $source == *.htm ]]
then
SOURCETYPE=webpage
elif
[[ -z $SKIPDOWNLOAD && $source == *.html ]]
then
SOURCETYPE=webpage
elif
[[ -z $SKIPDOWNLOAD && $source == *.txt ]]
then
SOURCETYPE=plaintext
elif
[[ -z $SKIPDOWNLOAD && $source == *.csv ]]
then
SOURCETYPE=plaintext
elif
[[ -z $SKIPDOWNLOAD && $source == *hosts ]]
then
SOURCETYPE=plaintext
fi

## use mirror
if
[[ -n $SKIPDOWNLOAD ]]
then
SOURCETYPE=usemirrorfile
fi

## set the sourcetype if not
if
[[ -z $SOURCETYPE ]]
then
SOURCETYPE=unknown
fi

if
[[ -n $SOURCETYPE ]]
then
printf "$yellow"    "The Download Should use the $SOURCETYPE Preset."
echo "SOURCETYPE="$SOURCETYPE"" | tee --append $TEMPPARSEVARS &>/dev/null
fi
