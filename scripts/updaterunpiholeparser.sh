#!/bin/bash
## This script resides outside of the main directory 
## for the purpose of updating without worrying about being overwritten
##
## This File will not be updated often.

## Variables
source /etc/piholeparser/scriptvars/variables.var

timestamp=$(echo `date`)
sudo echo "## Starting Script $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

## Pull new lists on github
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Updating Repository."
sudo git -C /etc/piholeparser/ pull
printf "$magenta" "___________________________________________________________"
echo ""

## RunParser
sudo bash /etc/piholeparser/scripts/runpiholeparser.sh
