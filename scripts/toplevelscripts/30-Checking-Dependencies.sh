#!/bin/bash
## This is where any script dependencies will go.
## It checks if it is installed, and if not,
## it installs the program

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

## Start File Loop
## For .dependency files In The dependencies Directory
for f in $DEPENDENCIESALL
do

## Declare File Name
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
echo ""
printf "$cyan"  "Checking For $BASEFILENAME"

## Shouldn't be more than one source here
source=`cat $f`
timestamp=$(echo `date`)

if
which $BASEFILENAME >/dev/null;
then
printf "$yellow"  "$BASEFILENAME Is Already Installed."
else
printf "$yellow"  "Installing $BASEFILENAME"
apt-get install -y $source
fi

done
