#!/bin/bash
## This should be run alot, to make sure the temp file doesn't get screwed up

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

WHATITIS="Temporary txt Files"
CHECKME=$TEMPCLEANUP
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
else
:
fi

WHATITIS="Temporary 7zip File"
CHECKME=$COMPRESSEDTEMPSEVEN
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
else
:
fi

WHATITIS="Temporary Tar File"
CHECKME=$COMPRESSEDTEMPTAR
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
else
:
fi
