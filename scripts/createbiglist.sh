#!/bin/bash
## This takes the work done in parser.sh
## and merges it all into one

## Variables
source /etc/piholeparser/scriptvars/variables.var

####################
## Big List       ##
#################### 

## Combine Small lists
sudo cat $PARSEDLISTSALL > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after merging individual lists"

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."
sudo cat -s $TEMPFILE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $FILETEMP
echo -e "\t`wc -l $BIGAPL | cut -d " " -f 1` lines after deduping"
sudo rm $TEMPFILE

## Github has a 100mb limit and empty files are useless
FETCHFILESIZE=$(stat -c%s $BIGAPL)
timestamp=$(echo `date`)
if
[ "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Parsed File Too Large For Github. Deleting."
sudo echo "* Allparsedlist list was too large to host on github. $FETCHFILESIZE bytes $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $FILETEMP
sudo echo "File exceeded Githubs 100mb limitation" | sudo tee --append $FILETEMP
sudo mv $FILETEMP $BIGAPL
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "File Empty"
sudo echo "File Size equaled zero." | sudo tee --append $FILETEMP
sudo echo "* Allparsedlist list was an empty file $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo mv $FILETEMP $BIGAPL
else
echo ""
sudo mv $FILETEMP $BIGAPL
printf "$yellow"  "Big List Created Successfully."
fi

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
