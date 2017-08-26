#!/bin/bash
## This will log lists with more than one source

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

RECENTRUN="$HOUSEKEEPINGSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

if 
[[ -f $MORETHANONESOURCE ]]
then
rm $MORETHANONESOURCE
printf "$red"   "Old Multi-Source List Removed"
fi

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
echo "* $BASEFILENAME" | tee --append $MORETHANONESOURCE &>/dev/null
fi

done

if 
[[ -f $MORETHANONESOURCE ]]
then
printf "$yellow"   "https-less List Recreated."
HOWMANYLISTSWITHMULTSOURCE=$(echo -e "`wc -l $MORETHANONESOURCE | cut -d " " -f 1`")
HOWMANYLISTSWITHMULTSOURCEB=$(expr $HOWMANYLISTSWITHMULTSOURCE - 1)
echo ""
printf "$yellow"    "$HOWMANYLISTSWITHMULTSOURCEB Lists With More Than One Source. See Log For Details."
else
printf "$green"   "All Lists Only Have One Source."
echo "All Lists Only Have One Source." | tee --append $MORETHANONESOURCE &>/dev/null
fi
