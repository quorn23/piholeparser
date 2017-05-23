#!/bin/bash
## This should whitelist all domains that will be parsed

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scripts/colors.var

if 
ls /etc/piholeparser/temp/whitelisted.domains &> /dev/null; 
then
sudo rm /etc/piholeparser/temp/whitelisted.domains
else
:
fi

## Set File Directory
FILES=/etc/piholeparser/lists/*.lst

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Whitelisting Domains that will be parsed."
printf "$green"   "Not: this is a work in progress and doesn't actually do it yet."
echo ""

## Start File Loop
for f in $FILES
do

for source in `cat $f`;
do

## Filter domain name
UPCHECK=`echo $source | awk -F/ '{print $3}'`

## add to temporary whitelist file
sudo echo "$UPCHECK" | sudo tee --append /etc/piholeparser/temp/whitelisted.domains &>/dev/null

## end of loops
done
done

## sources that are compressed
sudo echo "rlwpx.free.fr" | sudo tee --append /etc/piholeparser/temp/whitelisted.domains &>/dev/null
sudo echo "github.com" | sudo tee --append /etc/piholeparser/temp/whitelisted.domains &>/dev/null

printf "$magenta" "___________________________________________________________"
echo ""
