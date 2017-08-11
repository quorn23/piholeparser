#!/bin/bash
## Domain Requirements,, a period and a letter

## Variables
script_dir=$(dirname $0)
STATICVARS="$script_dir"/../../scriptvars/staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi
if
[[ -f $TEMPVARS ]]
then
source $TEMPVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi
if
[[ -f $DYNOVARS ]]
then
source $DYNOVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi

cat $TEMPFILEL | sed '/[a-z]/!d; /[.]/!d; /[a-z]$/!d; /^[.]/d' | grep -v '\^.' > $TEMPFILEM
