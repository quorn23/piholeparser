#!/bin/bash
## Comments #'s and !'s .'s

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

cat $BFILETEMP | sed '/\#\+/d; /\!\+/d; /^[.]/d' | grep -v '\^.' > $BTEMPFILE
