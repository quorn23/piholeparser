#!/bin/bash
## Pinging Host

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

## If $SOURCEDOMAIN is set, Ping it
if
[[  -n $SOURCEDOMAIN && `ping -c 1 $SOURCEDOMAIN | gawk -F'[()]' '/PING/{print $2}'` ]]
then
printf "$green"    "Ping Test Was A Success!"
SOURCEIPFETCH=`ping -c 1 $SOURCEDOMAIN | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
echo "SOURCEIP="$SOURCEIP"" | tee --append $TEMPPARSEVARS &>/dev/null
else
printf "$red"    "Ping Test Failed."
SOURCEIP="unknown"
echo "SOURCEIP="$SOURCEIP"" | tee --append $TEMPPARSEVARS &>/dev/null
TESTPINGFAILED=true
fi

## curl Header
if
[[ `curl -s -H "$AGENTDOWNLOAD" -o /dev/null -I -w "%{http_code}" $source | grep '200'` ]]
then
printf "$green"  "Curl Header Check Successful."
else
printf "$red"  "Curl Header Check Unsuccessful."
TESTCURLHEADERFAILED=true
fi

## wget header
if
[[ `wget -S --header="$WGETAGENTDOWNLOAD" --spider $source  2>&1 | grep 'HTTP/1.1 200 OK'` ]]
then
printf "$green"  "Wget Header Check Successful."
else
printf "$red"  "Wget Header Check Unsuccessful."
TESTWGETHEADERFAILED=true
fi

## host unavailable
if
[[ -n $TESTPINGFAILED && -n $TESTCURLHEADERFAILED && -n $TESTWGETHEADERFAILED ]]
then
PINGTESTFAILED=true
echo "PINGTESTFAILED="$PINGTESTFAILED"" | tee --append $TEMPPARSEVARS &>/dev/null
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
