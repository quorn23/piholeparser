#!/bin/bash
## This should whitelist domains that people complain are getting blocked
## within reason

## Version
source /etc/piholeparser.var

## Variables
source /etc/piholeparser/scriptvars/variables.var

if 
ls /etc/piholeparser/whitelisted/*.domains &> /dev/null; 
then
sudo rm /etc/piholeparser/whitelisted/*.domains
else
:
fi

## Set File Directory
FILES=/etc/piholeparser/scriptvars/blockeddomaincomplaints.txt
TEMPLIST=/etc/piholeparser/parsedall/ALLPARSEDLISTSedited.txt
BIGLIST=/etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111edited.txt
ORIGBIGLIST=/etc/piholeparser/parsedall/1111ALLPARSEDLISTS1111.txt

sudo cp $ORIGBIGLIST $BIGLIST

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   ""
echo ""

## Start File Loop
for f in $FILES
do
for source in `cat $f`;
do

## stuff
sudo sed '/$source/d' $BIGLIST > $TEMPLIST
sudo rm $BIGLIST
sudo mv $TEMPLIST $BIGLIST

## end of loops
done
done

printf "$magenta" "___________________________________________________________"
echo ""
