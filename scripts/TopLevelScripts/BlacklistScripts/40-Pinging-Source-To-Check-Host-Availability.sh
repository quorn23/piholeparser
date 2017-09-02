#!/bin/bash
## Pinging Host

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
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

## If $SOURCEDOMAIN is set, Ping it
if
[[  -n $SOURCEDOMAIN && `ping -c 1 $SOURCEDOMAIN | gawk -F'[()]' '/PING/{print $2}'` ]]
then
printf "$green"    "Ping Test Was A Success!"
SOURCEIPFETCH=`ping -c 1 $SOURCEDOMAIN | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
echo "SOURCEIP="$SOURCEIP"" | tee --append $TEMPPARSEVARS &>/dev/null
else
printf "$red"    "Ping Test Failed."
SOURCEIP="unknown"
echo "SOURCEIP="$SOURCEIP"" | tee --append $TEMPPARSEVARS &>/dev/null
TESTPINGFAILED=true
echo "TESTPINGFAILED="$TESTPINGFAILED"" | tee --append $TEMPPARSEVARS &>/dev/null
fi
