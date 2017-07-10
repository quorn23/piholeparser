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

for source in `cat $MAINTLDLIST`;
do
echo "Trimming $source"
HOWMANYTIMESTLDA=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
cat $TEMPFILEA | sed '/[$source]$/I!d' > $TEMPFILEB
rm $TEMPFILEA
HOWMANYTIMESTLDB=$(echo -e "`wc -l $TEMPFILEB | cut -d " " -f 1`")
HOWMANYTIMESTLDDIFF=$(expr $HOWMANYTIMESTLDA - $HOWMANYTIMESTLDB)
if
[[ $HOWMANYTIMESTLDDIFF -eq 0 ]]
then
echo "0 $source"
else
echo "$HOWMANYTIMESTLDDIFF $source" | tee --append $RECENTRUN
fi
mv $TEMPFILEB $TEMPFILEA
done

cat -s $TEMPFILEA | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILEB
#cat $TEMPFILEB | sed '/^0/d; s/[^a-z]*//g' > $TEMPFILEA



mv $TEMPFILEB $TOPTLDPERCENTAGE
