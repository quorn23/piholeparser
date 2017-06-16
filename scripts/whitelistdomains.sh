#!/bin/bash
## This should whitelist all domains that will be parsed

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## File checks    ##
####################

WHATITIS="Whitelist File"
CHECKME=$LISTWHITELISTDOMAINS
timestamp=$(echo `date`)
printf "$yellow"  "Checking For $WHATITIS"
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo touch $CHECKME
sudo echo "* $WHATITIS removed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo touch $CHECKME
sudo echo "* $WHATITIS not there, not removing. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

####################
## Whitelist .lst ##
####################

## Start File Loop
for f in $EVERYLISTFILEWILDCARD
do
for source in `cat $f`;
do

## Variables
source /etc/piholeparser/scriptvars/dynamicvariables.var

## add to whitelist file
sudo echo "$UPCHECK" | sudo tee --append $LISTWHITELISTDOMAINS &>/dev/null

## end of loops
done
done

###########################
## Whitelist sort dedupe ##
###########################

WHITESORTDEDUPE=".lst Domains."
WHATLISTTOSORT=$LISTWHITELISTDOMAINS
printf "$yellow"  "Processing $WHITESORTDEDUPE."
sudo cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo rm $WHATLISTTOSORT
sudo mv $TEMPFILE $WHATLISTTOSORT
sudo echo "* Processing "$WHITESORTDEDUPE". $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

WHITESORTDEDUPE="Deathbybandaid Whitelisted Domains"
WHATLISTTOSORT=$DBBWHITES
printf "$yellow"  "Processing $WHITESORTDEDUPE"
sudo cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo rm $WHATLISTTOSORT
sudo mv $TEMPFILE $WHATLISTTOSORT
sudo echo "* Processing "$WHITESORTDEDUPE". $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

WHITESORTDEDUPE="Domains that Cause Issues for People."
WHATLISTTOSORT=$BLOCKEDCOMPLAINTS
printf "$yellow"  "Processing $WHITESORTDEDUPE"
sudo cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo rm $WHATLISTTOSORT
sudo mv $TEMPFILE $WHATLISTTOSORT
sudo echo "* Processing "$WHITESORTDEDUPE". $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

## Merge for removal later
sudo cat $BLOCKEDCOMPLAINTS $DBBWHITES $LISTWHITELISTDOMAINS > $TEMPFILE
sudo cat -s $TEMPFILE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $WHITELISTTEMP
sudo rm $TEMPFILE

timestamp=$(echo `date`)
sudo echo "$HOWMANYWHITELISTS"
sudo echo "* $HOWMANYWHITELISTS $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

####################
## pihole -w      ##
####################

## Whitelist the domains
#for source in `cat $LISTWHITELISTDOMAINS`;
#do
#pihole -w $source &>/dev/null
#done
