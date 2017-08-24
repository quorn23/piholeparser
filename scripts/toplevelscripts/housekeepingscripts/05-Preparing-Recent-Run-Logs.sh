#!/bin/bash
## This Recreates Recent Run Log

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

RECENTRUN="$HOUSEKEEPINGSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".log

CHECKME=$CLEANLOGS
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
echo ""

CHECKME=$CLEANLOGSB
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
echo ""

CHECKME=$CLEANLOGSC
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
echo ""

SCRIPTTEXT="Creating Main Recent Run Log."
timestamp=$(echo `date`)

if 
[[ -f $RECENTRUNA ]]
then
rm $RECENTRUNA
printf "$red" "Old Log Purged."
RECENTPURGED=true
fi

echo "## Running Housekeeping Tasks $timestamp" | tee --append $RECENTRUNA &>/dev/null
echo "### $SCRIPTTEXT $timestamp" | tee --append $RECENTRUNA &>/dev/null

if
[[ -n $RECENTPURGED ]]
then
echo "* Old Recent Run Log Purged." | tee --append $RECENTRUN &>/dev/null
fi
echo "* Recent Run Log Recreated." | tee --append $RECENTRUN &>/dev/null

if 
[[ -f $RECENTRUN ]] 
then
printf "$yellow" "Recent Run Log Recreated."
fi
