#!/bin/bash
## This trims off the "white" domains

## Variables
source /etc/piholeparser/scriptvars/variables.var

####################
## Big Source edit##
####################

## should remove faster than a sed loop
sudo gawk 'NR==FNR{a[$0];next} !($0 in a)' $WHITELISTTEMP $BIGAPL > $BIGAPLE
sudo rm $WHITELISTTEMP

## Github has a 100mb limit and empty files are useless
BEFILESIZE=$(stat -c%s $BIGAPLE)
timestamp=$(echo `date`)
if
[ "$BEFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Parsed File Too Large For Github. Deleting."
sudo echo "* Allparsedlistedited list was too large to host on github. $BEFILESIZE bytes $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BIGAPLE
sudo echo "File exceeded Githubs 100mb limitation" | sudo tee --append $BIGAPLE
elif
[ "$BEFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "File Empty"
sudo echo "File Size equaled zero." | sudo tee --append $BIGAPLE
sudo echo "* Allparsedlistedited list was an empty file $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
echo ""
printf "$yellow"  "Big List (edited) Created Successfully."
fi
