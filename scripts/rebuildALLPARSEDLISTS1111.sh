#!/bin/bash

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Rebuilding the complete list file."

if 
ls /etc/piholeparser/1111ALLPARSEDLISTS1111.lst &> /dev/null; 
then
sudo rm /etc/piholeparser/1111ALLPARSEDLISTS1111.lst
else
echo ""
fi

if 
ls /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.lst &> /dev/null; 
then
sudo rm /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.lst
else
echo ""
fi

sudo cat /etc/piholeparser/lists/*.lst | sort > /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.lst
printf "$magenta" "___________________________________________________________"
echo ""
