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

#WHATSCRIPTORUN=$COLLISIONAVOIDSCRIPT
#timestamp=$(echo `date`)
#printf "$blue"    "___________________________________________________________"
#echo ""
#printf "$green"   "$WHATSCRIPTORUN - $timestamp"
#echo ""
#sudo bash $DELETETEMPFILE
#sudo bash $WHATSCRIPTORUN
#sudo bash $DELETETEMPFILE
#sudo echo ""
#sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
#printf "$magenta" "___________________________________________________________"
#echo ""

WHATSCRIPTORUN=$DEPENDENCYCHECKSCRIPT
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$WHITELISTSCRIPT
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$SEVENZIPLISTSSCRIPT
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

## Lists compressed in tar
WHATSCRIPTORUN=$TARLISTSSCRIPT
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$LIGHTPARSERSCRIPT
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$HEAVYPARSERSCRIPT
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$CREATEBIGLISTSCRIPT
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

WHATSCRIPTORUN=$CLEANUPSCRIPT
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
sudo bash $DELETETEMPFILE
sudo bash $WHATSCRIPTORUN
sudo bash $DELETETEMPFILE
sudo echo ""
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""
sudo bash /etc/piholeparser/scripts/cleanup.sh

WHATSCRIPTORUN=$PUSHLISTSSCRIPT
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "$WHATSCRIPTORUN $timestamp"
echo ""
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
