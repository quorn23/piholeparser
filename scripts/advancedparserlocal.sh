#!/bin/bash
## This is the Parsing Process

echo ""
echo "Parsing Lists."

## Set File Directory
FILES=/etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.lst

## Start File Loop
for f in $FILES
do

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Processing list from $f"

for source in `cat $f`;
do
echo ""
printf "$cyan"    "$source"
sudo curl --silent $source >> "$f".ads.txt
echo -e "\t`wc -l "$f".ads.txt | cut -d " " -f 1` lines downloaded"
done

## Filter
echo ""
printf "$yellow"  "Filtering non-url content..."
sudo perl /etc/piholeparser/parser.pl "$f".ads.txt > "$f".ads_parsed.txt
echo -e "\t`wc -l "$f".ads_parsed.txt | cut -d " " -f 1` lines after parsing"
sudo rm "$f".ads.txt

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

## End File Loop
done

printf "$magenta" "___________________________________________________________"
echo ""
