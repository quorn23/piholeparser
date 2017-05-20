#!/bin/bash

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scripts/colors.var

## Set File Directory
FILES=/etc/piholeparser/compressedconvert/*.txt

## Start File Loop
for f in $FILES
do

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Processing $f"

sudo mv $f "$f".ads.txt
#sudo curl --silent $f >> "$f".ads.txt
echo -e "\t`wc -l "$f".ads.txt | cut -d " " -f 1` lines downloaded"


## Filter
echo ""
printf "$yellow"  "Filtering non-url content..."
sudo perl /etc/piholeparser/parser/parser.pl "$f".ads.txt > "$f".ads_parsed.txt
echo -e "\t`wc -l "$f".ads_parsed.txt | cut -d " " -f 1` lines after parsing"

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."
sort -u "$f".ads_parsed.txt > "$f".ads_unique.txt
sudo rm "$f".ads_parsed.txt
echo -e "\t`wc -l "$f".ads_unique.txt | cut -d " " -f 1` lines after deduping"
sudo cat "$f".ads_unique.txt >> "$f".txt
sudo rm "$f".ads_unique.txt
echo ""
printf "$magenta" "___________________________________________________________"
echo ""

## Remove Empty Files
if 
[ -s "$f".txt ]
then
echo ""
printf "$yellow"  "File will be moved to the parsedall directory."
sudo mv "$f".txt /etc/piholeparser/parsedall/
sudo rename "s/.lst.txt/.txt/" /etc/piholeparser/parsedall/*.txt
else
echo ""
printf "$red"     "File Empty. It will be deleted."
rm -rf "$f".txt
fi

## Create Mirrors
{ if 
[ "$version" = "github" ]
then
if 
test $(stat -c%s "$f".ads.txt) -ge 100000000
then
echo ""
printf "$red"     "Mirror File Too Large For Github. Deleting."
sudo rm "$f".ads.txt
else
echo ""
printf "$yellow"  "Creating Mirror of Unparsed File."
sudo mv "$f".ads.txt /etc/piholeparser/mirroredlists/
sudo rename "s/.txt.ads.txt/.txt/" /etc/piholeparser/mirroredlists/*.txt
fi
fi }

## End File Loop
done

printf "$magenta" "___________________________________________________________"
echo ""
