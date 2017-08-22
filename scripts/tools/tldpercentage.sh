#!/bin/bash
## This should help me find out the percentage of TLD's to optimize script speed

## Variables
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

STARTTIMESTAMP=$(date +"%s")

if
[[ -f $TEMPCLEANUP ]]
then
rm $CHECKME
fi

if
[[ -f $BIGAPL ]]
then
cp $BIGAPL $TEMPFILEA
else
exit
fi

if
[[ -f $VALIDDOMAINTLDBKUP ]]
then
cp $VALIDDOMAINTLDBKUP $TEMPFILEF
else
exit
fi

cat $TEMPFILEF | tr -d '.' > $TEMPFILEG

## Total
HOWMANYTIMESTLDA=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
echo "$HOWMANYTIMESTLDA Total" | tee --append $TEMPFILEN
echo ""

for source in `cat $TEMPFILEG`;
do
echo "Counting ."$source""
HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $TEMPFILEA | wc -l`")

if
[[ "$HOWMANYTIMESTLD" == 0 ]]
then
echo "0 ."$source""
else
echo "$HOWMANYTIMESTLD ."$source"" | tee --append $TEMPFILEN
fi

echo ""
done

cat -s $TEMPFILEN | sort -n > $TEMPFILEM
tac $TEMPFILEM > $TEMPFILEJ
#cat $TEMPFILEB | sed 's/[^a-z]*//g' > $TEMPFILEA

mv $TEMPFILEJ $TOPTLDPERCENTAGE

bash $DELETETEMPFILE

ENDTIMESTAMP=$(date +"%s")
DIFFTIMESEC=`expr $ENDTIMESTAMP - $STARTTIMESTAMP`
DIFFTIME=`expr $DIFFTIMESEC / 60`
TOTALRUNTIME="Script Took $DIFFTIME Minutes."
printf "$yellow"   "$TOTALRUNTIME"

