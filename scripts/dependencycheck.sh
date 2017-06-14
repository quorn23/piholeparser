#!/bin/bash
## This is where any script dependencies will go.
## It checks if it is installed, and if not,
## it installs the program

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Checking Dependencies"
timestamp=$(echo `date`)
sudo echo "## Dependencies $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

WHATITIS=p7zip
WHATPACKAGE=p7zip-full
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
sudo echo "* $WHATITIS already installed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
printf "$yellow"  "Installing $WHATITIS"
sudo apt-get install -y $WHATPACKAGE
sudo echo "* $WHATITIS was installed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS=gawk
WHATPACKAGE=gawk
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
sudo echo "* $WHATITIS already installed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
printf "$yellow"  "Installing $WHATITIS"
sudo apt-get install -y $WHATPACKAGE
sudo echo "* $WHATITIS was installed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""
