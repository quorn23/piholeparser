#!/bin/bash
## Push to local location

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

WHATITIS="web host lists directory"
CHECKME=$BIGAPLLOCALHOSTDIR
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
echo "* $WHATITIS Already there no need to mkdir. $timestamp" | tee --append $RECENTRUN &>/dev/null
else
mkdir $CHECKME
echo "* $WHATITIS Created. $timestamp" | tee --append $RECENTRUN &>/dev/null
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
cp -p $BIGAPL $BIGAPLLOCALHOST
cp -p $BIGAPLE $BIGAPLELOCALHOST
