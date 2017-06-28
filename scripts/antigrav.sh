#!/bin/bash
## This should show what lines are not making it through gravity.sh

## whiptail required
WHATITIS=whiptail
WHATPACKAGE=whiptail
if
which $WHATITIS >/dev/null;
then
:
else
printf "$yellow"  "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
fi

## Remove old antigrav
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
else
:
fi

## Vars
source /etc/piholeparser/scripts/scriptvars/staticvariables.var
CURRENTUSER="$(whoami)"
GRAVITY=/etc/pihole/gravity.list
ANTIGRAV="/home/"$CURRENTUSER"/antigrav.list
HOSTIP=$(whiptail --inputbox "What IP Needs to be removed?" 10 80 "192.168.1.99" 3>&1 1>&2 2>&3)

## Trim IP from HOSTS format
sed "s/^$HOSTIP\s\+[ \t]*//" < $GRAVITY > $TEMPFILE

## WhatDiff
sudo gawk 'NR==FNR{a[$0];next} !($0 in a)' $BIGAPLE $TEMPFILE > $ANTIGRAV
sudo rm $TEMPFILE
