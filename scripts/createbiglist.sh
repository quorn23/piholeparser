#!/bin/bash
## This takes the work done in parser.sh
## and merges it all into one

## Variables
source /etc/piholeparser/scriptvars/variables.var

####################
## Big List       ##
#################### 

echo ""
printf "$blue"    "___________________________________________________________"

echo ""
printf "$green"   "Attempting Creation of Big List."
echo ""
timestamp=$(echo `date`)
sudo echo "## Big List $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

## Combine Small lists
sudo cat $PARSEDLISTSALL > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after merging individual lists"

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."
sudo cat -s $TEMPFILE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BIGAPL
echo -e "\t`wc -l $BIGAPL | cut -d " " -f 1` lines after deduping"
sudo rm $TEMPFILE

## Github has a 100mb limit and empty files are useless
BFILESIZE=$(stat -c%s $BIGAPL)
timestamp=$(echo `date`)
if
[ "$BFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Parsed File Too Large For Github. Deleting."
sudo echo "* Allparsedlist list was too large to host on github. $BFILESIZE bytes $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BIGAPL
sudo echo "File exceeded Githubs 100mb limitation" | sudo tee --append $BIGAPL
elif
[ "$BFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "File Empty"
sudo echo "File Size equaled zero." | sudo tee --append $BIGAPL
sudo echo "* Allparsedlist list was an empty file $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
echo ""
printf "$yellow"  "Big List Created Successfully."
fi

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Big Source edit##
####################

echo ""
printf "$blue"    "___________________________________________________________"

echo ""
printf "$green"   "Attempting Creation of Big List Edited."
echo ""
timestamp=$(echo `date`)
sudo echo "## Edited Big List $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

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

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Big Source     ##
####################

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Rebuilding the Sources file."
echo ""

timestamp=$(echo `date`)
sudo echo "## Rebuilding Source List $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

## add all sources
sudo cat $EVERYLISTFILEWILDCARD | sort > $BIGAPLSOURCE

## Remove Empty Lines
sudo sed '/^$/d' $BIGAPLSOURCE > $TEMPFILE
sudo rm $BIGAPLSOURCE
sudo mv $TEMPFILE $BIGAPLSOURCE

timestamp=$(echo `date`)
HOWMANYLISTS=$(echo -e "\t`wc -l $BIGAPLSOURCE | cut -d " " -f 1` lists processed by the script.")
sudo echo "$HOWMANYLISTS"
sudo echo "* $HOWMANYLISTS $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""
