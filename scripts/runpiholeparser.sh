#!/bin/bash
## This is the central script that ties the others together

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## Recent Run Log ##
####################

SCRIPTTEXT="Clearing The Path."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
if 
ls $RECENTRUN &> /dev/null; 
then
sudo rm $RECENTRUN
sudo echo "* Recent Run Log Removed and Recreated. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
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

SCRIPTTEXT="Counting Lists To Process."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$SCRIPTTEXT $timestamp"
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

WHATSCRIPTORUN=$COLLISIONAVOIDSCRIPT
SCRIPTTEXT="Clearing The Path."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$DEPENDENCYCHECKSCRIPT
SCRIPTTEXT="Checking For Script Dependencies."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$SCRIPTTEXT $timestamp"
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
printf "$green"   "$SCRIPTTEXT $timestamp"
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
printf "$green"   "$SCRIPTTEXT $timestamp"
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
printf "$green"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$CREATEBIGLISTSCRIPTEDITED
SCRIPTTEXT="Creating Custom Big List."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$CREATEBIGSOURCE
SCRIPTTEXT="Creating Source List."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$CLEANUPSCRIPT
SCRIPTTEXT="Cleanining Up Before Pushing."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$SCRIPTTEXT $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$PUSHLISTSSCRIPT
SCRIPTTEXT="Pushing Lists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$SCRIPTTEXT $timestamp"
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

timestamp=$(echo `date`)
sudo echo "## Updated Main README.md $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

sudo rm $MAINREADME
sudo sed "s/LASTRUNVARIABLEGOESHERE/$timestamp/" $MAINREADMEDEFAULT > $MAINREADME

####################
## Script Complete##
####################

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Script Complete"
timestamp=$(echo `date`)
sudo echo "* Script completed at $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
printf "$magenta" "___________________________________________________________"
echo ""
