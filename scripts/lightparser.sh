#!/bin/bash
## This is the Parsing Process
## For Lists that barely need it

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## File Lists     ##
####################

## Start File Loop
for f in $LIGHTPARSELISTS
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
sudo wget -q -O $TEMPFILE $source
sudo cat $TEMPFILE >> $ORIGINALFILETEMP
sudo rm $TEMPFILE
elif
[[ $source == file* ]]
then
printf "$yellow"    "Fetching List From Local File."
echo ""
sudo curl --silent -L $source >> $TEMPFILE
sudo cat $TEMPFILE >> $ORIGINALFILETEMP
sudo rm $TEMPFILE
else
printf "$yellow"    "Fetching List From Git Repo Mirror."
sudo echo "* $BASEFILENAME list unavailable to download. Attempted to use Mirror. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
sudo wget -q -O $TEMPFILE $MIRROREDFILEDL
sudo cat $TEMPFILE >> $ORIGINALFILETEMP
sudo rm $TEMPFILE
fi

## Source completion
done

## Original File Size
FETCHFILESIZE=$(stat -c%s "$ORIGINALFILETEMP")
if 
[ "$FETCHFILESIZE" -eq 0 ]
then
timestamp=$(echo `date`)
sudo echo "* $BASEFILENAME list was an empty file upon download. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
echo -e "\t`wc -l $ORIGINALFILETEMP | cut -d " " -f 1` lines downloaded"
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
sudo cp $ORIGINALFILETEMP $FILETEMP
sudo cp $ORIGINALFILETEMP $TEMPFILE

## Github has a 100mb limit, and empty files are useless
FETCHFILESIZE=$(stat -c%s "$TEMPFILE")
timestamp=$(echo `date`)
if 
[ "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was $FETCHFILESIZE bytes, and too large to mirror on github. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $TEMPFILE
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was an empty file. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $TEMPFILE
else
echo ""
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$yellow"  "Creating Mirror of Unparsed File."
echo ""
sudo mv $TEMPFILE $MIRROREDFILE
fi

####################
## Pre-Processing ##
####################

## Domain Requirements,, a period and a letter
PARSECOMMENT="Checking for FQDN Requirements."
printf "$yellow"  "$PARSECOMMENT ..."
sed '/[a-z]/!d; /[.]/!d' < $FILETEMP > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Comments #'s and !'s, also empty lines
PARSECOMMENT="Removing Commented Lines."
printf "$yellow"  "$PARSECOMMENT ..."
sed '/^\s*#/d; s/[#]/\'$'\n/g; /[#]/d; /[!]/d; /^$/d' < $FILETEMP > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Invalid Characters
## FQDN's  can only have . _ and -
## apparently you can have an emoji domain name?
PARSECOMMENT="Removing Invalid FQDN characters."
printf "$yellow"  "$PARSECOMMENT ..."
sed '/[,]/d; s/"/'\''/g; /\"\//d; /[+]/d; /[\]/d; /[/]/d; /[<]/d; /[>]/d; /[?]/d; /[*]/d; /[#]/d; /[!]/d; /[@]/d; /[~]/d; /[`]/d; /[=]/d; /[:]/d; /[;]/d; /[%]/d; /[&]/d; /[(]/d; /[)]/d; /[$]/d; /\[\//d; /\]\//d; /[{]/d; /[}]/d' < $FILETEMP > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Periods at begining and end of lines
PARSECOMMENT="Removing Lines With a Period at the Start or End."
printf "$yellow"  "$PARSECOMMENT ..."
sudo sed '/^[.],/d; /^[.]/d; /[.]$/d' < $FILETEMP > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Replace Spaces and, then Remove Empty Lines
PARSECOMMENT="Replacing Spaces with NewLines, then Removing Empty Lines."
printf "$yellow"  "$PARSECOMMENT ..."
sed 's/\s\+/\n/g; /^$/d' < $FILETEMP > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Remove IP addresses
PARSECOMMENT="Removing IP Addresses."
printf "$yellow"  "$PARSECOMMENT ..."
sed 's/^PRIMARY[ \t]*//; s/^localhost[ \t]*//; s/blockeddomain.hosts[ \t]*//; s/^0.0.0.0[ \t]*//; s/^127.0.0.1[ \t]*//; s/^::1[ \t]*//' < $FILETEMP > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Periods at begining and end of lines
PARSECOMMENT="Removing Lines With a Period at the Start or End."
printf "$yellow"  "$PARSECOMMENT ..."
sed '/^[.],/d; /^[.]/d; /[.]$/d' < $FILETEMP > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Pipes and Carrots
PARSECOMMENT="Removing Pipes and Carrots."
printf "$yellow"  "$PARSECOMMENT ..."
sudo cat -s $FILETEMP | sed 's/^||//' | cut -d'^' -f-1 > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Domain Requirements,, a period and a letter
PARSECOMMENT="Checking for FQDN Requirements."
printf "$yellow"  "$PARSECOMMENT ..."
sed '/[a-z]/!d; /[.]/!d' < $FILETEMP > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Duplicate Removal
PARSECOMMENT="Removing Duplicate Lines."
printf "$yellow"  "$PARSECOMMENT ..."
sudo cat -s $FILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $TEMPFILE $FILETEMP
echo ""

## Prepare for next step
sudo mv $FILETEMP $TEMPFILE

####################
## Complete Lists ##
#################### 

echo ""
printf "$green"   "Attempting Creation of Parsed List."
echo ""

## Github has a 100mb limit, and empty files are useless
FETCHFILESIZE=$(stat -c%s "$TEMPFILE")
timestamp=$(echo `date`)
if 
[ "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was $FETCHFILESIZE bytes, and too large to mirror on github. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $TEMPFILE
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was an empty file. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $TEMPFILE
else
echo ""
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$yellow"  "Copying to the parsed Directory."
echo ""
sudo mv $TEMPFILE $PARSEDFILE
fi

printf "$magenta" "___________________________________________________________"
echo ""

## End File Loop
done
