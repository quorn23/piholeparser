#!/bin/bash
## Content Filtering and IP addresses

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

cat $BFILETEMP | sed '/^https\?:\/\//d; /third-party$/d; /popup$/d; s/^PRIMARY\s\+[ \t]*//; s/^localhost\s\+[ \t]*//; s/blockeddomain.hosts\s\+[ \t]*//; s/^0.0.0.0\s\+[ \t]*//; s/^127.0.0.1\s\+[ \t]*//; s/^::1\s\+[ \t]*//' > $BTEMPFILE
