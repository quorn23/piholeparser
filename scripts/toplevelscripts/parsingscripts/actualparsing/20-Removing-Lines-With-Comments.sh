#!/bin/bash
## Comments #'s and !'s .'s

## Variables
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

cat $TEMPFILEL | sed '/\#\+/d; /\!\+/d; /^[.]/d' | grep -v '\^.' > $TEMPFILEM
