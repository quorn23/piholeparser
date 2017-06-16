#!/bin/bash
## This script pushes lists to localhost,

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

WHATITIS="web host lists directory"
CHECKME=$BIGAPLLOCALHOSTDIR
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo echo "* $WHATITIS Already there no need to mkdir. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo mkdir $CHECKME
sudo echo "* $WHATITIS Created. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

## Copy it over
sudo cp -p $BIGAPL $BIGAPLLOCALHOST
