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

## Process Every source within the .lst from above
for source in `cat $FILEBEINGPROCESSED`;
do

UPCHECK=`echo $source | awk -F/ '{print $3}'`
echo "UPCHECK="$UPCHECK"" | tee --append $TEMPPARSEVARS &>/dev/null

## Check to see if source's host is online
if
[[ -n $UPCHECK ]]
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
echo "SOURCEIP="$SOURCEIP"" | tee --append $TEMPPARSEVARS &>/dev/null
elif
[[ -z $UPCHECK ]]
then
printf "$red"    "$BASEFILENAME Host Unavailable."
fi

if
[[ -n $SOURCEIP ]]
then
printf "$green"    "Ping Test Was A Success!"
PINGTEST=success
elif
[[ -z $SOURCEIP ]]
then
printf "$red"    "Ping Test Failed."
PINGTEST=fail
fi
echo ""
echo "PINGTEST="$PINGTEST"" | tee --append $TEMPPARSEVARS &>/dev/null

done
