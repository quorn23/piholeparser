#!/bin/bash
## This Recreates Recent Run Log

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var
source $TEMPVARS

SCRIPTTEXT="Recreating Recent Run Log."
timestamp=$(echo `date`)

if 
ls $RECENTRUN &> /dev/null; 
then
rm $RECENTRUN
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "* Recent Run Log Removed and Recreated." | tee --append $RECENTRUN &>/dev/null
else
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "* Recent Run Log Created." | tee --append $RECENTRUN &>/dev/null
fi

echo "* $STARTTIME" | tee --append $RECENTRUN &>/dev/null
