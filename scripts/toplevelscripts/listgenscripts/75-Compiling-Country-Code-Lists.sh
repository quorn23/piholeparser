#!/bin/bash
## This spits out lists based on country codes

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

RECENTRUN="$LISTGENSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

## Process Every .clist file within CountryCode List Directory
for f in $EVERYCCTLD
do

# Dynamic Variables
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
if
[[ -f $DYNOVARS ]]
then
source $DYNOVARS
else
echo "Dynamic Vars File Missing, Exiting."
exit
fi

for source in `cat $f`;
do

HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $BIGAPLE | wc -l`")

if
[[ "$HOWMANYTIMESTLD" != 0 ]]
then
cat $BIGAPLE | grep -e [.]$source\$ >> $TEMPFILEZ
touch $TEMPFILEZ
{ if
[[ -f $TEMPFILEZ ]]
then
HOWMANYTIMESTLDAFTER=$(echo -e "`grep -o [.]$source\$ $TEMPFILEZ | wc -l`")
printf "$yellow"  "$BASEFILENAME Has $HOWMANYTIMESTLDAFTER Domains Using ."$source""
fi }
fi

## End Source Loop
done

if
[[ -f $TEMPFILEZ ]]
then
touch $TEMPFILEZ
cat $TEMPFILEZ | sed 's/\s\+$//; /^$/d; /[[:blank:]]/d' > $TEMPFILEY
rm $TEMPFILEZ
fi

if
[[ ! -f $TEMPFILEY ]]
then
touch $TEMPFILEY
fi
HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEY | cut -d " " -f 1`")

if
[[ $HOWMANYLINES -gt 0 && -f $COUNTRYCODECOMPLETE ]]
then
rm $COUNTRYCODECOMPLETE
fi

if
[[ $HOWMANYLINES -gt 0 ]]
then
mv $TEMPFILEY $COUNTRYCODECOMPLETE
else
rm $TEMPFILEY
fi

## End File loop
done
