#!/bin/bash
## This should whitelist all domains that will be parsed

## Variables
source /etc/piholeparser/scriptvars/variables.var

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Whitelisting Domains that will be parsed."
printf "$red"   "Note: this does not actually work,, but it's a future planned addition."
echo ""

## Start File Loop
for f in $ALLOFTHEDOMAINS
do
for source in `cat $f`;
do

## Set Variables (again, I guess)
source /etc/piholeparser/scriptvars/variables.var

## add to whitelist file
sudo echo "$UPCHECK" | sudo tee --append $WHITELIST &>/dev/null

## end of loops
done
done

## undupe and sort
sort -u $WHITELIST > $WHITELISTPOST
sudo rm $WHITELIST
sudo sed 's/^ *//; s/ *$//; /^$/d; /^\s*$/d' $WHITELISTPOST > $WHITELIST
echo -e "\t`wc -l $WHITELIST | cut -d " " -f 1` domains to whitelist"
sudo rm $WHITELISTPOST

## Whitelist the domains
#for source in `cat $WHITELIST`;
#do
#pihole -w $source &>/dev/null
#done

timestamp=`date`
sudo echo "Whitelist script ran $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

printf "$magenta" "___________________________________________________________"
echo ""
