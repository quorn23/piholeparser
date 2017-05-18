#!/bin/bash

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Rebuilding the complete list file."
sudo rm /etc/piholeparser/1111ALLPARSEDLISTS1111.lst
sudo cat /etc/piholeparser/lists/*.lst | sort > /etc/piholeparser/1111ALLPARSEDLISTS1111.lst
printf "$magenta" "___________________________________________________________"
echo ""
