#!/bin/bash

## Variables
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

echo "Reverting Killed Lists"
CHECKME=$BLACKLSTSTHATDIEALL
if
ls $CHECKME &> /dev/null;
then
for f in $BLACKLSTSTHATDIEALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
BUNDEADPARSELIST="$MAINBLACKLSTSDIR""$BASEFILENAME".lst
mv $f $BUNDEADPARSELIST
done
fi
echo ""
