#!/bin/bash
## This will download and extract tar lists

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading and Extracting Tar Compressed Lists."
timestamp=$(echo `date`)
sudo echo "## Tar $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""

## Start 7zip File Loop
for f in $TARLISTS
do

## Process sources within file.lst
for source in `cat $f`;
do

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""

echo ""
printf "$cyan"    "$source"
echo "" 

timestamp=$(echo `date`)
if ping -c 1 $UPCHECK &> /dev/null
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP and extracting."
sudo wget -q -O $TEMPFILE $source
TARFILEX=$(tar -xavf $TEMPFILE -C $TEMPDIR)
sudo cat $TARFILEX > $TARLISTDONE
echo -e "\t`wc -l $TARLISTDONE | cut -d " " -f 1` lines downloaded"
FETCHFILESIZE=$(stat -c%s "$TARLISTDONE")
printf "$yellow"  "Size of $TARLISTDONE = $FECTHFILESIZE bytes."
else 
sudo echo "* $BASEFILENAME list was unavailable for download $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
printf "$red"    "$BASEFILENAME list unavailable right now"
fi 

## End Source loop
done

## End File Loop
done

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
printf "$magenta" "___________________________________________________________"
