#!/bin/bash
## This Recreates Recent Run Log

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../scriptvars/staticvariables.var

SCRIPTTEXT="Creating Main Recent Run Log."
timestamp=$(echo `date`)

if 
ls $RECENTRUN &> /dev/null; 
then
rm $RECENTRUN
printf "$red" "Old Log Purged."
fi

echo "### $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "* Recent Run Log Recreated." | tee --append $RECENTRUN &>/dev/null

if 
ls $RECENTRUN &> /dev/null; 
then
printf "$yellow" "Recent Run Log Recreated."
fi
