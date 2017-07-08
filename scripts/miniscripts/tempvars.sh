#!/bin/bash
## This Recreates The Temporary Variables

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

CHECKME=$TEMPVARS
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

echo "## Vars that we don't keep" | tee --append $TEMPVARS &>/dev/null
