#!/bin/bash
## This is the Parsing Process

## Set File Directory
FILES=/etc/piholeparser/lists/*.lst

## Start File Loop
for f in $FILES
do

for source in `cat $f`;
do
echo ""
echo $f;
echo $source;
sudo curl --silent $source >> "$f".ads.txt
echo -e "\t`wc -l "$f".ads.txt | cut -d " " -f 1` lines downloaded"
done

## Filter
echo -e "\nFiltering non-url content..."
sudo perl /etc/piholeparser/parser.pl "$f".ads.txt > "$f".ads_parsed.txt
#sudo mv "$f".ads.txt /etc/piholeparser/mirroredlists/
#sudo rm "$f".ads.txt
echo -e "\t`wc -l "$f".ads_parsed.txt | cut -d " " -f 1` lines after parsing"

## Duplicate Removal
echo -e "\nRemoving duplicates..."
sort -u "$f".ads_parsed.txt > "$f".ads_unique.txt
sudo rm "$f".ads_parsed.txt
echo -e "\t`wc -l "$f".ads_unique.txt | cut -d " " -f 1` lines after deduping"
sudo cat "$f".ads_unique.txt >> "$f".txt
sudo rm "$f".ads_unique.txt

## Remove Empty Files
if 
[ -s "$f".txt ]
then
echo ""
echo "File will be moved to the parsed directory."
sudo mv "$f".txt /etc/piholeparser/parsed/
echo ""
echo "File will be renamed."
sudo rename "s/.lst.txt/.txt/" /etc/piholeparser/parsed/*.txt
continue
else
echo ""
echo "File Empty. It will be deleted."
rm -rf "$f".txt
fi

## End File Loop
done
