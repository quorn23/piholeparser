#!/bin/bash
## This should whitelist all domains that will be parsed

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scripts/colors.var

## Set File Directory
FILES=/etc/piholeparser/lists/*.lst

## Start File Loop
for f in $FILES
do

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Whitelisting list from $f"
echo ""

for source in `cat $f`;
do
echo ""
printf "$cyan"    "$source"
echo "" 

## Filter domain name
UPCHECK=`echo $source | awk -F/ '{print $3}'`

## pihole -w
printf "$yellow"    "Whitelisting $UPCHECK in pihole"
pihole -w $UPCHECK
echo ""

done
