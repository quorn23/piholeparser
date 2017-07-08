#!/bin/bash
## This Generates a list of which blacklists don't use https

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

if 
ls $NOHTTPSLISTS &> /dev/null; 
then
rm $NOHTTPSLISTS
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

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
done
done
