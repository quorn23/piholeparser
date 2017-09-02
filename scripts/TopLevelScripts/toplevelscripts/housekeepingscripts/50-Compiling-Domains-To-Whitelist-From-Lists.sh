#!/bin/bash
## This sets up whitelisting for domains in .lst files

## Variables
source ./foldervars.var

## Quick File Check
timestamp=$(echo `date`)

SCRIPTTEXT="Checking For Whitelist File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $WHITESCRIPTDOMAINS ]]
then
printf "$red"  "Removing Whitelist File."
echo ""
rm $WHITESCRIPTDOMAINS
touch $WHITESCRIPTDOMAINS
echo "* Whitelist File removed $timestamp" | tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"  "Whitelist File not there. Not Removing."
echo ""
touch $WHITESCRIPTDOMAINS
echo "* Whitelist File not there, not removing. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
echo ""

SCRIPTTEXT="Pulling Domains From Lists."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
for f in $BLACKLSTALL
do

source=`cat $f`

SOURCEDOMAIN=`echo $source | awk -F/ '{print $3}'`
if
[[ -n $SOURCEDOMAIN ]]
then
echo "$SOURCEDOMAIN" | tee --append $WHITESCRIPTDOMAINS &>/dev/null
fi

done
HOWMANYLINES=$(echo -e "`wc -l $WHITESCRIPTDOMAINS | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"
echo ""

SCRIPTTEXT="Pulling Domains From TLD Lists."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
for f in $TLDLSTALL
do

source=`cat $f`

SOURCEDOMAIN=`echo $source | awk -F/ '{print $3}'`
if
[[ -n $SOURCEDOMAIN ]]
then
echo "$SOURCEDOMAIN" | tee --append $WHITESCRIPTDOMAINS &>/dev/null
fi

done
HOWMANYLINES=$(echo -e "`wc -l $WHITESCRIPTDOMAINS | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"
echo ""

SCRIPTTEXT="Deduping List."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $WHITESCRIPTDOMAINS ]]
then
cat -s $WHITESCRIPTDOMAINS | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILEH
rm $WHITESCRIPTDOMAINS
mv $TEMPFILEH $WHITESCRIPTDOMAINS
else
touch $WHITESCRIPTDOMAINS
fi
HOWMANYLINES=$(echo -e "`wc -l $WHITESCRIPTDOMAINS | cut -d " " -f 1`")
echo "$HOWMANYLINES After $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "$HOWMANYLINES After $SCRIPTTEXT"
