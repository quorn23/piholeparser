#!/bin/bash

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Push Changes up to Pihole Web Server"

if 
[ -d "/var/www/html/lists/" ] 
then
echo "" 
else
sudo mkdir /var/www/html/lists/
fi

if 
ls /var/www/html/lists/1111ALLPARSEDLISTS1111.txt &> /dev/null; 
then
sudo rm /var/www/html/lists/1111ALLPARSEDLISTS1111.txt
else
echo ""
fi

sudo cp -p /etc/piholeparser/parsed/1111ALLPARSEDLISTS1111.txt /var/www/html/lists/1111ALLPARSEDLISTS1111.txt
printf "$magenta" "___________________________________________________________"
echo ""
