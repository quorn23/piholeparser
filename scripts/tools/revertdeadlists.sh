#!/bin/bash
## This will move deadlists back to the mainlist folder

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

for f in $KILLTHELISTALL
do
source /etc/piholeparser/scripts/scriptvars/dynamicvariables.var
mv $f $BMAINPARSELIST
done
