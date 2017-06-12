#!/bin/bash
## This script Cleans up directories 
## mainly to avoid pushing excess files to Github

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Cleaning Up."

if 
ls /etc/piholeparser/lists/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/*.txt
else
:
fi

if 
ls /etc/piholeparser/lists/heavyparsing/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/*.txt
else
:
fi

if 
ls /etc/piholeparser/lists/lightparsing/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/*.txt
else
:
fi

if 
ls /etc/piholeparser/compressedconvert/*.7z &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.7z
else
:
fi

if 
ls /etc/piholeparser/mirroredlists/*.ads.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/mirroredlists/*.ads.txt
else
:
fi

if 
ls /etc/piholeparser/compressedconvert/*.tar.gz &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.tar.gz
else
:
fi

if 
ls /etc/piholeparser/compressedconvert/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.txt
else
:
fi

if 
ls /var/www/html/compressedconvert/*.txt &> /dev/null; 
then
sudo rm /var/www/html/compressedconvert/*.txt
else
:
fi

if 
[ "$version" = "local" ]
then
sudo rm /etc/piholeparser/parsed/*.txt
else
:
fi

printf "$magenta" "___________________________________________________________"
echo ""
