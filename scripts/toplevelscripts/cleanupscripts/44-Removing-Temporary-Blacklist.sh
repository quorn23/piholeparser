#!/bin/bash
## Remove TempBlacks

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

CHECKME=$BLACKLISTTEMP
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
