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
sort -u $WHITELIST > $WHITELISTPOST
sudo rm $WHITELIST
sudo gawk '{if (++dup[$0] == 1) print $0;}' $WHITELISTPOST > $WHITELIST
#sudo sed 's/^ *//; s/ *$//; /^$/d; /^\s*$/d' $WHITELISTPOST > $WHITELIST
sudo rm $WHITELISTPOST

timestamp=$(echo `date`)
HOWMANYLISTS=$(echo -e "\t`wc -l $WHITELIST | cut -d " " -f 1` domains whitelisted")
sudo echo "$HOWMANYLISTS"
sudo echo "* $HOWMANYLISTS $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

## Whitelist the domains
#for source in `cat $WHITELIST`;
#do
#pihole -w $source &>/dev/null
#done

###########################
## Whitelist sort dedupe ##
###########################

## dbb whites
sort -u $DBBW > $DBBW2
sudo rm $DBBW
sudo mv $DBBW2 $DBBW
sudo gawk '{if (++dup[$0] == 1) print $0;}' $DBBW > $DBBW2
sudo rm $DBBW
sudo mv $DBBW2 $DBBW

## user complaints
sort -u $BDC > $BDC2
sudo rm $BDC
sudo mv $BDC2 $BDC
sudo gawk '{if (++dup[$0] == 1) print $0;}' $BDC > $BDC2
sudo rm $BDC
sudo mv $BDC2 $BDC


timestamp=$(echo `date`)
sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null

printf "$magenta" "___________________________________________________________"
echo ""
