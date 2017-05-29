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
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"
fi

####################
## Download Lists ##
## and            ##
## Pre-Processing ##
####################
sudo curl --silent -L $source >> "$f".orig.txt
echo -e "\t`wc -l "$f".orig.txt | cut -d " " -f 1` lines downloaded"
done

echo ""
printf "$green"   "Pre-Processing"
echo ""

## Remove comments
printf "$yellow"  "Removing Comments..."
sudo cat "$f".orig.txt | egrep -v -e '^[[:blank:]]*#|^$' > "$f".nocomment.txt
sudo sed '/^!/d' "$f".nocomment.txt > "$f".nocomments.txt
sudo sed '/[/]/d' "$f".nocomments.txt > "$f".noncomm.txt
echo -e "\t`wc -l "$f".noncomm.txt | cut -d " " -f 1` lines after removing comments"

## Remove Empty Lines
echo ""
printf "$yellow"  "Removing empty lines..."
sudo sed '/^$/d' "$f".noncomm.txt > "$f".empties.txt
echo -e "\t`wc -l "$f".empties.txt | cut -d " " -f 1` lines after removing blank space"
sudo rm "$f".nocomment.txt

## remove asterisk lines
echo ""
printf "$yellow"  "Removing asterisk lines..."
sudo sed '/\*\*/d' "$f".empties.txt > "$f".aster.txt
echo -e "\t`wc -l "$f".aster.txt | cut -d " " -f 1` lines after removing asterisk lines"
sudo rm "$f".empties.txt

## stip http and https
echo ""
printf "$yellow"  "Removing http and https..."
sudo sed 's/[http://]//g' "$f".aster.txt > "$f".http.txt
sudo sed 's/[https://]//g' "$f".http.txt > "$f".https.txt
sudo rm "$f".aster.txt

## delete lines with forward slash
echo ""
printf "$yellow"  "Removing lines containing a forward slash..."
sudo sed '/[/]/d' "$f".https.txt > "$f".forward.txt
echo -e "\t`wc -l "$f".forward.txt | cut -d " " -f 1` lines after removing full-length urls"
sudo rm "$f".https.txt
sudo rm "$f".http.txt

## localhost
echo ""
printf "$yellow"  "Removing lines containing localhost..."
sudo sed '/localhost/d' "$f".forward.txt > "$f".preproc.txt
sudo rm "$f".forward.txt

####################
## Method 1       ##
####################
echo ""
printf "$green"   "Processing lists With Method 1"
echo ""

# look for:  ||domain.tld^
echo ""
printf "$yellow"  "Looking for ||domain.tld^..."
sort -u "$f".preproc.txt | grep ^\|\|.*\^$ | grep -v \/ > "$f".nopipes.txt
echo -e "\t`wc -l "$f".nopipes.txt | cut -d " " -f 1` lines after removing pipes"
 
# remove extra chars
echo ""
printf "$yellow"  "Removing extra characters..."
sudo sed 's/[\|^]//g' < "$f".nopipes.txt > "$f".method1.txt
echo -e "\t`wc -l "$f".method1.txt | cut -d " " -f 1` lines after removing extra characters"
sudo rm "$f".nopipes.txt

####################
## Method 2       ##
####################

echo ""
printf "$green"   "Processing lists With Method 2"
echo ""

## Filter
echo ""
printf "$yellow"  "Filtering non-url content..."
sudo perl /etc/piholeparser/scripts/parser.pl "$f".preproc.txt > "$f".method2.txt
echo -e "\t`wc -l "$f".method2.txt | cut -d " " -f 1` lines after parsing"

####################
## Method 3       ##
####################

echo ""
printf "$green"   "Processing lists With Method 3"
echo ""

## Removing extra content
sudo curl -s file://"$f".preproc.txt | egrep '^\|\|' | cut -d'/' -f1 | cut -d '^' -f1 | cut -d '$' -f1 | tr -d '|' > "$f".method3.txt
echo -e "\t`wc -l "$f".method3.txt | cut -d " " -f 1` lines after using method 3"

####################
## Method 4       ##
####################

#echo ""
#printf "$green"   "Processing lists With Method 4"
#echo ""

#sudo sed 's/^||//' "$f".preproc.txt | cut -d'^' -f-1 > "$f".method4.txt
#echo -e "\t`wc -l "$f".method4.txt | cut -d " " -f 1` lines after using method 4"

####################
## Merge lists    ##
####################

## merge lists
echo ""
printf "$green"   "Merging lists from all Parsing Methods"
echo ""
sudo cat "$f".method*.txt >> "$f".merged.txt
echo -e "\t`wc -l "$f".merged.txt | cut -d " " -f 1` lines after merging"
sudo rm "$f".method*.txt

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."
sort -u "$f".merged.txt > "$f".deduped.txt
echo -e "\t`wc -l "$f".deduped.txt | cut -d " " -f 1` lines after deduping merged lists"
sudo rm "$f".merged.txt

## Remove IP addresses
echo ""
printf "$yellow"  "Removing IP addresses..."
sudo sed '/[a-z]/!d' < "$f".deduped.txt > "$f".txt
echo -e "\t`wc -l "$f".txt | cut -d " " -f 1` lines after removing IP addresses"
sudo rm "$f".deduped.txt

## Remove Pre-processed list
sudo rm "$f".preproc.txt

####################
## Move files     ##
####################

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
sudo rename "s/.lst.orig.txt/.txt/" /etc/piholeparser/mirroredlists/*.txt
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
