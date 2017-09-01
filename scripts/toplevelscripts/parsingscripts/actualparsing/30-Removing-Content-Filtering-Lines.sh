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
cat $BFILETEMP | sed '/^https\?:\/\//d; /^http\?:\/\//d; s/third-party$//g; s/popup$//g; s/important$//g; s/subdocument$//g; s/websocket$//g; s/^||//; s/[\^]$//g' > $BTEMPFILE
fi

if
[[ -f $BFILETEMP ]]
then
rm $BFILETEMP
fi
