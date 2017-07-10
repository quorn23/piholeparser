#!/bin/bash
## This Generates a list of which blacklists don't use https

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

if 
ls $NOHTTPSLISTS &> /dev/null; 
then
rm $NOHTTPSLISTS
fi

echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null

for f in $EVERYLISTFILEWILDCARD
do

BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)

for source in `cat $f`;
do

if
[[ $source != https* ]]
then
echo "* $BASEFILENAME" | tee --append $NOHTTPSLISTS &>/dev/null
fi

## End Source Loop
done

## End File Loop
done

HOWMANYLISTSWITHOUTHTTPS=$(echo -e "`wc -l $NOHTTPSLISTS | cut -d " " -f 1`")
HOWMANYLISTSWITHOUTHTTPSB=$(expr $HOWMANYLISTSWITHOUTHTTPS - 1)
printf "$red"    "$HOWMANYLISTSWITHOUTHTTPSB Lists Do NOT Use HTTPS."
