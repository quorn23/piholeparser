#!/bin/bash
## This runs towards the beginning of the script to avoid
## file collisions that might cause errors.
##
## I added file checks to reduce on-screen errors

## Colors
source /etc/piholeparser/scripts/colors.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Clearing the Path."

if 
ls /etc/piholeparser/lists/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/lists/*.txt
else
echo ""
fi

if 
ls /etc/piholeparser/mirroredlists/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/mirroredlists/*.txt
else
echo ""
fi

if 
ls /etc/piholeparser/parsed/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/parsed/*.txt
else
echo ""
fi

if 
ls /etc/piholeparser/parsedall/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/parsedall/*.txt
else
echo ""
fi

if 
ls /etc/piholeparser/compressedconvert/*.7z &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.7z
else
echo ""
fi

if 
ls /etc/piholeparser/compressedconvert/*.tar.gz &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.tar.gz
else
echo ""
fi

if 
ls /etc/piholeparser/compressedconvert/*.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.txt
else
echo ""
fi

if 
ls /var/www/html/compressedconvert/*.txt &> /dev/null; 
then
sudo rm /var/www/html/compressedconvert/*.txt
else
echo ""
fi

if 
ls /etc/piholeparser/mirroredlists/*.ads.txt &> /dev/null; 
then
sudo rm /etc/piholeparser/mirroredlists/*.ads.txt
else
echo ""
fi

printf "$magenta" "___________________________________________________________"
echo ""
