#!/bin/bash
## Valid Domains

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/foldervars.var

printf "$yellow"  "This Process Normally Takes Longer Than The Others."

for source in `cat $BFILETEMP`;
do
SOURCEIPFETCH=`ping -c 1 $DOMAINONE | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
if
[[ -n $SOURCEIP ]]
then
echo "$source" | tee --append $BTEMPFILE &>/dev/null
fi
done

if
[[ -f $BFILETEMP ]]
then
rm $BFILETEMP
fi
