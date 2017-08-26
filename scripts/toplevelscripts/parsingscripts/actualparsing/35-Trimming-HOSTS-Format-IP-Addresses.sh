#!/bin/bash
## Content Filtering and IP addresses

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../../../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi
if
[[ -f $TEMPPARSEVARS ]]
then
source $TEMPPARSEVARS
else
echo "Temp Parsing Vars File Missing, Exiting."
exit
fi

if
[[ -f $BFILETEMP ]]
then
cat $BFILETEMP | sed 's/^PRIMARY\s\+[ \t]*//; s/^localhost\s\+[ \t]*//; s/blockeddomain.hosts\s\+[ \t]*//; s/^0.0.0.0\s\+[ \t]*//; s/^127.0.0.1\s\+[ \t]*//; s/^::1\s\+[ \t]*//' > $BTEMPFILE
fi

if
[[ -f $BFILETEMP ]]
then
rm $BFILETEMP
fi
