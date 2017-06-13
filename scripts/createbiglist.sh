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
BFILESIZE=$(stat -c%s $BIGAPL)
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
## Big Source edit##
####################

sudo cp $BIGAPL $BIGAPLE

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   ""
echo ""

## Start File Loop
for source in `cat $BDC $DBBW $WHITELIST`;
do

## cut domains out
sudo sed '/$source/d' $BIGAPLE > $TEMPAPLE
sudo rm $BIGAPLE
sudo mv $TEMPAPLE $BIGAPLE

## end of loops
done

####################
## Big Source     ##
####################

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Rebuilding the Sources file."
echo ""

## add all sources
sudo cat /etc/piholeparser/lists/*/*.lst | sort > $BIGAPLSOURCE

## Remove Empty Lines
sudo sed '/^$/d' $BIGAPLSOURCE > $BIGAPLSOURCE2
sudo rm $BIGAPLSOURCE
sudo mv $BIGAPLSOURCE2 $BIGAPLSOURCE

echo -e "\t`wc -l $BIGAPLSOURCE | cut -d " " -f 1` lists processed by the script."

printf "$magenta" "___________________________________________________________"
echo ""

printf "$magenta" "___________________________________________________________"
echo ""
