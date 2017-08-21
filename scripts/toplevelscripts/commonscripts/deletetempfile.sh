#!/bin/bash
## This should be run alot, to make sure the temp folder doesn't get screwed up

## Variables
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/scriptvars/
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
[[ -f $TEMPCLEANUP ]]
then
rm $TEMPCLEANUP
echo ""
fi

if
[[ -f $COMPRESSEDTEMPSEVEN ]]
then
rm $COMPRESSEDTEMPSEVEN
echo ""
fi

if
[[ -f $COMPRESSEDTEMPTAR ]]
then
rm $COMPRESSEDTEMPTAR
echo ""
fi
