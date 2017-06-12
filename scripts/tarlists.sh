#!/bin/bash
## This will download and extract tar lists

## Version
source /etc/piholeparser.var

## Variables
source /etc/piholeparser/scriptvars/variables.var

## Set File .lst
FILES=/etc/piholeparser/lists/tar/*.lst

## Start 7zip File Loop
for f in $FILES
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
sudo tar -xvf $TEMPFILE
#sudo tar -xvf $TEMPFILE -C $COMPRESSEDDIR > "$FNAMEDONE"
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

## cleanup

if 
ls /etc/piholeparser/compressedconvert/*.tar.gz &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.tar.gz
else
:
fi
