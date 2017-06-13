#!/bin/bash
## This is where any script dependencies will go.
## It checks if it is installed, and if not,
## it installs the program

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Checking Dependencies"

WHATITIS=p7zip
WHATPACKAGE=p7zip-full
timestamp=`date`
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
sudo echo "$WHATITIS already installed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
printf "$yellow"  "Installing $WHATITIS"
sudo apt-get install -y $WHATPACKAGE
sudo echo "$WHATITIS was installed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS=gawk
WHATPACKAGE=gawk
timestamp=`date`
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
sudo echo "$WHATITIS already installed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
printf "$yellow"  "Installing $WHATITIS"
sudo apt-get install -y $WHATPACKAGE
sudo echo "$WHATITIS was installed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

printf "$magenta" "___________________________________________________________"
echo ""
