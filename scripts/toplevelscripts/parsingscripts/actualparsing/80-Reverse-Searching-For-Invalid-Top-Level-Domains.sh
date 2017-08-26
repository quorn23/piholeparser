#!/bin/bash
## Invalid TLD's

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

printf "$yellow"  "This Process Normally Takes Longer Than The Others."

HOWMANYVALIDTLD=$(echo -e "`wc -l $VALIDDOMAINTLDBKUP | cut -d " " -f 1`")

for source in `cat $VALIDDOMAINTLD`;
do


WHATLINENUMBER=$(echo "`grep -n $source $VALIDDOMAINTLD | cut -d : -f 1`")
TLDPERCENTAGEMATH=$(echo `awk "BEGIN { pc=100*${WHATLINENUMBER}/${HOWMANYVALIDTLD}; i=int(pc); print (pc-i<0.5)?i:i+1}"`)

HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $BFILETEMP | wc -l`")
if
[[ "$HOWMANYTIMESTLD" != 0 ]]
then
cat $BFILETEMP | grep -e [.]$source\$ >> $BTEMPFILE
fi

echo -ne "$TLDPERCENTAGEMATH \r"

done

if
[[ ! -f $BTEMPFILE ]]
then
touch $BTEMPFILE
fi

## What doesn't make it through
if
[[ -f $TRYNACATCHFIlES ]]
then
rm $TRYNACATCHFIlES
fi

gawk 'NR==FNR{a[$0];next} !($0 in a)' $BTEMPFILE $BFILETEMP >> $TRYNACATCHFIlES
