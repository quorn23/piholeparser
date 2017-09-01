#!/bin/bash
## is the file available?

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
if
[[ -f $TEMPPARSEVARS ]]
then
source $TEMPPARSEVARS
else
echo "Temp Parsing Vars File Missing, Exiting."
exit
fi

## host unavailable
if
[[ -n $TESTPINGFAILED && -n $TESTCURLHEADERFAILED && -n $TESTWGETHEADERFAILED ]]
then
printf "$red"  "Host Unavailable."
PINGTESTFAILED=true
echo "PINGTESTFAILED="$PINGTESTFAILED"" | tee --append $TEMPPARSEVARS &>/dev/null
else
printf "$green"  "Host Available."
fi

## Dead List?
timestamp=$(echo `date`)
if
[[ -n $PINGTESTFAILED && $FILEBEINGPROCESSED != $BDEADPARSELIST ]]
then
printf "$red"  "List Marked As Dead."
echo "* $BASEFILENAME List Marked As Dead. $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $FILEBEINGPROCESSED $BDEADPARSELIST
elif
[[ -n $PINGTESTFAILED && $FILEBEINGPROCESSED == $BDEADPARSELIST ]]
then
printf "$red"  "List Already Marked As Dead."
echo "* $BASEFILENAME List Already Marked As Dead. $timestamp" | tee --append $RECENTRUN &>/dev/null
elif
[[ -z $PINGTESTFAILED && $FILEBEINGPROCESSED == $BDEADPARSELIST ]]
then
printf "$green"  "List Was Marked As Dead, But Now Works."
UNDEADLIST=true
echo "UNDEADLIST="$UNDEADLIST"" | tee --append $TEMPPARSEVARS &>/dev/null
echo "* $BASEFILENAME List Unavailable To Download. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
