#!/bin/bash
## This should help me find out the percentage of TLD's to optimize script speed

## Vars
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

cp $BIGAPL $TEMPFILEA

for source in 'cat $MAINTLDLIST'
do
HOWMANYTIMESTLD=$(echo -e "grep -o '$source' $TEMPFILEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA | wc -l")
echo "$HOWMANYTIMESTLD $source" | tee --append $RECENTRUN &>/dev/null
done

rm $TEMPFILEA
