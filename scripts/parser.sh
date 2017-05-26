#!/bin/bash
## This is the Parsing Process
## It Parses all of the lists individually for
## the sake of decent filenames.
##
## It creates a mirror of each original unparsed file, 
## unless it is over the 100MB limit of Github.
##
## Files with zero content are deleted, as they 
## aren't worth anybody's time.
##
## It also creates a "master" file
## with all parsed lists combined
## as well as a longer list of all the lists used.

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scripts/colors.var

echo ""
printf "$green"   "Parsing Individual Lists."
echo ""

## Set File Directory
FILES=/etc/piholeparser/lists/*.lst

## Start File Loop
for f in $FILES
do

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Processing list from $f"
echo ""

for source in `cat $f`;
do
echo ""
printf "$cyan"    "$source"
echo "" 

## Filter domain name
UPCHECK=`echo $source | awk -F/ '{print $3}'`

#Fetch IP of source
if [[ -z $UPCHECK ]]
then
printf "$yellow"    "Fetching List From Local File"
else 
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'` &>/dev/null
SOURCEIP=`echo $SOURCEIPFETCH` &>/dev/null
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"
fi

## Download Lists
sudo curl --silent -L $source >> "$f".orig.txt
echo -e "\t`wc -l "$f".orig.txt | cut -d " " -f 1` lines downloaded"
done

echo ""
printf "$green"   "Processing lists With Method 1"
echo ""

## Remove comments
echo ""
printf "$yellow"  "Removing Comments..."
sudo cat "$f".orig.txt | egrep -v -e '^[[:blank:]]*#|^$' > "$f".nocomment.txt
echo -e "\t`wc -l "$f".nocomment.txt | cut -d " " -f 1` lines after removing comments"

# look for:  ||domain.tld^
echo ""
printf "$yellow"  "Looking for ||domain.tld^..."
sort -u "$f".nocomment.txt | grep ^\|\|.*\^$ | grep -v \/ > "$f".nopipes.txt
echo -e "\t`wc -l "$f".nopipes.txt | cut -d " " -f 1` lines after removing pipes"
sudo rm "$f".nocomment.txt
 
# remove extra chars
echo ""
printf "$yellow"  "Removing extra characters..."
sed 's/[\|^]//g' < "$f".nopipes.txt > "$f".noextrachar.txt
echo -e "\t`wc -l "$f".noextrachar.txt | cut -d " " -f 1` lines after removing extra characters"
sudo rm "$f".nopipes.txt

## Sorting and Duplicate Removal
echo ""
printf "$yellow"  "Sorting and Removing duplicates..."
sort -u "$f".noextrachar.txt > "$f".ads_unique1.txt
sudo rm "$f".noextrachar.txt
echo -e "\t`wc -l "$f".ads_unique1.txt | cut -d " " -f 1` lines after deduping"

echo ""
printf "$green"   "Processing lists With Method 2"
echo ""

## Remove comments
echo ""
printf "$yellow"  "Removing Comments..."
sudo cat "$f".orig.txt | egrep -v -e '^[[:blank:]]*#|^$' > "$f".ads.txt
echo -e "\t`wc -l "$f".ads.txt | cut -d " " -f 1` lines after removing comments"

## Filter
echo ""
printf "$yellow"  "Filtering non-url content..."
sudo perl /etc/piholeparser/scripts/parser.pl "$f".ads.txt > "$f".ads_parsed.txt
echo -e "\t`wc -l "$f".ads_parsed.txt | cut -d " " -f 1` lines after parsing"

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."
sort -u "$f".ads_parsed.txt > "$f".ads_unique2.txt
sudo rm "$f".ads_parsed.txt
echo -e "\t`wc -l "$f".ads_unique2.txt | cut -d " " -f 1` lines after deduping"

echo ""
printf "$green"   "Processing lists With Method 3"
echo ""

sudo curl -s file://"$f".orig.txt | egrep '^\|\|' | cut -d'/' -f1 | cut -d '^' -f1 | cut -d '$' -f1 | tr -d '|' > "$f".ads_unique3.txt
echo -e "\t`wc -l "$f".ads_unique3.txt | cut -d " " -f 1` lines after dusing method 3"

## merge lists
echo ""
printf "$green"   "Merging lists from both Parsing Methods"
echo ""
sudo cat "$f".ads_unique1.txt "$f".ads_unique2.txt "$f".ads_unique3.txt >> "$f".merged.txt
sudo rm "$f".ads_unique1.txt
sudo rm "$f".ads_unique2.txt

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."
sort -u "$f".merged.txt > "$f".txt
sudo rm "$f".merged.txt
echo -e "\t`wc -l "$f".txt | cut -d " " -f 1` lines after deduping"

## Remove Empty Files
if 
[ -s "$f".txt ]
then
echo ""
printf "$yellow"  "File will be moved to the parsed directory."
sudo mv "$f".txt /etc/piholeparser/parsed/
sudo rename "s/.lst.txt/.txt/" /etc/piholeparser/parsed/*.txt
else
echo ""
printf "$red"     "File Empty. It will be deleted."
rm -rf "$f".txt
fi

## Create Mirrors
if 
test $(stat -c%s "$f".orig.txt) -ge 104857600
then
echo ""
printf "$red"     "Mirror File Too Large For Github. Deleting."
sudo rm "$f".orig.txt
else
echo ""
printf "$yellow"  "Creating Mirror of Unparsed File."
sudo mv "$f".orig.txt /etc/piholeparser/mirroredlists/
sudo rename "s/.lst.ads.txt/.txt/" /etc/piholeparser/mirroredlists/*.txt
fi

## End File Loop
done

printf "$magenta" "___________________________________________________________"
echo ""

## Merge Individual Lists
echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Creating Single Big List."
echo ""
sudo cat /etc/piholeparser/parsed/*.txt | sort > /etc/piholeparser/parsedall/ALLPARSEDLISTS.txt

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."

sort -u /etc/piholeparser/parsedall/ALLPARSEDLISTS.txt > /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.txt
echo -e "\t`wc -l /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.txt | cut -d " " -f 1` lines after deduping"
sudo rm /etc/piholeparser/parsedall/ALLPARSEDLISTS.txt

printf "$magenta" "___________________________________________________________"
echo ""

## Tidying up
{ if [ "$version" = "github" ]
then
sudo cp /etc/piholeparser/parsedall/*.txt /etc/piholeparser/parsed/
elif
[ "$version" = "local" ]
then
sudo rm /etc/piholeparser/parsed/*.txt
fi }

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Rebuilding the complete list file."

if 
ls /etc/piholeparser/1111ALLPARSEDLISTS1111.lst &> /dev/null; 
then
sudo rm /etc/piholeparser/1111ALLPARSEDLISTS1111.lst
else
echo ""
fi

if 
ls /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.lst &> /dev/null; 
then
sudo rm /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.lst
else
echo ""
fi

sudo cat /etc/piholeparser/lists/*.lst | sort > /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.lst
printf "$magenta" "___________________________________________________________"
echo ""
