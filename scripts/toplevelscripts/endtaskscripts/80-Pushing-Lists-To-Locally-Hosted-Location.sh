#!/bin/bash
## Push to local location

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

RECENTRUN="$ENDTASKSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

WHATITIS="Localhost Web Directory"
CHECKME=$BIGAPLLOCALHOSTDIR
timestamp=$(echo `date`)
if
[[ -z $CHECKME ]]
then
echo "* $WHATITIS Not Set. Please Fix. $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "Local Host Web Directory Not Set."
exit
fi
if
ls $CHECKME &> /dev/null;
then
echo "* $WHATITIS Already there no need to mkdir. $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "* $WHATITIS Not There. Please Fix. $timestamp" | tee --append $RECENTRUN &>/dev/null
exit
fi

WHATITIS="Locally Hosted Biglist"
CHECKME=$BIGAPLLOCALHOST
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
echo "* $WHATITIS Removed. $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "* $WHATITIS Not Removed. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
## Copy it over
CHECKME=$BIGAPLELOCALHOST
if
ls $CHECKME &> /dev/null;
then
cp -p $BIGAPL $BIGAPLLOCALHOST
else
echo "* $WHATITIS Not Created. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Locally Hosted Biglist (Edited)"
CHECKME=$BIGAPLELOCALHOST
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
echo "* $WHATITIS Removed. $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "* $WHATITIS Not Removed. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
## Copy it over
CHECKME=$BIGAPLELOCALHOST
if
ls $CHECKME &> /dev/null;
then
cp -p $BIGAPLE $BIGAPLELOCALHOST
else
echo "* $WHATITIS Not Created. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
