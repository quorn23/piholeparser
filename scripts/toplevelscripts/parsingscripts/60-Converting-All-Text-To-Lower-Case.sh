#!/bin/bash
## Convert All Text To Lower Case

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

cat $TEMPFILEL | sed 's/\([A-Z]\)/\L\1/g' > $TEMPFILEM
