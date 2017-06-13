#!/bin/bash
## This script pushes lists to localhost,
## and Github, if that's the version in the var file

## Variables
source /etc/piholeparser/scriptvars/variables.var


####################
## Big Source     ##
####################

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Rebuilding the Sources file."
echo ""

## add all sources
sudo cat /etc/piholeparser/lists/*/*.lst | sort > $BIGAPLSOURCE

## Remove Empty Lines
sudo sed '/^$/d' $BIGAPLSOURCE > $BIGAPLSOURCE2
sudo rm $BIGAPLSOURCE
sudo mv $BIGAPLSOURCE2 $BIGAPLSOURCE

timestamp=$(echo `date`)
HOWMANYLISTS=$(echo -e "\t`wc -l $BIGAPLSOURCE | cut -d " " -f 1` lists processed by the script.")
sudo echo "$HOWMANYLISTS"
sudo echo "$HOWMANYLISTS $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

printf "$magenta" "___________________________________________________________"
echo ""
