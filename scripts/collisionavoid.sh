#!/bin/bash
## This runs towards the beginning of the script to avoid
## file collisions that might cause errors.
##
## I added file checks to reduce on-screen errors

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Clearing the Path."

## Clean list directories

if 
ls /etc/piholeparser/lists/*/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/*/*.txt
else
:
fi

## Remove old parsed files

if 
ls /etc/piholeparser/parsed/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/parsed/*.txt
else
:
fi

## Remove old mirror files

if 
ls /etc/piholeparser/mirroredlists/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/mirroredlists/*.txt
else
:
fi

## Cleanup big lists

if 
ls /etc/piholeparser/parsedall/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/parsedall/*.txt
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
ls /var/www/html/compressedconvert/*.txt &> /dev/null; 
then
sudo rm /var/www/html/compressedconvert/*.txt
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

printf "$magenta" "___________________________________________________________"
echo ""
