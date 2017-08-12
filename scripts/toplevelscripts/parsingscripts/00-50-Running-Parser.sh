#!/bin/bash
## This is the Parsing Process

## Variables
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

## Process Every .lst file within the List Directories
for f in $EVERYLISTFILEWILDCARD
do

printf "$lightblue"    "$DIVIDERBAR"
echo ""

## Declare File Name
FILEBEINGPROCESSED=$f
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
echo "FILEBEINGPROCESSED="$FILEBEINGPROCESSED"" | tee --append $TEMPPARSEVARS &>/dev/null
echo "BASEFILENAME="$BASEFILENAME"" | tee --append $TEMPPARSEVARS &>/dev/null

printf "$green"    "Processing $BASEFILENAME List."
echo "" 



####################
## Check Filesize ##
####################

## Throughout the script, if the file has no content, it will skip to the end
## by setting the FILESIZEZERO variable

printf "$cyan"    "Verifying $BASEFILENAME File Size."

## set filesizezero variable if empty
if
[[ -z $FULLSKIPPARSING ]]
then
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if 
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
timestamp=$(echo `date`)
printf "$red"     "$BASEFILENAME List Was An Empty File After Download."
echo "* $BASEFILENAME List Was An Empty File After Download. $timestamp" | tee --append $RECENTRUN &>/dev/null
touch $BORIGINALFILETEMP
elif
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -gt 0 ]]
then
ORIGFILESIZENOTZERO=true
HOWMANYLINES=$(echo -e "`wc -l $BORIGINALFILETEMP | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After Download."
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZEMB MB."
printf "$yellow"  "$ENDCOMMENT"
echo ""
fi

## Duplicate the downloaded file for the next steps
touch $BORIGINALFILETEMP
if
ls $BORIGINALFILETEMP &> /dev/null;
then
cp $BORIGINALFILETEMP $BTEMPFILE
cp $BORIGINALFILETEMP $BFILETEMP
rm $BORIGINALFILETEMP
fi

####################
## Create Mirrors ##
####################

printf "$cyan"   "Attempting Creation of Mirror File."

if
[[ -n $FULLSKIPPARSING ]]
then
printf "$green"  "Old Mirror File Retained."
echo ""
fi

## This helps when replacing the mirrored file
if 
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && -f $MIRROREDFILE ]]
then
printf "$green"  "Old Mirror File Removed"
rm $MIRROREDFILE
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
printf "$red"     "Not Creating Mirror File. Nothing To Create!"
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && "$FETCHFILESIZEMB" -ge "$GITHUBLIMITMB" ]]
then
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo "* $BASEFILENAME list was $FETCHFILESIZEMB MB, and too large to mirror on github. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && "$FETCHFILESIZEMB" -lt "$GITHUBLIMITMB" ]]
then
printf "$green"  "Creating Mirror Of Unparsed File."
mv $BTEMPFILE $MIRROREDFILE
fi
echo ""

####################
## Processing     ##
####################

## New Parsing logic
mv $BFILETEMP $TEMPFILEL

## Start time
STARTPARSESTAMP=$(date +"%s")

## Start File Loop
## For .sh files In The parsing scripts Directory
for p in $ALLACTUALPARSINGSCRIPTS
do
PBASEFILENAME=$(echo `basename $p | cut -f 1 -d '.'`)
PBASEFILENAMEDASHNUM=$(echo $PBASEFILENAME | sed 's/[0-9\-]/ /g')
PBNAMEPRETTYSCRIPTTEXT=$(echo $PBASEFILENAMEDASHNUM)
SCRIPTTEXT=""$PBNAMEPRETTYSCRIPTTEXT"."
PARSECOMMENT="$SCRIPTTEXT"

if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
touch $TEMPFILEL
FETCHFILESIZE=$(stat -c%s "$TEMPFILEL")
fi

if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
bash $p
touch $TEMPFILEM
rm $TEMPFILEL
FETCHFILESIZE=$(stat -c%s "$TEMPFILEM")
HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEM | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $TEMPFILEM $TEMPFILEL
fi

if
[[ -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi

if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

done

printf "$cyan"   "Calculating Parse Time."

## end time
ENDPARSESTAMP=$(date +"%s")
DIFFTIMEPARSESEC=`expr $ENDPARSESTAMP - $STARTPARSESTAMP`
DIFFTIMEPARSE=`expr $DIFFTIMEPARSESEC / 60`
if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
echo "$DIFFTIMEPARSESEC" | tee --append $PARSEAVERAGEFILE &>/dev/null
fi
if
[[ $DIFFTIMEPARSE != 0 ]]
then
printf "$yellow"   "List took $DIFFTIMEPARSE Minutes To Parse."
else
printf "$yellow"   "List took Less Than A Minute To Parse."
fi
echo ""
unset ENDPARSESTAMP
unset STARTPARSESTAMP
unset DIFFTIMEPARSE
unset DIFFTIMEPARSESEC

## End new logix
mv $TEMPFILEL $BFILETEMP

## Prepare for next step
mv $BFILETEMP $BTEMPFILE

####################
## Complete Lists ##
#################### 

printf "$cyan"   "Attempting Creation Of Parsed List."

## if we skipped parsing due to file not changing
if
[[ -n $FULLSKIPPARSING && -f $PARSEDFILE ]]
then
HOWMANYLINES=$(echo -e "`wc -l $PARSEDFILE | cut -d " " -f 1`")
printf "$green"  "Old Parsed File Retained."
printf "$yellow"  "$HOWMANYLINES Lines In File."
echo ""
fi

## Delete Parsed file if current parsing method empties it
if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO && -n $ORIGFILESIZENOTZERO && -f $PARSEDFILE ]]
then
printf "$red"  "Current Parsing Method Emptied File. Old File Removed."
rm $PARSEDFILE
fi

## let's get rid of the deadweight
if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO && -n $ORIGFILESIZENOTZERO ]]
then
printf "$red"  "Current Parsing Method Emptied File. It will be skipped in the future."
echo "* $BASEFILENAME List Was Killed By The Parsing Process. It will be skipped in the future. $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $f $KILLTHELIST
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
echo ""
printf "$orange" "___________________________________________________________"
echo ""

## This could give issues in the file loop if not set
unset FILESIZEZERO
unset FULLSKIPPARSING
unset MAYBESKIPPARSING
unset DIDWECHECKONLINEFILE
unset PINGTESTFAILED

## End File Loop
sed -i '/BASEFILENAME/d' $TEMPVARS &>/dev/null
done
