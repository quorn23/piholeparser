#!/bin/bash
## This is the central script that ties the others together

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## Recent Run Log ##
####################

timestamp=$(echo `date`)
if 
ls $RECENTRUN &> /dev/null; 
then
sudo rm $RECENTRUN
sudo echo "## $RECENTRUN $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo echo "* RecentRunLog Removed and Recreated. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* RecentRunLog Created. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

####################
## Run Scripts    ##
####################

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
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$SEVENZIPLISTSSCRIPT
SCRIPTTEXT="Downloading and Extracing 7zip Files."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$TARLISTSSCRIPT
SCRIPTTEXT="Downloading and Extracing Tar Files."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$LIGHTPARSERSCRIPT
SCRIPTTEXT="Running Light Parser."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo echo "## $SCRIPTTEXT $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$HEAVYPARSERSCRIPT
SCRIPTTEXT="Running Heavy Parser."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
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
printf "$green"   "$WHATSCRIPTORUN $timestamp"
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
SCRIPTTEXT="Cleaning Up Extra Files."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
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
SCRIPTTEXT="Pusing Lists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
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
printf "$green"   "Script Complete"
timestamp=$(echo `date`)
sudo echo "* Script completed at $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
printf "$magenta" "___________________________________________________________"
echo ""
