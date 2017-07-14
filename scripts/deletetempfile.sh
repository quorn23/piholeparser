#!/bin/bash
## This should be run alot, to make sure the temp file doesn't get screwed up

## Variables
script_dir=$(dirname $0)
source "$script_dir"/scriptvars/staticvariables.var

#printf "$lightblue"    "___________________________________________________________"
#echo ""

#printf "$cyan"    "Cleaning Up Temp Directory."
#echo ""

#printf "$green"    "All .temp Files Will Be Preserved."
#echo ""

CHECKME=$TEMPCLEANUP
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
#printf "$yellow"    "Temporary tar Files Removed."
echo ""
fi

CHECKME=$COMPRESSEDTEMPSEVEN
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
#printf "$yellow"    "Temporary tar Files Removed."
echo ""
fi

CHECKME=$COMPRESSEDTEMPTAR
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
#printf "$yellow"    "Temporary tar Files Removed."
echo ""
fi

#printf "$orange" "___________________________________________________________"
#echo ""
