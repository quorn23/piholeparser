#!/bin/bash
## This will move deadlists back to the mainlist folder

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

for f in $KILLTHELISTALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
mv $f "$MAINLISTSDIR""$BASEFILENAME".lst
done
