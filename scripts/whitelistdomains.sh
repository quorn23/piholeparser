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

## domains from .lst files
sudo cat -s $LISTWHITELISTDOMAINS | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo rm $LISTWHITELISTDOMAINS
sudo mv $TEMPFILE $LISTWHITELISTDOMAINS

## dbb whites
sudo cat -s $DBBWHITES | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo rm $DBBWHITES
sudo mv $TEMPFILE $DBBWHITES

## user complaints
sudo cat -s $BLOCKEDCOMPLAINTS | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo rm $BLOCKEDCOMPLAINTS
sudo mv $TEMPFILE $BLOCKEDCOMPLAINTS

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
