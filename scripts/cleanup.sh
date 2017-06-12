#!/bin/bash
## This script Cleans up directories 
## mainly to avoid pushing excess files to Github

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Cleaning Up."

## Clean list directories

if 
ls /etc/piholeparser/lists/heavyparsing/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/heavyparsing/*.txt
else
:
fi

if 
ls /etc/piholeparser/lists/lightparsing/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/lightparsing/*.txt
else
:
fi

if 
ls /etc/piholeparser/lists/7zip/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/7zip/*.txt
else
:
fi

if 
ls /etc/piholeparser/lists/tar/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/tar/*.txt
else
:
fi

## Clean compressedlist directory

if 
ls /etc/piholeparser/compressedconvert/*.7z &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.7z
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

## Clean parsed directory if using locally

if 
[ "$version" = "local" ]
then
sudo rm /etc/piholeparser/parsed/*.txt
else
:
fi

## Cleanup from old versions
if 
ls /etc/piholeparser/lists/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/*.txt
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
ls /var/www/html/compressedconvert/*.txt &> /dev/null; 
then
sudo rm /var/www/html/compressedconvert/*.txt
else
:
fi

printf "$magenta" "___________________________________________________________"
echo ""
