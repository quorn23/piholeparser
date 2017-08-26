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

SCRIPTTEXT="Creating Main Recent Run Log."
timestamp=$(echo `date`)

echo "## $SCRIPTTEXT $timestamp" | tee --append $TEMPLOGMAIN &>/dev/null

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

if
[[ -f $RECENTRUNA ]]
then
echo "* Old Recent Run Log Purged." | tee --append $TEMPLOGMAIN &>/dev/null
rm $RECENTRUNA
fi

if
[[ -f $TEMPLOGMAIN ]]
then
echo "* Recent Run Log Recreated." | tee --append $TEMPLOGMAIN &>/dev/null
mv $TEMPLOGMAIN $RECENTRUNA
fi
