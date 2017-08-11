#!/bin/bash
## This Generates a list of which blacklists don't use https

## Variables
script_dir=$(dirname $0)
STATICVARS="$script_dir"/../../scriptvars/staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi
if 
ls $NOHTTPSLISTS &> /dev/null; 
then
rm $NOHTTPSLISTS
printf "$red"   "Old https-less List Removed"
fi

## Start File Loop
## For Every .lst File
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

if 
ls $NOHTTPSLISTS &> /dev/null; 
then
:
else
echo "All Lists Use https." | tee --append $NOHTTPSLISTS &>/dev/null
fi
printf "$yellow"   "https-less List Recreated."

HOWMANYLISTSWITHOUTHTTPS=$(echo -e "`wc -l $NOHTTPSLISTS | cut -d " " -f 1`")
HOWMANYLISTSWITHOUTHTTPSB=$(expr $HOWMANYLISTSWITHOUTHTTPS - 1)
printf "$red"    "$HOWMANYLISTSWITHOUTHTTPSB Lists Do NOT Use HTTPS. See Log For Details."
