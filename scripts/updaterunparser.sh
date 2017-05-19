#!/bin/bash

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scripts/colors.var

## Make sure we are in the correct directory
cd /etc/piholeparser

## Pull new lists on github
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Updating Repository."
sudo git pull
printf "$magenta" "___________________________________________________________"
echo ""

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Checking Run Script to see if Outdated."
if 
cmp -s /etc/piholeparser/scripts/runpiholeparser.sh /etc/runpiholeparser.sh
then
printf "$green"   "runparser is up to date!"
else
printf "$red"   "runparser is outdated"
sudo rm /etc/runpiholeparser.sh
sudo cp /etc/piholeparser/scripts/runpiholeparser.sh /etc/runpiholeparser.sh
fi
printf "$magenta" "___________________________________________________________"
echo ""

## RunParser
sudo bash /etc/runpiholeparser.sh
