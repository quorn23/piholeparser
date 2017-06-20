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
printf "$red"  "Removing $WHATITIS"
echo ""
sudo rm $CHECKME
sudo touch $CHECKME
sudo echo "* $WHATITIS removed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"  "$WHATITIS not there. Not Removing."
echo ""
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

## Start File Loop
for f in $WHITELISTDOMAINSALL
do

## Variables
source /etc/piholeparser/scriptvars/dynamicvariables.var

WHATLISTTOSORT=$f
WHITESORTDEDUPE="$BASEFILENAME Domains."
timestamp=$(echo `date`)
printf "$yellow"  "Processing $WHITESORTDEDUPE."
sudo cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
HOWMANYLINES=$(echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` Lines In File")
sudo echo "$HOWMANYLINES"
sudo rm $WHATLISTTOSORT
sudo mv $TEMPFILE $WHATLISTTOSORT
sudo echo "* Processed "$WHITESORTDEDUPE". $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo echo "* $HOWMANYLINES $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""

## end of loop
done

WHITESORTDEDUPE="Merging the Whitelists for Later."
WHATLISTTOSORT="$WHITELISTDOMAINSALL"
timestamp=$(echo `date`)
printf "$yellow"  "Processed $WHITESORTDEDUPE"
sudo cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
HOWMANYLINES=$(echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` Lines In File")
sudo echo "$HOWMANYLINES"
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
