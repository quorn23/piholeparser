#!/bin/bash
## This should whitelist domains that people complain are getting blocked
## within reason

## Variables
source /etc/piholeparser/scriptvars/variables.var

sudo cp $BIGAPL $BIGAPLE

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   ""
echo ""

## Start File Loop
for source in `cat $BDC`;
do

## cut domains out
sudo sed '/$source/d' $BIGAPLE > $TEMPAPLE
sudo rm $BIGAPLE
sudo mv $TEMPAPLE $BIGAPLE

## end of loops
done

printf "$magenta" "___________________________________________________________"
echo ""
