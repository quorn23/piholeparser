#!/bin/bash
## Invalid TLD's

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

printf "$yellow"  "This Process Normally Takes Longer Than The Others."
HOWMANYVALIDTLD=$(echo -e "`wc -l $VALIDDOMAINTLD | cut -d " " -f 1`")

TLDPERCENTAGEMATH="0"

echo -ne "$TLDPERCENTAGEMATH \r"

for source in `cat $VALIDDOMAINTLD`;
do

WHATLINENUMBER=$(echo -e "`grep -n $source $VALIDDOMAINTLD | cut -d : -f 1`")
TLDPERCENTAGEMATH=$(awk "BEGIN { pc=100*${WHATLINENUMBER}/${HOWMANYVALIDTLD}; i=int(pc); print (pc-i<0.5)?i:i+1}" )

HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $BFILETEMP | wc -l`")
if
[[ "$HOWMANYTIMESTLD" != 0 ]]
then
cat $BFILETEMP | grep -e [.]$source\$ >> $BTEMPFILE
touch $BTEMPFILE
fi

echo -ne " \r"
echo -ne "$TLDPERCENTAGEMATH \r"

done

touch $BTEMPFILE
gawk 'NR==FNR{a[$0];next} !($0 in a)' $BTEMPFILE $BFILETEMP >> $TRYNACATCHFIlES
