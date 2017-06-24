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
cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $WWHITETEMP
HOWMANYLINES=$(echo -e "\t`wc -l $WWHITETEMP | cut -d " " -f 1` Lines In File")
echo "$HOWMANYLINES"
rm $WHATLISTTOSORT
mv $WWHITETEMP $WHATLISTTOSORT
echo "* Processed "$WHITESORTDEDUPE"." | tee --append $RECENTRUN &>/dev/null
echo "* $HOWMANYLINES" | tee --append $RECENTRUN &>/dev/null
echo ""

## end of loop
done

WHITESORTDEDUPE="Merging the Whitelists for Later."
WHATLISTSMERGE="$WHITELISTDOMAINSALL"
timestamp=$(echo `date`)
printf "$yellow"  "Processed $WHITESORTDEDUPE"
cat -s $WHATLISTSMERGE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $WHITELISTTEMP
HOWMANYLINES=$(echo -e "\t`wc -l $WHITELISTTEMP | cut -d " " -f 1` Lines In File")
echo "$HOWMANYLINES"
echo "* "$WHITESORTDEDUPE"." | tee --append $RECENTRUN &>/dev/null
echo "* $HOWMANYLINES" | tee --append $RECENTRUN &>/dev/null
echo ""

###########################
## Blacklist sort dedupe ##
###########################
echo "## Compiling Repo Blacklist." | tee --append $RECENTRUN &>/dev/null

WHATITIS="Blacklist File"
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

## Start File Loop
for f in $BLACKLISTDOMAINSALL
do

## Variables
source /etc/piholeparser/scriptvars/dynamicvariables.var

WHATLISTTOSORT=$f
BLACKSORTDEDUPE="$BASEFILENAME Domains."
timestamp=$(echo `date`)
printf "$yellow"  "Processing $BLACKSORTDEDUPE."
cat -s $WHATLISTTOSORT | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BBLACKTEMP
HOWMANYLINES=$(echo -e "\t`wc -l $BBLACKTEMP | cut -d " " -f 1` Lines In File")
echo "$HOWMANYLINES"
rm $WHATLISTTOSORT
mv $BBLACKTEMP $WHATLISTTOSORT
echo "* Processed "$BLACKSORTDEDUPE"." | tee --append $RECENTRUN &>/dev/null
echo "* $HOWMANYLINES" | tee --append $RECENTRUN &>/dev/null
echo ""

## end of loop
done

BLACKSORTDEDUPE="Merging the Blacklists for Later."
WHATLISTSMERGE="$BLACKLISTDOMAINSALL"
timestamp=$(echo `date`)
printf "$yellow"  "Processed $BLACKSORTDEDUPE"
cat -s $WHATLISTSMERGE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BLACKLISTTEMP
HOWMANYLINES=$(echo -e "\t`wc -l $BLACKLISTTEMP | cut -d " " -f 1` Lines In File")
echo "$HOWMANYLINES"
echo "* "$BLACKSORTDEDUPE"." | tee --append $RECENTRUN &>/dev/null
echo "* $HOWMANYLINES" | tee --append $RECENTRUN &>/dev/null
echo ""


####################
## pihole -w      ##
####################

## Whitelist the domains
#for source in `cat $LISTWHITELISTDOMAINS`;
#do
#pihole -w $source &>/dev/null
#done
