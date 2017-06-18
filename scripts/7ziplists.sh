#!/bin/bash
## Some lists are compressed in 7z format, this should extract them

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

## Start 7zip File Loop
for f in $SEVENSLIST
do

## Process sources within file.lst
for source in `cat $f`;
do

## Variables
source /etc/piholeparser/scriptvars/dynamicvariables.var

printf "$blue"    "___________________________________________________________"
echo ""

printf "$green"    "Processing $BASEFILENAME list."
echo "" 
printf "$cyan"    "Downloading from:"
printf "$cyan"    "$source"
echo "" 

if ping -c 1 $UPCHECK &> /dev/null
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP and extracting."
sudo wget -q -O $COMPRESSEDTEMPSEVEN $source
sudo 7z e -so $COMPRESSEDTEMPSEVEN > $BTEMPFILE
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines downloaded"
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
sudo mv $BTEMPFILE $SEVENSLISTDONE
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
sudo rm $COMPRESSEDTEMPSEVEN
else 
timestamp=$(echo `date`)
sudo echo "* $BASEFILENAME list was unavailable for download. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
printf "$red"    "$BASEFILENAME list unavailable right now"
fi 

## End source looping
done
printf "$magenta" "___________________________________________________________"
echo ""
## End File loop
done
