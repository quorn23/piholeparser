#!/bin/bash
## total runtime

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

ENDTIME="Script Ended At $(echo `date`)"
ENDTIMESTAMP=$(date +"%s")
DIFFTIMESEC=`expr $ENDTIMESTAMP - $STARTTIMESTAMP`
DIFFTIME=`expr $DIFFTIMESEC / 60`
TOTALRUNTIME="Script Took $DIFFTIME minutes To Filter $HOWMANYSOURCELISTS Lists."

printf "$yellow"   "$TOTALRUNTIME"

echo "* $TOTALRUNTIME" | tee --append $RECENTRUN &>/dev/null

echo "ENDTIME='"$ENDTIME"'" | tee --append $TEMPVARS &>/dev/null
echo "TOTALRUNTIME='"$TOTALRUNTIME"'" | tee --append $TEMPVARS &>/dev/null
