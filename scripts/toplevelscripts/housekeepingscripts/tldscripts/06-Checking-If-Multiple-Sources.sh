#!/bin/bash
##

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

## Amount of sources greater than one?
HOWMANYLINES=$(echo -e "`wc -l $FILEBEINGPROCESSED | cut -d " " -f 1`")
if
[[ "$HOWMANYLINES" -gt 1 ]]
then
printf "$yellow"    "$BASEFILENAME Has $HOWMANYLINES Sources."
fi
