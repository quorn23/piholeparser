#!/bin/bash

## Move lists
sudo mv /etc/piholeparser/lists/*.ads.txt /etc/piholeparser/mirroredlists/

## Fix Filenames
sudo rename "s/.lst.ads.txt/.txt/" /etc/piholeparser/mirroredlists/*.txt

## Remove Giant Mirror File
sudo rm /etc/piholeparser/mirroredlists/1111ALLPARSEDLISTS1111.txt

if 
[ -s "$f".txt ]
then
echo ""
echo ""

else
echo ""
echo ""

fi
