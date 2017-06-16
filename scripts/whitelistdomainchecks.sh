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
timestamp=$(echo `date`)
sudo echo "## Whitelisting Script $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

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
sort -u $LISTWHITELISTDOMAINS > $TEMPFILE
sudo rm $LISTWHITELISTDOMAINS
sudo gawk '{if (++dup[$0] == 1) print $0;}' $TEMPFILE > $LISTWHITELISTDOMAINS
sudo rm $TEMPFILE

timestamp=$(echo `date`)
HOWMANYLISTS=$(echo -e "\t`wc -l $LISTWHITELISTDOMAINS | cut -d " " -f 1` unique domains.")
sudo echo "$HOWMANYLISTS"
sudo echo "* $HOWMANYLISTS $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

## Whitelist the domains
#for source in `cat $LISTWHITELISTDOMAINS`;
#do
#pihole -w $source &>/dev/null
#done

###########################
## Whitelist sort dedupe ##
###########################

## dbb whites
sudo cat -s $DBBWHITES | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo mv $TEMPFILE $DBBWHITES

## user complaints
sudo cat -s $BLOCKEDCOMPLAINTS | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
sudo mv $TEMPFILE $BLOCKEDCOMPLAINTS

timestamp=$(echo `date`)
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null

printf "$magenta" "___________________________________________________________"
echo ""
