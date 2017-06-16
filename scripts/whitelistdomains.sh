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
echo ""
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

printf "$yellow"  "Extracting Domains from all .lst files"
echo ""

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
timestamp=$(echo `date`)
printf "$yellow"  "Processing $WHITESORTDEDUPE."
sudo cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo echo "$HOWMANYLINES $timestamp"
sudo rm $WHATLISTTOSORT
sudo mv $TEMPFILE $WHATLISTTOSORT
sudo echo "* Processed "$WHITESORTDEDUPE". $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo echo "* $HOWMANYLINES $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""

WHITESORTDEDUPE="Deathbybandaid Whitelisted Domains"
WHATLISTTOSORT=$DBBWHITES
timestamp=$(echo `date`)
printf "$yellow"  "Processing $WHITESORTDEDUPE."
sudo cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo echo "$HOWMANYLINES $timestamp"
sudo rm $WHATLISTTOSORT
sudo mv $TEMPFILE $WHATLISTTOSORT
sudo echo "* Processed "$WHITESORTDEDUPE". $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo echo "* $HOWMANYLINES $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""

WHITESORTDEDUPE="Domains that Cause Issues for People."
WHATLISTTOSORT=$BLOCKEDCOMPLAINTS
timestamp=$(echo `date`)
printf "$yellow"  "Processing $WHITESORTDEDUPE."
sudo cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo echo "$HOWMANYLINES $timestamp"
sudo rm $WHATLISTTOSORT
sudo mv $TEMPFILE $WHATLISTTOSORT
sudo echo "* Processed "$WHITESORTDEDUPE". $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo echo "* $HOWMANYLINES $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""

WHITESORTDEDUPE="Merging the Whitelists for Later."
WHATLISTTOSORT="$BLOCKEDCOMPLAINTS $DBBWHITES $LISTWHITELISTDOMAINS"
timestamp=$(echo `date`)
printf "$yellow"  "Processed $WHITESORTDEDUPE"
sudo cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo echo "$HOWMANYLINES $timestamp"
sudo mv $TEMPFILE $WHITELISTTEMP
sudo echo "* "$WHITESORTDEDUPE". $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo echo "* $HOWMANYLINES $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""

####################
## pihole -w      ##
####################

## Whitelist the domains
#for source in `cat $LISTWHITELISTDOMAINS`;
#do
#pihole -w $source &>/dev/null
#done
