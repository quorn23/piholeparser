#!/bin/bash
## This script Cleans up directories 
## mainly to avoid pushing excess files to Github

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

WHATITIS="Temporary 7zip File"
CHECKME=$COMPRESSEDTEMPSEVEN
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Temporary Tar File"
CHECKME=$COMPRESSEDTEMPTAR
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Temporary Text File"
CHECKME=$CLEANUPTEMP
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

## Clean parsed directory if using locally
if 
[ "$version" = "local" ]
then
sudo rm $ALLPARSEDALL
else
:
fi
