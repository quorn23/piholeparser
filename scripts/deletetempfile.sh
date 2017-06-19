#!/bin/bash
## This should be run alot, to make sure the temp file doesn't get screwed up

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

CHECKME=$TEMPCLEANUP
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
else
:
fi

CHECKME=$COMPRESSEDTEMPSEVEN
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
else
:
fi

CHECKME=$COMPRESSEDTEMPTAR
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
else
:
fi
