#!/bin/bash
## This should be run alot, to make sure the temp folder doesn't get screwed up

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

RECENTRUN="$COMMONSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

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
