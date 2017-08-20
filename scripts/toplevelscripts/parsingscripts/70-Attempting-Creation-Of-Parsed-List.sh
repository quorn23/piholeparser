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

## if we skipped parsing due to file not changing
if
[[ -n $FULLSKIPPARSING && -f $PARSEDFILE ]]
then
HOWMANYLINES=$(echo -e "`wc -l $PARSEDFILE | cut -d " " -f 1`")
printf "$green"  "Old Parsed File Retained."
printf "$yellow"  "$HOWMANYLINES Lines In File."
fi

## Delete Parsed file if current parsing method empties it
if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO && -n $ORIGFILESIZENOTZERO && -f $PARSEDFILE ]]
then
printf "$red"  "Current Parsing Method Emptied File. Old File Removed."
rm $PARSEDFILE
fi

if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO && -n $ORIGFILESIZENOTZERO && -f $MIRROREDFILE ]]
then
printf "$red"  "Current Parsing Method Emptied File. Old Mirror File Removed."
rm $MIRROREDFILE
fi


## let's get rid of the deadweight
if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO && -n $ORIGFILESIZENOTZERO ]]
then
printf "$red"  "Current Parsing Method Emptied File. It will be skipped in the future."
echo "* $BASEFILENAME List Was Killed By The Parsing Process. It will be skipped in the future. $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $FILEBEINGPROCESSED $KILLTHELIST
fi

## Github has a 100mb limit, and empty files are useless
if
[[ -z $FULLSKIPPARSING ]]
then
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO ]]
then
printf "$red"     "Not Creating Parsed File. Nothing To Create!"
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && "$FETCHFILESIZEMB" -ge "$GITHUBLIMITMB" ]]
then
printf "$red"     "Parsed File Too Large For Github. Deleting."
echo "* $BASEFILENAME list was $FETCHFILESIZEMB MB, and too large to push to github. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && "$FETCHFILESIZEMB" -lt "$GITHUBLIMITMB" ]]
then
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZEMB MB."
printf "$green"  "Parsed File Completed Succesfully."
echo "* $BASEFILENAME list was Updated. $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $BTEMPFILE $PARSEDFILE
fi
