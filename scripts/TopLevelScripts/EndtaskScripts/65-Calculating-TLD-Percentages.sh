#!/bin/bash
## TLD Percentages

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
[[ -f $TEMPVARS ]]
then
source $TEMPVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi

RECENTRUN="$ENDTASKSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

BIGAPLHOWMANY=$(echo -e "`wc -l $BIGAPL | cut -d " " -f 1`")
HOWMANYVALIDTLD=$(echo -e "`wc -l $VALIDDOMAINTLDBKUP | cut -d " " -f 1`")

for source in `cat $VALIDDOMAINTLDBKUP`;
do

WHATLINENUMBER=$(echo "`grep -n $source $VALIDDOMAINTLDBKUP | cut -d : -f 1`")
TLDPERCENTAGEMATH=$(echo `awk "BEGIN { pc=100*${WHATLINENUMBER}/${HOWMANYVALIDTLD}; i=int(pc); print (pc-i<0.5)?i:i+1}"`)

HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $BIGAPL | wc -l`")
if
[[ "$HOWMANYTIMESTLD" != 0 ]]
then
TLDPERCENTAGERESULT=$(echo `awk "BEGIN { pc=100*${HOWMANYTIMESTLD}/${BIGAPLHOWMANY}; i=int(pc); print (pc-i<0.5)?i:i+1}"`)
{ if
[[ "$TLDPERCENTAGERESULT" != 0 ]]
then
echo "$TLDPERCENTAGERESULT % ."$source"" | tee --append $TEMPFILEN &>/dev/null
elif
[[ "$TLDPERCENTAGERESULT" == 0 ]]
then
echo "0.5 % ."$source"" | tee --append $TEMPFILEN &>/dev/null
fi }
fi

echo -ne "$TLDPERCENTAGEMATH \r"

done

echo "________________________________________________" | tee --append $RECENTRUN &>/dev/null
if
[[ -f $TEMPFILEN ]]
then
cat -s $TEMPFILEN | sort -n > $TEMPFILEM
else
touch $TEMPFILEM
fi

if
[[ -f $TEMPFILEM ]]
then
tac $TEMPFILEM >> $TEMPFILEP
else
touch $TEMPFILEP
fi

if
[[ -f $TEMPFILEP ]]
then
for source in `cat $TEMPFILEP`;
do
echo "* '$source'" | tee --append $RECENTRUN &>/dev/null
done
fi
