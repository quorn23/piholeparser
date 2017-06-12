#!/bin/bash
## Some lists are compressed in 7z format, this should extract them

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading and Extracting 7zip Compressed Lists."
echo ""

## Start 7zip File Loop
for f in $SEVENSLIST
do

## Process sources within file.lst
for source in `cat $f`;
do

## Variables
FNAME=`echo $f | cut -f 1 -d '.'` ## Used for better filenaming
FNAMEDONE="$FNAME".txt
TEMPFILE="$FNAME".temp.7z ## Temp File
UPCHECK=`echo $source | awk -F/ '{print $3}'` ## used to filter domain name

printf "$blue"    "___________________________________________________________"
echo ""

echo ""
printf "$cyan"    "$source"
echo "" 

if ping -c 1 $UPCHECK &> /dev/null
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP and extracting."
sudo wget -q -O $TEMPFILE $source
sudo 7z e -so $TEMPFILE > "$FNAMEDONE"
sudo rm $TEMPFILE
echo ""
echo -e "\t`wc -l $FNAMEDONE | cut -d " " -f 1` lines downloaded"
ORIGFILESIZE=$(stat -c%s "$FNAMEDONE")
printf "$yellow"  "Size of $FNAMEDONE = $ORIGFILESIZE bytes."
else 
printf "$red"    "$FNAME list unavailable right now"
fi 

echo ""
printf "$magenta" "___________________________________________________________"

## End looping
done
done
