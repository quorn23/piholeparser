#!/bin/bash
##

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../../../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi
if
[[ -f $TEMPPARSEVARS ]]
then
source $TEMPPARSEVARS
else
echo "Temp Parsing Vars File Missing, Exiting."
exit
fi

## Download URL
source="$(echo `cat $FILEBEINGPROCESSED`)"
echo "source="$source"" | tee --append $TEMPPARSEVARS &>/dev/null

## This extracts the domain from source
SOURCEDOMAIN=`echo $source | awk -F/ '{print $3}'`
echo "SOURCEDOMAIN="$SOURCEDOMAIN"" | tee --append $TEMPPARSEVARS &>/dev/null

## Local List
CURRENTTLDLIST="$TLDMLISTSDIR""$BASEFILENAME".txt
echo "CURRENTTLDLIST="$CURRENTTLDLIST"" | tee --append $TEMPPARSEVARS &>/dev/null

## Temps
BTEMPFILE="$TEMPDIR""$BASEFILENAME".tempfile.txt
echo "BTEMPFILE="$BTEMPFILE"" | tee --append $TEMPPARSEVARS &>/dev/null
BFILETEMP="$TEMPDIR""$BASEFILENAME".filetemp.txt
echo "BFILETEMP="$BFILETEMP"" | tee --append $TEMPPARSEVARS &>/dev/null
BORIGINALFILETEMP="$TEMPDIR""$BASEFILENAME".original.txt
echo "BORIGINALFILETEMP="$BORIGINALFILETEMP"" | tee --append $TEMPPARSEVARS &>/dev/null
