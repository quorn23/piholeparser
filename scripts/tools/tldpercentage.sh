#!/bin/bash
## This should help me find out the percentage of TLD's to optimize script speed

## Vars
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

cp $BIGAPL $TEMPFILEA

for source in 'cat $MAINTLDLIST'
do
HOWMANYTIMESTLDA=$(echo -e "grep -o '$TEMPFILEA' | wc -l")
cat $TEMPFILEA | sed '/[$source]$/I!d' > $TEMPFILEB
rm $TEMPFILEA
HOWMANYTIMESTLDB=$(echo -e "grep -o '$TEMPFILEB' | wc -l")
HOWMANYTIMESTLDDIFF=`expr $HOWMANYTIMESTLDB - $HOWMANYTIMESTLDA`
echo "$HOWMANYTIMESTLDDIFF $source" | tee --append $RECENTRUN
mv $TEMPFILEB $TEMPFILEA
done

cat -s $TEMPFILEA | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILEB
#cat $TEMPFILEB | sed 's/[^a-z]*//g' > $TEMPFILEA

mv $TEMPFILEB $TOPTLDPERCENTAGE
