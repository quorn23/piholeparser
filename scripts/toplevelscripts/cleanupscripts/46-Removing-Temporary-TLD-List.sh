#!/bin/bash
## Remove Temp TLD

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

CHECKME=$VALIDDOMAINTLD
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
