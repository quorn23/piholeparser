#!/bin/bash
## This is the Parsing Process
##
## It Parses all of the lists individually
## for the sake of decent filenames.

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scripts/colors.var

####################
## File Lists     ##
####################

echo ""
printf "$green"   "Parsing Individual Lists."
echo ""

## Set File .lst
FILES=/etc/piholeparser/lists/*.lst

## Start File Loop
for f in $FILES
do

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Processing list from $f"
echo ""

## Process sources within file.lst
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
####################

## download and merge sources for each file.lst
sudo curl --silent -L $source >> "$f".orig.txt
echo -e "\t`wc -l "$f".orig.txt | cut -d " " -f 1` lines downloaded"

## Source completion
done

####################
## Create Mirrors ##
####################

echo ""
printf "$green"   "Attempting creation of mirror file"
echo ""

sudo cp "$f".orig.txt "$f".mirror.txt

## Github has a 100mb limit
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

####################
## Pre-Processing ##
####################

echo ""
printf "$green"   "Pre-Processing"
echo ""

PRE="$f".pre.txt
POST="$f".post.txt

sudo cp "$f".mirror.txt $PRE

## Remove comments
echo ""
PARSECOMMENT="removing comments"
printf "$yellow"  "$PARSECOMMENT..."
sudo sed '/[#]/d' $PRE > $POST
sudo rm $PRE
sudo mv $POST $PRE
sudo sed '/[!]/d' $PRE > $POST
sudo rm $PRE
echo -e "\t`wc -l $POST | cut -d " " -f 1` lines after $PARSECOMMENT ."
sudo mv $POST $PRE

## Remove Empty Lines
echo ""
PARSECOMMENT="removing empty lines"
printf "$yellow"  "$PARSECOMMENT ..."
sudo sed '/^$/d' $PRE > $POST
sudo rm $PRE
echo -e "\t`wc -l $POST | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $POST $PRE

## remove asterisk lines
echo ""
PARSECOMMENT="removing asterisk lines"
printf "$yellow"  "$PARSECOMMENT ..."
sudo sed '/[*]/d' $PRE > $POST
sudo rm $PRE
echo -e "\t`wc -l $POST | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $POST $PRE

## delete lines with forward slash
echo ""
PARSECOMMENT="removing lines containing a forward slash"
printf "$yellow"  "$PARSECOMMENT ..."
sudo sed '/[/]/d' $PRE > $POST
sudo rm $PRE
echo -e "\t`wc -l $POST | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $POST $PRE

## Pre-Processing done
sudo mv "$f".pre.txt "$f".preproc.txt

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
sudo cat -s "$f".preproc.txt | egrep '^\|\|' | cut -d'/' -f1 | cut -d '^' -f1 | cut -d '$' -f1 | tr -d '|' > "$f".method3.txt
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

## Remove Pre-processed list
sudo rm "$f".preproc.txt

echo ""
printf "$green"   "Merging lists from all Parsing Methods"
echo ""

## merge
sudo cat "$f".method*.txt >> "$f".merged.txt
echo -e "\t`wc -l "$f".merged.txt | cut -d " " -f 1` lines after merging"
sudo rm "$f".method*.txt

## Prepare to sift merged lists
sudo mv "$f".merged.txt $PRE

## Duplicate Removal
echo ""
PARSECOMMENT="removing duplicates"
printf "$yellow"  "$PARSECOMMENT ..."
sort -u $PRE > $POST
sudo rm $PRE
echo -e "\t`wc -l $POST | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $POST $PRE

## Remove IP addresses
echo ""
PARSECOMMENT="removing IP addresses"
printf "$yellow"  "$PARSECOMMENT ..."
sudo sed '/[a-z]/!d' < $PRE > $POST
sudo rm $PRE
echo -e "\t`wc -l $POST | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $POST $PRE

## Done with merge
sudo mv $PRE "$f".txt

####################
## Complete Lists ##
#################### 

echo ""
printf "$green"   "Attempting Creation of Parsed List."
echo ""

PFILENAME="$f".txt
PFILESIZE=$(stat -c%s "$PFILENAME")

## Github has a 100mb limit, and empty files are useless
if
test $(stat -c%s "$f".txt) -ge 104857600
then
echo ""
printf "$red"     "Size of $PFILENAME = $PFILESIZE bytes."
printf "$red"     "Parsed File Too Large For Github. Deleting."
sudo rm "$f".txt
elif
test $(stat -c%s "$f".txt) -eq 0
then
echo ""
printf "$red"     "Size of $PFILENAME = $PFILESIZE bytes."
sudo rm "$f".txt
else
echo ""
printf "$yellow"  "Size of $PFILENAME = $PFILESIZE bytes."
printf "$yellow"  "File will be moved to the parsed directory."
sudo mv "$f".txt /etc/piholeparser/parsed/
sudo rename "s/.lst.orig.txt/.txt/" /etc/piholeparser/parsed/*.txt
fi

printf "$magenta" "___________________________________________________________"
echo ""

## End File Loop
done
