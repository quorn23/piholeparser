#!/bin/bash
## Domain Requirements,, a period and a letter

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

cat $BFILETEMP | sed '/[a-z]/!d; /[.]/!d; /[a-z]$/!d; /^[.]/d' | grep -v '\^.' > $BTEMPFILE
