#!/bin/bash
## Duplicate Removal

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

cat -s $TEMPFILEL | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILEM
