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

## RunParser
sudo bash /etc/piholeparser/scripts/runpiholeparser.sh
