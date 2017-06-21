#!/bin/bash
## This takes the work done in parser.sh
## and merges it all into one

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## Big List       ##
#################### 

WHATITIS="All Parsed List"
CHECKME=$BIGAPL
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

## Combine Small lists
sudo cat $PARSEDLISTSALL > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after merging individual lists"

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."
sudo cat -s $TEMPFILE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $FILETEMP
echo -e "\t`wc -l $FILETEMP | cut -d " " -f 1` lines after deduping"
sudo mv $FILETEMP $TEMPFILE

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
sudo mv $TEMPFILE $BIGAPL
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "File Empty"
sudo echo "File Size equaled zero." | sudo tee --append $TEMPFILE
sudo echo "* Allparsedlist list was an empty file $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo mv $TEMPFILE $BIGAPL
else
echo ""
sudo mv $TEMPFILE $BIGAPL
printf "$yellow"  "Big List Created Successfully."
fi

####################
## Big List edit  ##
####################

WHATITIS="All Parsed List (edited)"
CHECKME=$BIGAPLE
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

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
printf "$yellow"  "Big List Edited Created Successfully."
fi
