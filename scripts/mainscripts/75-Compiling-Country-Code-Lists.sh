#!/bin/bash
## This spits out lists based on country codes

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../scriptvars/staticvariables.var

## Process Every .clist file within CountryCode List Directory
for f in $EVERYCCTLD
do

## These Variables are to help with Filenaming
source $DYNOVARS

for source in `cat $f`;
do

HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $BIGAPLE | wc -l`")

if
[[ "$HOWMANYTIMESTLD" != 0 ]]
then
cat $BFILETEMP | grep -e [.]$source\$ >> $TEMPFILEZ
touch $BTEMPFILE
HOWMANYTIMESTLDAFTER=$(echo -e "`grep -o [.]$source\$ $TEMPFILEZ | wc -l`")
printf "$yellow"  "$HOWMANYTIMESTLDAFTER Domains Using ."$source""
fi

## End Source Loop
done

cat $TEMPFILEZ | sed 's/\s\+$//; /^$/d; /[[:blank:]]/d' > $TEMPFILEY
rm $TEMPFILEZ
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
