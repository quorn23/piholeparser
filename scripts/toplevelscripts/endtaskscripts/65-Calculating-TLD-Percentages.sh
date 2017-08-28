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

for source in `cat $VALIDDOMAINTLDBKUP`;
do
echo "Counting ."$source""
HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $BIGAPL | wc -l`")

if
[[ "$HOWMANYTIMESTLD" != 0 ]]
then
TLDPERCENTAGEMATH=$(echo `awk "BEGIN { pc=100*${HOWMANYTIMESTLD}/${BIGAPLHOWMANY}; i=int(pc); print (pc-i<0.5)?i:i+1}"`)
echo "$TLDPERCENTAGEMATH Percent ."$source"" | tee --append $TEMPFILEN
fi

echo ""
done

echo "________________________________________________"" | tee --append $RECENTRUN
cat -s $TEMPFILEN | sort -n > $TEMPFILEM
tac $TEMPFILEM >> $RECENTRUN
