#!/bin/bash
## This trims off the "white" domains

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## Big Source edit##
####################

## should remove faster than a sed loop
sudo gawk 'NR==FNR{a[$0];next} !($0 in a)' $WHITELISTTEMP $BIGAPL > $TEMPFILE
sudo rm $WHITELISTTEMP

## Github has a 100mb limit and empty files are useless
FETCHFILESIZE=$(stat -c%s $TEMPFILE)
timestamp=$(echo `date`)
if
[ "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Parsed File Too Large For Github. Deleting."
sudo echo "* Allparsedlist list was too large to host on github. $FETCHFILESIZE bytes $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $FILETEMP
sudo echo "File exceeded Githubs 100mb limitation" | sudo tee --append $TEMPFILE
sudo mv $TEMPFILE $BIGAPLE
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "File Empty"
sudo echo "File Size equaled zero." | sudo tee --append $TEMPFILE
sudo echo "* Allparsedlist list was an empty file $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo mv $TEMPFILE $BIGAPLE
else
echo ""
sudo mv $TEMPFILE $BIGAPLE
printf "$yellow"  "Big List Created Successfully."
fi
