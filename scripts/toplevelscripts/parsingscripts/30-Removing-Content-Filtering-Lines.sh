#!/bin/bash
## Content Filtering and IP addresses

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

cat $TEMPFILEL | sed '/^https\?:\/\//d; /^http\?:\/\//d; /third-party$/d; /popup$/d' > $BTEMPFILE
