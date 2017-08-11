#!/bin/bash
## Remove TempWhites

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

CHECKME=$WHITELISTTEMP
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
