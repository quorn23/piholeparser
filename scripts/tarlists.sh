#!/bin/bash
## This will download and extract tar lists

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

## Start 7zip File Loop
for f in $TARLISTS
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


timestamp=$(echo `date`)
if ping -c 1 $UPCHECK &> /dev/null
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP and extracting."
sudo wget -q -O $TEMPFILE $source
TARFILEX=$(tar -xavf $COMPRESSEDTEMP -C $TEMPDIR)
sudo cat $TARFILEX > $TEMPFILE
echo -e "\t`wc -l $TEMPFILE  | cut -d " " -f 1` lines downloaded"
FETCHFILESIZE=$(stat -c%s "$TEMPFILE")
printf "$yellow"  "Size of $BASEFILENAME = $FECTHFILESIZE bytes."
sudo mv $TEMPFILE $TARLISTDONE
else 
sudo echo "* $BASEFILENAME list was unavailable for download $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
printf "$red"    "$BASEFILENAME list unavailable right now"
fi 

## End Source loop
done

## End File Loop
done
