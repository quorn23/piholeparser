#!/bin/bash
## This should help me find out the percentage of TLD's to optimize script speed

## Vars
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

STARTTIMESTAMP=$(date +"%s")

CHECKME=$TEMPFILEA
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

CHECKME=$TEMPFILEB
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

CHECKME=$TOPTLDPERCENTAGE
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

cp $BIGAPL $TEMPFILEA

cp $VALIDDOMAINTLDBKUP $TEMPFILEF
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

rm /etc/piholeparser/temp/*.txt

ENDTIMESTAMP=$(date +"%s")
DIFFTIMESEC=`expr $ENDTIMESTAMP - $STARTTIMESTAMP`
DIFFTIME=`expr $DIFFTIMESEC / 60`
TOTALRUNTIME="Script Took $DIFFTIME Minutes."
printf "$yellow"   "$TOTALRUNTIME"

