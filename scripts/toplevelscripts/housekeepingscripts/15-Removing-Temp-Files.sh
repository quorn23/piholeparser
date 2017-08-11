#!/bin/bash
## This Recreates Recent Run Log

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

CHECKME=$TEMPCLEANUPB
if
ls $CHECKME &> /dev/null;
then
printf "$red"   "Purging Old Temp Files."
rm $CHECKME
else
printf "$yellow"   "No Temp Files To Remove."
fi
