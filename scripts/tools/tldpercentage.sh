#!/bin/bash
## This should help me find out the percentage of TLD's to optimize script speed

## Vars
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

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

## Total
HOWMANYTIMESTLDA=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
echo "$HOWMANYTIMESTLDA Total" | tee --append $TEMPFILEN

for source in `cat $MAINTLDLIST`;
do
echo "Counting $source"
HOWMANYTIMESTLD=$(echo -e "`grep -o $source $TEMPFILEA | wc -l`")

if
[[ "$HOWMANYTIMESTLD" == 0 ]]
then
echo "0 $source"
else
echo "$HOWMANYTIMESTLD $source" | tee --append $TEMPFILEN
fi

echo ""
done

cat -s $TEMPFILEN | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILEM
#cat $TEMPFILEB | sed 's/[^a-z]*//g' > $TEMPFILEA

mv $TEMPFILEM $TOPTLDPERCENTAGE

rm /etc/piholeparser/temp/*.txt
