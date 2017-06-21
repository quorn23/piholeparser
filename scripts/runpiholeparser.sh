#!/bin/bash
## This is the central script that ties the others together

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

STARTTIME="Script Started At $(date +"%s")"

####################
## Recent Run Log ##
####################

SCRIPTTEXT="Creating Recent Run Log."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
sudo bash $DELETETEMPFILE
if 
ls $RECENTRUN &> /dev/null; 
then
sudo rm $RECENTRUN
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo echo "* Recent Run Log Removed and Recreated. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo echo "* Recent Run Log Created. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
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
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

SCRIPTTEXT="Counting Lists To Process."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo cat $EVERYLISTFILEWILDCARD | sort > $TEMPFILE
HOWMANYLISTS=$(echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lists to be processed by the script.")
sudo echo "$HOWMANYLISTS"
sudo echo "* $HOWMANYLISTS $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo sed '/^$/d' $TEMPFILE > $FILETEMP
sudo mv $FILETEMP $BIGAPLSOURCE
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
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
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$WHITELISTSCRIPT
SCRIPTTEXT="Compiling Whitelists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$PARSERSCRIPT
SCRIPTTEXT="Running Parser."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$CREATEBIGLISTSCRIPT
SCRIPTTEXT="Combining All Parsed Lists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
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
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo rm $MAINREADME
ENDTIME="Script Ended At $(date +"%s")"
DIFFTIME=$(($ENDTIME-$STARTTIME))
TOTALRUNTIME="echo " Script took $(($DIFFTIME / 60)) minutes and $(($DIFFTIME % 60)) seconds To Filter Lists.""
sudo sed "s/LASTRUNSTART/$STARTTIME/; s/LASTRUNSTOP/$ENDTIME/; s/TOTALRUNTIME/$TOTALRUNTIME/" $MAINREADMEDEFAULT > $MAINREADME
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Push Lists     ##
####################

## This looked prettier below, but wasn't getting pushed up.
sudo echo "* Script completed at $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

WHATSCRIPTORUN=$PUSHLISTSSCRIPT
SCRIPTTEXT="Pushing Lists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
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
