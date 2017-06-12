#!/bin/bash
## This will download and extract tar lists

## Version
source /etc/piholeparser.var

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading and Extracting Compressed Tar Lists."
echo ""

## Blackweb
if ping -c 1 github.com &> /dev/null
then
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Blackweb List"
echo ""
sudo wget https://github.com/maravento/blackweb/raw/master/blackweb.tar.gz -P $COMPRESSEDDIR
echo ""
printf "$yellow"  "Extracting"
echo ""
sudo tar -xvf "$COMPRESSEDDIR"blackweb.tar.gz -C $COMPRESSEDDIR
echo ""
printf "$yellow"  "Renaming"
echo ""
sudo mv "$COMPRESSEDDIR"blackweb.txt "$COMPRESSEDDIR"Blackweb.txt
echo ""
printf "$magenta" "___________________________________________________________"
else
echo ""
printf "$red"     "BlackWeb list are unavailable right now"
echo ""
fi

## cleanup

if 
ls /etc/piholeparser/compressedconvert/*.tar.gz &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.tar.gz
else
:
fi
