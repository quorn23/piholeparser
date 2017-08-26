#!/bin/bash
## This is where any script dependencies will go.
## It checks if it is installed, and if not,
## it installs the program

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
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

RECENTRUN="$TOPLEVELLOGSDIR""$SCRIPTBASEFILENAME".log

## Start File Loop
## For .dependency files In The dependencies Directory
for f in $DEPENDENCIESALL
do

## Declare File Name
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
echo ""
printf "$cyan"  "Checking For $BASEFILENAME"
echo "### $BASEFILENAME $timestamp" | tee --append $RECENTRUN &>/dev/null

## Shouldn't be more than one source here
source=`cat $f`
timestamp=$(echo `date`)

if
which $BASEFILENAME >/dev/null;
then
printf "$yellow"  "$BASEFILENAME Is Already Installed."
echo "$BASEFILENAME Already Installed $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "Installing $BASEFILENAME $timestamp" | tee --append $RECENTRUN &>/dev/null
printf "$yellow"  "Installing $BASEFILENAME"
apt-get install -y $source
fi

if
which $BASEFILENAME >/dev/null;
then
:
else
echo "Error Installing $BASEFILENAME $timestamp" | tee --append $RECENTRUN &>/dev/null
printf "$red"  "Error Installing $BASEFILENAME"
fi

done
