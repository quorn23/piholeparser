#!/bin/bash
## This trims off the "white" domains

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## Big Source     ##
####################

## add all sources
timestamp=$(echo `date`)
sudo cat $EVERYLISTFILEWILDCARD | sort > $TEMPFILE
HOWMANYLISTS=$(echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1` lists processed by the script.")
sudo echo "$HOWMANYLISTS"
sudo echo "* $HOWMANYLISTS $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo sed '/^$/d' $TEMPFILE > $FILETEMP
sudo mv $FILETEMP $BIGAPLSOURCE
