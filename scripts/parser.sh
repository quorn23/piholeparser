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

## Set variables
FNAME=`echo "${"$f"%%.*}"` ## Used for better filenaming
UPCHECK=`echo $source | awk -F/ '{print $3}'` ## used to filter domain
MFILENAME="$FNAME".orig.txt ## mirror file
PFILENAME="$FNAME".txt ## parsed file
PRE="$FNAME".pre.txt ## File in
POST="$FNAME".post.txt ## File Out
PREPROC="$FNAME".preproc.txt ## file after pre-processing
MERGED="$FNAME".merged.txt
MERGEMETHODS="$FNAME".method*.txt


echo ""
printf "$cyan"    "$source"
echo "" 

## Fetch IP of source, doesn't display for local files
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
sudo curl --silent -L $source >> $MFILENAME
echo -e "\t`wc -l $MFILENAME | cut -d " " -f 1` lines downloaded"

## Source completion
done

####################
## Create Mirrors ##
####################

echo ""
printf "$green"   "Attempting creation of mirror file"
echo ""

## Copy original, one for mirror, one for next step
sudo cp $MFILENAME $PRE

## Github has a 100mb limit, and empty files are useless
MFILESIZE=$(stat -c%s "$MFILENAME")
if 
test $(stat -c%s $MFILENAME) -ge 104857600
then
echo ""
printf "$red"     "Size of $MFILENAME = $MFILESIZE bytes."
printf "$red"     "Mirror File Too Large For Github. Deleting."
sudo rm $MFILENAME
elif
test $(stat -c%s $MFILENAME) -eq 0
then
echo ""
printf "$red"     "Size of $MFILENAME = $MFILESIZE bytes. Deleting."
sudo rm $MFILENAME
else
echo ""
printf "$yellow"     "Size of $MFILENAME = $MFILESIZE bytes."
printf "$yellow"  "Creating Mirror of Unparsed File."
sudo mv $MFILENAME /etc/piholeparser/mirroredlists/"$FNAME".txt
#sudo mv $MFILENAME /etc/piholeparser/mirroredlists/
#sudo rename "s/.lst.orig.txt/.txt/" /etc/piholeparser/mirroredlists/*.txt
fi

####################
## Pre-Processing ##
####################

echo ""
printf "$green"   "Pre-Processing"
echo ""

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
sudo mv $PRE $PREPROC

####################
## Method 1       ##
####################

METHOD="processing lists With Method 1"

echo ""
printf "$green"   "$METHOD"
echo ""

sort -u $PREPROC | grep ^\|\|.*\^$ | grep -v \/ > $POST
sudo sed 's/[\|^]//g' < $POST > "$FNAME".method1.txt
sudo rm $POST
echo -e "\t`wc -l "$FNAME".method1.txt | cut -d " " -f 1` lines after $METHOD"

####################
## Method 2       ##
####################

METHOD="processing lists With Method 2"

echo ""
printf "$green"   "$METHOD"
echo ""

sudo perl /etc/piholeparser/scripts/parser.pl $PREPROC > "$FNAME".method2.txt
echo -e "\t`wc -l "$FNAME".method2.txt | cut -d " " -f 1` lines after $METHOD"

####################
## Method 3       ##
####################

METHOD="processing lists With Method 3"

echo ""
printf "$green"   "$METHOD"
echo ""

sudo cat -s $PREPROC | egrep '^\|\|' | cut -d'/' -f1 | cut -d '^' -f1 | cut -d '$' -f1 | tr -d '|' > "$FNAME".method3.txt
echo -e "\t`wc -l "$FNAME".method3.txt | cut -d " " -f 1` lines after $METHOD"

####################
## Method 4       ##
####################

#METHOD="processing lists With Method 4"

#echo ""
#printf "$green"   "$METHOD"
#echo ""

#sudo sed 's/^||//' $PREPROC | cut -d'^' -f-1 > "$FNAME".method4.txt
#echo -e "\t`wc -l "$FNAME".method4.txt | cut -d " " -f 1` lines after $METHOD"

####################
## Merge lists    ##
####################

## Remove Pre-processed list
sudo rm $PREPROC

echo ""
printf "$green"   "Merging lists from all Parsing Methods"
echo ""

## merge
sudo cat $MERGEMETHODS >> $MERGED
echo -e "\t`wc -l $MERGED | cut -d " " -f 1` lines after merging"
sudo rm $MERGEMETHODS

## Prepare to sift merged lists
sudo mv $MERGED $PRE

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
sudo mv $PRE $PFILENAME

####################
## Complete Lists ##
#################### 

echo ""
printf "$green"   "Attempting Creation of Parsed List."
echo ""

## Github has a 100mb limit, and empty files are useless
PFILESIZE=$(stat -c%s "$PFILENAME")
if
test $(stat -c%s $PFILENAME) -ge 104857600
then
echo ""
printf "$red"     "Size of $PFILENAME = $PFILESIZE bytes."
printf "$red"     "Parsed File Too Large For Github. Deleting."
sudo rm $PFILENAME
elif
test $(stat -c%s $PFILENAME) -eq 0
then
echo ""
printf "$red"     "Size of $PFILENAME = $PFILESIZE bytes. Deleting."
sudo rm $PFILENAME
else
echo ""
printf "$yellow"  "Size of $PFILENAME = $PFILESIZE bytes."
printf "$yellow"  "File will be moved to the parsed directory."
sudo mv $PFILENAME /etc/piholeparser/parsed/"$FNAME".txt
#sudo mv $PFILENAME /etc/piholeparser/parsed/
#sudo rename "s/.lst.orig.txt/.txt/" /etc/piholeparser/parsed/*.txt
fi

printf "$magenta" "___________________________________________________________"
echo ""

## End File Loop
done
