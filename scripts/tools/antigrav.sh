#!/bin/bash
## This should show what lines are not making it through gravity.sh

## Variables
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

## Pihole vars
source /etc/pihole/setupVars.conf
TRIMMEDIP=${IPV4_ADDRESS%/*}
CURRENTUSER="$(whoami)"
GRAVITY=/etc/pihole/gravity.list
GRAVITYSH=/etc/.pihole/gravity.sh
ANTIGRAV="TEMPDIR"antigrav.list.txt

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
ls $ANTIGRAV &> /dev/null;
then
rm $ANTIGRAV
else
:
fi

## Update Gravity
# pihole -g
{ if
(whiptail --title "AntiGrav" --yes-button "No" --no-button "Yes" --yesno "Do you want to run Gravity Now?" 10 80) 
then
echo "not running gravity"
else
bash $GRAVITYSH
fi }

## Trim IP from HOSTS format
HOSTIP=$(whiptail --inputbox "What IP Needs to be removed?" 10 80 "$TRIMMEDIP" 3>&1 1>&2 2>&3)
sed "s/^$HOSTIP\s\+[ \t]*//" < $GRAVITY > $TEMPFILE

## WhatDiff
gawk 'NR==FNR{a[$0];next} !($0 in a)' $BIGAPLE $TEMPFILE > $FILETEMP
rm $TEMPFILE
cat $FILETEMP | sed 's/\s\+$//; /^$/d; /[[:blank:]]/d' > $ANTIGRAV
rm $FILETEMP
HOWMANYLINES=$(echo -e "`wc -l $ANTIGRAV | cut -d " " -f 1`")
printf "$yellow"  "Antigrav File contains $HOWMANYLINES Domains that are not used by gravity."

