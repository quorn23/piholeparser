#!/bin/bash
## This is the central script that ties the others together

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var
STARTTIME="Script Started At $(echo `date`)"
STARTTIMESTAMP=$(date +"%s")

####################
## Recent Run Log ##
####################

SCRIPTTEXT="Creating Recent Run Log."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
bash $DELETETEMPFILE
if 
ls $RECENTRUN &> /dev/null; 
then
rm $RECENTRUN
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "* Recent Run Log Removed and Recreated. $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "* Recent Run Log Created. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
bash $DELETETEMPFILE
echo ""
echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Big Source     ##
####################

WHATITIS="The Source List"
CHECKME=$BIGAPLSOURCE
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
echo "* $WHATITIS Removed. $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "* $WHATITIS Not Removed. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

SCRIPTTEXT="Counting Lists To Process."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
cat $EVERYLISTFILEWILDCARD | sort > $TEMPFILE
HOWMANYSOURCELISTS=$(echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1`")
HOWMANYSOURCE="$HOWMANYSOURCELISTS lists to be processed by the script."
echo "$HOWMANYSOURCE"
echo "* $HOWMANYSOURCE $timestamp" | tee --append $RECENTRUN &>/dev/null
sed '/^$/d' $TEMPFILE > $FILETEMP
mv $FILETEMP $BIGAPLSOURCE
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Run Scripts    ##
####################

WHATSCRIPTORUN=$DEPENDENCYCHECKSCRIPT
SCRIPTTEXT="Checking For Script Dependencies."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$REPODOMAINSSCRIPT
SCRIPTTEXT="Compiling Whitelists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$PARSERSCRIPT
SCRIPTTEXT="Running Parser."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$CREATEBIGLISTSCRIPT
SCRIPTTEXT="Combining All Parsed Lists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## ALLPARSEDSIZE  ##
####################

FETCHFILESIZEALL=$(stat -c%s "$BIGAPLE")
FETCHFILESIZEALLMB=`expr $FETCHFILESIZEALL / 1024 / 1024`
DOMAINSINALLPARSEDE=$(echo -e "\t`wc -l $BIGAPLE | cut -d " " -f 1`")
EDITEDALLPARSEDSIZEMB="The Edited ALLPARSEDLIST is $FETCHFILESIZEALLMB MB and contains $DOMAINSINALLPARSEDE Domains."
SCRIPTTEXT="Edited ALLPARSEDLIST Result."
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
echo "* $EDITEDALLPARSEDSIZEMB" | tee --append $RECENTRUN &>/dev/null
printf "$yellow"   "$EDITEDALLPARSEDSIZEMB"
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Runtime        ##
####################


SCRIPTTEXT="Total Runtime."
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
ENDTIME="Script Ended At $(echo `date`)"
ENDTIMESTAMP=$(date +"%s")
DIFFTIMESEC=`expr $ENDTIMESTAMP - $STARTTIMESTAMP`
DIFFTIME=`expr $DIFFTIMESEC / 60`
TOTALRUNTIME="Script Took $DIFFTIME minutes To Filter $HOWMANYSOURCELISTS Lists."
printf "$yellow"   "$TOTALRUNTIME"
echo "* $TOTALRUNTIME" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Readme.md      ##
####################


SCRIPTTEXT="Updated Main README.md."
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
rm $MAINREADME
sed "s/LASTRUNSTART/$STARTTIME/; s/LASTRUNSTOP/$ENDTIME/; s/TOTALELAPSEDTIME/$TOTALRUNTIME/; s/EDITEDALLPARSEDSIZE/$EDITEDALLPARSEDSIZEMB/" $MAINREADMEDEFAULT > $MAINREADME
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Push Lists     ##
####################

## This looked prettier below, but wasn't getting pushed up.
echo "* Script completed at $timestamp" | tee --append $RECENTRUN &>/dev/null

WHATSCRIPTORUN=$PUSHLISTSSCRIPT
SCRIPTTEXT="Pushing Lists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Script Complete##
####################

printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "Script Complete"
echo ""
printf "$magenta" "___________________________________________________________"
echo ""
