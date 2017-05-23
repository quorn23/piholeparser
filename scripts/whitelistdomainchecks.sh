#!/bin/bash
## This should whitelist all domains that will be parsed

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scripts/colors.var

if 
ls /etc/piholeparser/whitelisted/*.domains &> /dev/null; 
then
sudo rm /etc/piholeparser/whitelisted/*.domains
else
:
fi

## Set File Directory
FILES=/etc/piholeparser/lists/*.lst

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Whitelisting Domains that will be parsed."
echo ""

## Start File Loop
for f in $FILES
do
for source in `cat $f`;
do

## Filter domain name
UPCHECK=`echo $source | awk -F/ '{print $3}'`

## add to whitelist file
sudo echo "$UPCHECK" | sudo tee --append /etc/piholeparser/whitelisted/whitelist.domains &>/dev/null

## end of loops
done
done

## sources that are compressed
sudo echo "rlwpx.free.fr" | sudo tee --append /etc/piholeparser/whitelisted/whitelist.domains &>/dev/null
sudo echo "github.com" | sudo tee --append /etc/piholeparser/whitelisted/whitelist.domains &>/dev/null

## undupe and sort
sort -u /etc/piholeparser/whitelisted/whitelist.domains > /etc/piholeparser/whitelisted/whitelist2.domains
sudo cat /etc/piholeparser/whitelisted/whitelist2.domains >> /etc/piholeparser/whitelisted/whitelist3.domains
sudo cat /etc/piholeparser/whitelisted/whitelist3.domains | sort > /etc/piholeparser/whitelisted/whitelist4.domains
sed 's/^ *//; s/ *$//; /^$/d; /^\s*$/d' /etc/piholeparser/whitelisted/whitelist4.domains > /etc/piholeparser/whitelisted/whitelisted.domains
echo -e "\t`wc -l /etc/piholeparser/whitelisted/whitelisted.domains | cut -d " " -f 1` domains to whitelist"
sudo rm /etc/piholeparser/whitelisted/whitelist.domains
sudo rm /etc/piholeparser/whitelisted/whitelist2.domains
sudo rm /etc/piholeparser/whitelisted/whitelist3.domains
sudo rm /etc/piholeparser/whitelisted/whitelist4.domains

## Whitelist the domains
for source in `cat /etc/piholeparser/whitelisted/whitelisted.domains`;
do
pihole -w $source &>/dev/null
done


printf "$magenta" "___________________________________________________________"
echo ""
