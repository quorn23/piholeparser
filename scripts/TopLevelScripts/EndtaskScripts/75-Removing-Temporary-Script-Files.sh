#!/bin/bash
## Remove TempVars

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/foldervars.var

CHECKME=$TEMPVARS
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi


CHECKME=$TEMPCLEANUP
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

CHECKME=$TEMPCLEANUPB
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

CHECKME=$TEMPCLEANUPC
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
