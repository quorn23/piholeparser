#!/bin/bash
## Check online header

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

if 
[[ -f $MIRROREDFILE && -z $PINGTESTFAILED ]]
then
GOAHEADANDTEST=true
elif
[[ ! -f $MIRROREDFILE && -z $PINGTESTFAILED ]]
then
printf "$red"    "No Mirror File To Compare With, Proceeding with Download."
fi

## Check if file is modified since last download
if 
[[ -n $GOAHEADANDTEST ]]
then
printf "$cyan"    "Attempting To Test File Modified Date."
SOURCEMODIFIEDLAST=$(curl --silent --head $source | awk -F: '/^Last-Modified/ { print $2 }')
SOURCEMODIFIEDTIME=$(date --date="$SOURCEMODIFIEDLAST" +%s)
LOCALFILEMODIFIEDLAST=$(stat -c %z "$MIRROREDFILE")
LOCALFILEMODIFIEDTIME=$(date --date="$LOCALFILEMODIFIEDLAST" +%s)
{ if
[[ $LOCALFILEMODIFIEDTIME -ge $SOURCEMODIFIEDTIME ]]
then
printf "$yellow"    "Source Date Not Newer."
SKIPDOWNLOAD=true
elif
[[ $LOCALFILEMODIFIEDTIME -lt $SOURCEMODIFIEDTIME ]]
then
printf "$yellow"    "Source Date Is Newer."
else
printf "$red"    "File Header Check Failed."
fi }
else
printf "$red"    "File Header Check Failed."
fi

if 
[[ -n $GOAHEADANDTEST && -z $SKIPDOWNLOAD ]]
then
printf "$cyan"    "Attempting To Test File Size."
SOURCEFILESIZE=$(curl -s $source | wc -c)
LOCALFILESIZE=$(stat -c%s "$MIRROREDFILE")
{ if
[[ $SOURCEFILESIZE == $LOCALFILESIZE ]]
then
printf "$yellow"    "File Size Is The Same."
SKIPDOWNLOAD=true
elif
[[ $SOURCEFILESIZE != $LOCALFILESIZE ]]
then
printf "$yellow"    "File Size Is Different."
else
printf "$red"    "File Size Check Failed."
fi }
else
printf "$red"    "File Size Check Failed."
fi

if
[[ -n $GOAHEADANDTEST && -n $SKIPDOWNLOAD ]]
then
printf "$green"    "File Not Updated Online. No Need To Download."
echo "SKIPDOWNLOAD="$SKIPDOWNLOAD"" | tee --append $TEMPPARSEVARS &>/dev/null
else
printf "$yellow"    "File Has Changed Online."
fi

if
[[ -f $MIRROREDFILE && -f $PARSEDFILE && -n $SKIPDOWNLOAD ]]
then
printf "$green"    "Since Parsed File is Present, There Is No Need To Process."
FULLSKIPPARSING=true
echo "FULLSKIPPARSING="$FULLSKIPPARSING"" | tee --append $TEMPPARSEVARS &>/dev/null
fi
