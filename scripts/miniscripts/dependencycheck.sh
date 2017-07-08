#!/bin/bash
## This is where any script dependencies will go.
## It checks if it is installed, and if not,
## it installs the program

## Variables
source /etc/piholeparser/scripts/scriptvars/variables.var

#######################
## Check Dependencies##
#######################

WHATITIS=p7zip
WHATPACKAGE=p7zip-full
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
else
printf "$yellow"  "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
echo "* $WHATITIS was installed $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

WHATITIS=gawk
WHATPACKAGE=gawk
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
else
printf "$yellow"  "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
echo "* $WHATITIS was installed $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
