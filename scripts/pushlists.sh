#!/bin/bash
## This script pushes lists to Github if selected in var

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

## Push Changes up to Github
{ if 
[ "$version" = "github" ]
then
printf "$green"   "Pushing Lists to Github"
timestamp=$(echo `date`)
git -C $REPODIR remote set-url origin $GITWHERETOPUSH
git -C $REPODIR add .
git -C $REPODIR commit -m "Update lists $timestamp"
git -C $REPODIR push -u origin master
elif
[ "$version" = "local" ]
then
printf "$red"   "Not Pushing Lists to Github"
fi }

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
cp -p $BIGAPL $BIGAPLELOCALHOST
