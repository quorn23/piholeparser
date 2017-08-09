#!/bin/bash
## ## Convert All Text To Lower Case

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

cat $TEMPFILEL | sed 's/\([A-Z]\)/\L\1/g' > $TEMPFILEM
