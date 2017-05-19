#!/bin/bash
## This is the Parsing Process

## Colors
source /etc/piholeparser/scripts/colors.var

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
printf "$cyan"    "$source"
echo ""

## Filter domain name
UPCHECK=`echo $source | awk -F/ '{print $3}'`

## Ping domain before continuing
if ping -c 1 $UPCHECK &> /dev/null
then

##Fetch IP of source
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"

sudo curl --silent $source >> "$f".ads.txt
echo -e "\t`wc -l "$f".ads.txt | cut -d " " -f 1` lines downloaded"


## Filter
echo ""
printf "$yellow"  "Filtering non-url content..."
sudo perl /etc/piholeparser/parser/parser.pl "$f".ads.txt > "$f".ads_parsed.txt
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

## Skip Source if domain down
else
echo "Skipping "$source" because pingtest failed"
fi

## End File Loop
done

done

printf "$magenta" "___________________________________________________________"
echo ""
