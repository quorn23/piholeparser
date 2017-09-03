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

## whiptail required
WHATITIS=whiptail
WHATPACKAGE=whiptail
if
which $WHATITIS >/dev/null;
then
:
else
printf "$yellow"  "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
fi

for f in $BLACKLSTSTHATDIEALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
BUNDEADPARSELIST="$MAINBLACKLSTSDIR""$BASEFILENAME".lst
mv $f $BUNDEADPARSELIST
done
