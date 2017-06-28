#!/bin/bash
## This should create the fun info for the run log, and Readme.md

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var
source $TEMPVARS

####################
## ALLPARSEDSIZE  ##
####################

FETCHFILESIZEALL=$(stat -c%s "$BIGAPLE")
FETCHFILESIZEALLMB=`expr $FETCHFILESIZEALL / 1024 / 1024`
DOMAINSINALLPARSEDE=$(echo -e "\t`wc -l $BIGAPLE | cut -d " " -f 1`")
EDITEDALLPARSEDSIZEMB="The Edited ALLPARSEDLIST is $FETCHFILESIZEALLMB MB and contains $DOMAINSINALLPARSEDE Domains."
SCRIPTTEXT="Edited ALLPARSEDLIST Result."
printf "$lightblue"    "___________________________________________________________"
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
printf "$orange" "___________________________________________________________"
echo ""

####################
## Runtime        ##
####################

SCRIPTTEXT="Total Runtime."
printf "$lightblue"    "___________________________________________________________"
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
printf "$orange" "___________________________________________________________"
echo ""

####################
## Readme.md      ##
####################

SCRIPTTEXT="Updated Main README.md."
printf "$lightblue"    "___________________________________________________________"
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
printf "$orange" "___________________________________________________________"
echo ""
