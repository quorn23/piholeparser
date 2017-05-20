#!/bin/bash
## This is the Parsing Process

## Colors
source /etc/piholeparser/scripts/colors.var

echo ""
echo "Creating Single Big List."

sudo cat /etc/piholeparser/parsed/*.txt | sort > /etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.txt
printf "$magenta" "___________________________________________________________"
echo ""
