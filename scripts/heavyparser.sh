#!/bin/bash
## This is the Parsing Process
## For Lists that barely need it

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## File Lists     ##
####################

## Start File Loop
for f in $HEAVYPARSELISTS
do

echo ""
printf "$blue"    "___________________________________________________________"
echo ""

## Process sources within file.lst
for source in `cat $f`;
do

## Variables
source /etc/piholeparser/scriptvars/dynamicvariables.var

printf "$green"    "Processing $BASEFILENAME list."
echo "" 
printf "$cyan"    "Downloading from:"
printf "$cyan"    "$source"
echo "" 

####################
## Download Lists ##
####################

if
[[ -n $UPCHECK ]]
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
fi

if
[[ -n $SOURCEIP ]]
then
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of "$SOURCEIP"."
echo ""
sudo wget -q -O $BTEMPFILE $source
sudo cat $BTEMPFILE >> $BORIGINALFILETEMP
sudo rm $BTEMPFILE
elif
[[ $source == file* ]]
then
printf "$yellow"    "Fetching List From Local File."
echo ""
sudo curl --silent -L $source >> $BTEMPFILE
sudo cat $BTEMPFILE >> $BORIGINALFILETEMP
sudo rm $BTEMPFILE
else
printf "$yellow"    "Fetching List From Git Repo Mirror."
sudo echo "* $BASEFILENAME list unavailable to download. Attempted to use Mirror. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
sudo wget -q -O $BTEMPFILE $MIRROREDFILEDL
sudo cat $BTEMPFILE >> $BORIGINALFILETEMP
sudo rm $BTEMPFILE
fi

## Source completion
done

## Original File Size
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
if 
[ "$FETCHFILESIZE" -eq 0 ]
then
timestamp=$(echo `date`)
sudo echo "* $BASEFILENAME list was an empty file upon download. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
echo -e "\t`wc -l $BORIGINALFILETEMP | cut -d " " -f 1` lines downloaded"
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
echo ""
fi

####################
## Create Mirrors ##
####################

echo ""
printf "$green"   "Attempting Creation of Mirror File."
echo ""

## Copy original, one for mirror, one for next step
sudo cp $BORIGINALFILETEMP $BFILETEMP
sudo cp $BORIGINALFILETEMP $BTEMPFILE

## Github has a 100mb limit, and empty files are useless
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
timestamp=$(echo `date`)
if 
[ "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was $FETCHFILESIZE bytes, and too large to mirror on github. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BTEMPFILE
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was an empty file. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BTEMPFILE
else
echo ""
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$yellow"  "Creating Mirror of Unparsed File."
echo ""
sudo mv $BTEMPFILE $MIRROREDFILE
fi

####################
## Pre-Processing ##
####################

## Comments #'s and !'s, also empty lines
PARSECOMMENT="Removing Lines with Comments or Empty."
printf "$yellow"  "$PARSECOMMENT"
sed '/^\s*#/d; s/[#]/\'$'\n/g; /[#]/d; /[!]/d; /^$/d' < $BFILETEMP > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""

## Invalid Characters
## FQDN's  can only have . _ and -
## apparently you can have an emoji domain name?
PARSECOMMENT="Removing Invalid FQDN characters."
printf "$yellow"  "$PARSECOMMENT"
sed '/[,]/d; s/"/'\''/g; /\"\//d; /[+]/d; /[\]/d; /[/]/d; /[<]/d; /[>]/d; /[?]/d; /[*]/d; /[#]/d; /[!]/d; /[@]/d; /[~]/d; /[`]/d; /[=]/d; /[:]/d; /[;]/d; /[%]/d; /[&]/d; /[(]/d; /[)]/d; /[$]/d; /\[\//d; /\]\//d; /[{]/d; /[}]/d' < $BFILETEMP > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""

#####################################################################
## Perl Parser
PARSECOMMENT="Cutting Lists with the Perl Parser."
printf "$yellow"  "$PARSECOMMENT"
sudo perl /etc/piholeparser/scripts/parser.pl $BFILETEMP > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""
#####################################################################

## Pipes and Carrots
PARSECOMMENT="Removing Pipes and Carrots."
printf "$yellow"  "$PARSECOMMENT"
sudo cat -s $BFILETEMP | sed 's/^||//' | cut -d'^' -f-1 > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""

## Remove IP addresses
PARSECOMMENT="Removing IP Addresses."
printf "$yellow"  "$PARSECOMMENT"
sed 's/^PRIMARY[ \t]*//; s/^localhost[ \t]*//; s/blockeddomain.hosts[ \t]*//; s/^0.0.0.0[ \t]*//; s/^127.0.0.1[ \t]*//; s/^::1[ \t]*//' < $BFILETEMP > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""

## Replace Spaces then Remove Empty Lines
PARSECOMMENT="Replacing Spaces with NewLines then Removing Empty Lines."
printf "$yellow"  "$PARSECOMMENT"
sed 's/\s\+/\n/g; /^$/d' < $BFILETEMP > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""

## Domain Requirements,, a period and a letter
PARSECOMMENT="Checking for FQDN Requirements."
printf "$yellow"  "$PARSECOMMENT"
sed '/[a-z]/!d; /[.]/!d' < $BFILETEMP > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""

## Periods at begining and end of lines
## This should fix Wildcarding
PARSECOMMENT="Removing Lines With a Period at the Start or End."
printf "$yellow"  "$PARSECOMMENT"
sed '/^[.],/d; /^[.]/d; /[.]$/d' < $BFILETEMP > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""

## Duplicate Removal
## if there are fewer lines after this, is something wrong?
PARSECOMMENT="Removing Duplicate Lines."
printf "$yellow"  "$PARSECOMMENT"
sudo cat -s $BFILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""

## This will remove lines with spaces
# sed ' / /d;'

## Prepare for next step
sudo mv $BFILETEMP $BTEMPFILE

####################
## Complete Lists ##
#################### 

echo ""
printf "$green"   "Attempting Creation of Parsed List."
echo ""

## Github has a 100mb limit, and empty files are useless
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
timestamp=$(echo `date`)
if 
[ "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was $FETCHFILESIZE bytes, and too large to mirror on github. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BTEMPFILE
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was an empty file. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BTEMPFILE
else
echo ""
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$yellow"  "Copying to the parsed Directory."
echo ""
sudo mv $BTEMPFILE $PARSEDFILE
fi

printf "$magenta" "___________________________________________________________"
echo ""

## End File Loop
done
