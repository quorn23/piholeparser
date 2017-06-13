#!/bin/bash
## Some lists are compressed in 7z format, this should extract them

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading and Extracting 7zip Compressed Lists."
timestamp=$(echo `date`)
sudo echo "## 7zip $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""

## Start 7zip File Loop
for f in $SEVENSLIST
do

## Process sources within file.lst
for source in `cat $f`;
do

## Set Variables (again, I guess)
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
sudo wget -q -O $SEVENTEMPFILE $source
sudo 7z e -so $SEVENTEMPFILE > "$FNAMEDONE"
sudo rm $SEVENTEMPFILE
else 
sudo echo "* $FNAME list was unavailable for download $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
printf "$red"    "$FNAME list unavailable right now"
fi 

## End source looping
done

echo ""
echo -e "\t`wc -l $FNAMEDONE | cut -d " " -f 1` lines downloaded"
ORIGFILESIZE=$(stat -c%s "$FNAMEDONE")
printf "$yellow"  "Size of $FNAMEDONE = $ORIGFILESIZE bytes."

## End File loop
done

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
printf "$magenta" "___________________________________________________________"
