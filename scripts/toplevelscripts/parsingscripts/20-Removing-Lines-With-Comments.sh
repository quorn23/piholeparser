#!/bin/bash
## Comments #'s and !'s .'s

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

cat $TEMPFILEL | sed '/\#\+/d; /\!\+/d; /^[.]/d' | grep -v '\^.' > $TEMPFILEM
