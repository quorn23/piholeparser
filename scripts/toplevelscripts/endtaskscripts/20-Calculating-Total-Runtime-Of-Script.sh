#!/bin/bash
## total runtime

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
[[ -f $TEMPVARS ]]
then
source $TEMPVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi

RECENTRUN="$ENDTASKSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

timestamp=$(echo `date`)
ENDTIME=$(echo `date`)
echo "ENDTIME='$timestamp'" | tee --append $TEMPVARS &>/dev/null

ENDTIMESTAMP=$(date +"%s")
DIFFTIMESEC=`expr $ENDTIMESTAMP - $STARTTIMESTAMP`
DIFFTIME=`expr $DIFFTIMESEC / 60`

TOTALRUNTIME=$DIFFTIME
echo "* $TOTALRUNTIME" | tee --append $RECENTRUN &>/dev/null
echo "TOTALRUNTIME='"$TOTALRUNTIME"'" | tee --append $TEMPVARS &>/dev/null

printf "$yellow"   "$TOTALRUNTIME"
