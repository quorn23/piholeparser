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
rm $CHECKME
touch $CHECKME
echo "* $WHATITIS removed $timestamp" | tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"  "$WHATITIS not there. Not Removing."
echo ""
touch $CHECKME
echo "* $WHATITIS not there, not removing. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

####################
## Whitelist .lst ##
####################

printf "$yellow"  "Extracting Domains from all .lst files"
echo ""

if
ls $BIGAPLSOURCE &> /dev/null;
then
for source in `cat $BIGAPLSOURCE`;
do
UPCHECK=`echo $source | awk -F/ '{print $3}'`
echo "$UPCHECK" | tee --append $LISTWHITELISTDOMAINS &>/dev/null
done
else
for f in $EVERYLISTFILEWILDCARD
do
for source in `cat $f`;
do
UPCHECK=`echo $source | awk -F/ '{print $3}'`
echo "$UPCHECK" | tee --append $LISTWHITELISTDOMAINS &>/dev/null
done
done
fi
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
cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
HOWMANYLINES=$(echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` Lines In File")
echo "$HOWMANYLINES"
rm $WHATLISTTOSORT
mv $TEMPFILE $WHATLISTTOSORT
echo "* Processed "$WHITESORTDEDUPE". $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "* $HOWMANYLINES $timestamp" | tee --append $RECENTRUN &>/dev/null
echo ""

## end of loop
done

WHITESORTDEDUPE="Merging the Whitelists for Later."
WHATLISTTOSORT="$WHITELISTDOMAINSALL"
timestamp=$(echo `date`)
printf "$yellow"  "Processed $WHITESORTDEDUPE"
cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
HOWMANYLINES=$(echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` Lines In File")
echo "$HOWMANYLINES"
mv $TEMPFILE $WHITELISTTEMP
echo "* "$WHITESORTDEDUPE". $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "* $HOWMANYLINES $timestamp" | tee --append $RECENTRUN &>/dev/null
echo ""

####################
## pihole -w      ##
####################

## Whitelist the domains
#for source in `cat $LISTWHITELISTDOMAINS`;
#do
#pihole -w $source &>/dev/null
#done
