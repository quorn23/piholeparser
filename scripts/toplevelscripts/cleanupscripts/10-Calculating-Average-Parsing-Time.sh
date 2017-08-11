#!/bin/bash
## This Removes *.temp files

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

AVERAGEPARSETIMESEC=`awk '{ total += $1; count++ } END { print total/count }' $PARSEAVERAGEFILE`
AVERAGEPARSETIME=`expr $AVERAGEPARSETIMESEC / 60`
printf "$yellow"   "Average Parsing Time Was $AVERAGEPARSETIME Minutes."
echo "* Average Parsing Time Was $AVERAGEPARSETIME Minutes." | tee --append $RECENTRUN &>/dev/null
rm $PARSEAVERAGEFILE
