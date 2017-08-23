#!/bin/bash
## 

## Variables
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../../scriptvars/
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
[[ -f $MIRROREDFILE ]]
then
printf "$green"  "Mirror File Currently Available."
MIRRORFILEPRESENT=true
echo "MIRRORFILEPRESENT="$MIRRORFILEPRESENT"" | tee --append $TEMPPARSEVARS &>/dev/null
else
printf "$red"  "Mirror File Currently Unavailable."
fi
