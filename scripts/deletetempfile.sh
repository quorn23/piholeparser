#!/bin/bash
## This should be run alot, to make sure the temp file doesn't get screwed up

## Variables
script_dir=$(dirname $0)
STATICVARS="$script_dir"/scriptvars/staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

CHECKME=$TEMPCLEANUP
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
echo ""
fi

CHECKME=$COMPRESSEDTEMPSEVEN
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
echo ""
fi

CHECKME=$COMPRESSEDTEMPTAR
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
echo ""
fi
