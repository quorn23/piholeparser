#!/bin/bash
## This is the Parsing Process

## Colors
source /etc/piholeparser/scripts/colors.var

echo ""
echo "Creating Single Big List."

## merge individuals
sudo cat /etc/piholeparser/parsed/*.txt | sort > /etc/piholeparser/parsedall/ALLPARSEDLISTS.txt

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."

echo -e "\t`wc -l /etc/piholeparser/parsedall/ALLPARSEDLISTS.txt | cut -d " " -f 1` lines after deduping"
sudo cat /etc/piholeparser/parsedall/ALLPARSEDLISTS.txt >> /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.txt
sudo rm /etc/piholeparser/parsedall/ALLPARSEDLISTS.txt

printf "$magenta" "___________________________________________________________"
echo ""
