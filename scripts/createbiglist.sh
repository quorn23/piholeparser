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

## Combine Small lists
sudo cat /etc/piholeparser/parsed/*.txt > $TEMPAPL
echo -e "\t`wc -l $TEMPAPL | cut -d " " -f 1` lines after merging individual lists"

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."
sort -u $TEMPAPL > $BIGAPL
echo -e "\t`wc -l $BIGAPL | cut -d " " -f 1` lines after deduping"
sudo rm $TEMPAPL

## Github has a 100mb limit and empty files are useless
BFILESIZE=$(stat -c%s "$MFILENAME")
if
[ "$BFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Parsed File Too Large For Github. Deleting."
sudo rm $BIGAPL
sudo echo "File exceeded Githubs 100mb limitation" | sudo tee --append $BIGAPL
elif
[ "$BFILESIZE" -ge 0 ]
then
echo ""
printf "$red"     "File Empty"
sudo echo "File Size equaled zero." | sudo tee --append $BIGAPL
else
echo ""
printf "$yellow"  "Big List Created Successfully."
fi

## duplicate Big List file
sudo cp $BIGAPL /etc/piholeparser/parsed/

printf "$magenta" "___________________________________________________________"
echo ""

####################
## Big Source     ##
####################

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Rebuilding the Sources file."
echo ""

sudo cat /etc/piholeparser/lists/*/*.lst | sort > $BIGAPLSOURCE
echo -e "\t`wc -l $BIGAPLSOURCE | cut -d " " -f 1` lists processed by the script."

printf "$magenta" "___________________________________________________________"
echo ""
