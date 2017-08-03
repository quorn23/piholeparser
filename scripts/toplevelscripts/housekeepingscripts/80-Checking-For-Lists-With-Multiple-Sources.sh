#!/bin/bash
## This will help log it better
##########
############
########## Fix me soon

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

## Process Every .lst file within the List Directories
for f in $EVERYLISTFILEWILDCARD
do

BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)

## Amount of sources greater than one?
timestamp=$(echo `date`)
HOWMANYLINES=$(echo -e "`wc -l $f | cut -d " " -f 1`")
if
[[ "$HOWMANYLINES" -gt 1 ]]
then
echo "* $BASEFILENAME Has $HOWMANYLINES sources. $timestamp" | tee --append $RECENTRUN &>/dev/null
#printf "$yellow"    "$BASEFILENAME Has $HOWMANYLINES Sources."
elif
[[ "$HOWMANYLINES" -le 1 ]]
then
:
#printf "$yellow"    "$BASEFILENAME Has Only One Source."
fi

done
