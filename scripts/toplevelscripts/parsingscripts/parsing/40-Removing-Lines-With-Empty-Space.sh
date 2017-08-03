#!/bin/bash
## Empty Space

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

cat $BFILETEMP | sed 's/\s\+$//; /^$/d; /[[:blank:]]/d' > $BTEMPFILE
