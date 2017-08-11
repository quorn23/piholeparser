#!/bin/bash
## Invalid TLD's

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

HOWMANYVALIDTLD=$(echo -e "`wc -l $VALIDDOMAINTLDBKUP | cut -d " " -f 1`")

printf "$yellow"  "This Process Normally Takes Longer Than The Others."

TLDPERCENTAGEMATH="0"

echo -ne "$TLDPERCENTAGEMATH \r"

for source in `cat $VALIDDOMAINTLD`;
do

WHATLINENUMBER=$(echo -e "`grep -n $source $VALIDDOMAINTLD | cut -d : -f 1`")
TLDPERCENTAGEMATH=$(awk "BEGIN { pc=100*${WHATLINENUMBER}/${HOWMANYVALIDTLD}; i=int(pc); print (pc-i<0.5)?i:i+1}" )

HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $TEMPFILEL | wc -l`")
if
[[ "$HOWMANYTIMESTLD" != 0 ]]
then
cat $TEMPFILEL | grep -e [.]$source\$ >> $TEMPFILEM
touch $TEMPFILEM
fi

echo -ne "$TLDPERCENTAGEMATH \r"

done

touch $TEMPFILEM
gawk 'NR==FNR{a[$0];next} !($0 in a)' $TEMPFILEM $TEMPFILEL >> $TRYNACATCHFIlES
