#!/bin/bash
## Invalid TLD's

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var
source $TEMPVARS
source $DYNOVARS

printf "$yellow"  "This Process Normally Takes Longer Than The Others."
HOWMANYVALIDTLD=$(echo -e "`wc -l $VALIDDOMAINTLD | cut -d " " -f 1`")
for source in `cat $VALIDDOMAINTLD`;
do
HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $BFILETEMP | wc -l`")
WHATLINENUMBER=$(echo -e "`grep -n $source $VALIDDOMAINTLD | cut -d : -f 1`")
TLDPERCENTAGEMATHA=$(awk "BEGIN { pc=100*${WHATLINENUMBER}/${HOWMANYVALIDTLD}; i=int(pc); print (pc-i<0.5)?i:i+1}" &>/dev/null)
TLDPERCENTAGEMATH="70"
if
[[ "$HOWMANYTIMESTLD" != 0 ]]
then
cat $BFILETEMP | grep -e [.]$source\$ >> $BTEMPFILE
touch $BTEMPFILE
fi
echo -ne "Percent Done Is "$TLDPERCENTAGEMATH". Currently Scanning for ."$source" Domain. \r"
done
touch $BTEMPFILE
gawk 'NR==FNR{a[$0];next} !($0 in a)' $BTEMPFILE $BFILETEMP >> $TRYNACATCHFIlES
