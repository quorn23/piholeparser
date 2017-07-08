#!/bin/bash
## This Recreates The Temporary Variables

CHECKME=$TEMPVARS
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi


echo "## Vars that we don't keep" | tee --append $TEMPVARS &>/dev/null

source $TEMPVARS
