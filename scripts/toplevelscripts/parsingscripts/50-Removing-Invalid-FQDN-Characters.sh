#!/bin/bash
## Invalid Characters
## FQDN's  can only have . _ and -
## apparently you can have an emoji domain name?

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

cat $BFILETEMP | sed '/,/d; s/"/'\''/g; /\"\//d; /[+]/d; /[\]/d; /[/]/d; /[<]/d; /[>]/d; /[?]/d; /[*]/d; /[@]/d; /~/d; /[`]/d; /[=]/d; /[:]/d; /[;]/d; /[%]/d; /[&]/d; /[(]/d; /[)]/d; /[$]/d; /\[\//d; /\]\//d; /[{]/d; /[}]/d; /[][]/d; /\^\//d; s/^||//; /[|]/d' > $BTEMPFILE
