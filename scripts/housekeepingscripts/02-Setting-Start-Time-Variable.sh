#!/bin/bash
## Sets The Beginning Script Time

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var
source $TEMPVARS

timestamp=$(echo `date`)
STARTTIME="Script Started At $timestamp"
STARTIMEVAR=$(echo $STARTIME)
STARTTIMESTAMP=$(date +"%s")

echo "STARTTIME='"$STARTTIME"'" | tee --append $TEMPVARS &>/dev/null
echo "STARTTIMESTAMP=$STARTTIMESTAMP" | tee --append $TEMPVARS &>/dev/null

printf "$yellow" "$STARTTIME"
