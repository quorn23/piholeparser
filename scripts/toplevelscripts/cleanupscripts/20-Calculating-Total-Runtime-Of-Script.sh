#!/bin/bash
## total runtime

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var
source $TEMPVARS

ENDTIME="Script Ended At $(echo `date`)"
ENDTIMESTAMP=$(date +"%s")
DIFFTIMESEC=`expr $ENDTIMESTAMP - $STARTTIMESTAMP`
DIFFTIME=`expr $DIFFTIMESEC / 60`
TOTALRUNTIME="Script Took $DIFFTIME minutes To Filter $HOWMANYSOURCELISTS Lists."

printf "$yellow"   "$TOTALRUNTIME"

echo "* $TOTALRUNTIME" | tee --append $RECENTRUN &>/dev/null

echo "ENDTIME='"$ENDTIME"'" | tee --append $TEMPVARS &>/dev/null
echo "TOTALRUNTIME='"$TOTALRUNTIME"'" | tee --append $TEMPVARS &>/dev/null
