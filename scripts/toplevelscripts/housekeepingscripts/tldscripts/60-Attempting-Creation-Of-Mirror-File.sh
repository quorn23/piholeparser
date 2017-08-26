#!/bin/bash
##

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../../../scriptvars/
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
[[ -f $TEMPPARSEVARS ]]
then
source $TEMPPARSEVARS
else
echo "Temp Parsing Vars File Missing, Exiting."
exit
fi

if
[[ -n $FULLSKIPPARSING ]]
then
printf "$green"  "Old Mirror File Retained."
fi

## This helps when replacing the mirrored file
if 
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && -f $CURRENTTLDLIST ]]
then
printf "$green"  "Old Mirror File Removed"
rm $CURRENTTLDLIST
fi

if 
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$green"  "Creating Mirror Of Unparsed File."
mv $BTEMPFILE $CURRENTTLDLIST
elif 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO ]]
then
rm $BTEMPFILE
fi

if
[[ -f $CURRENTTLDLIST ]]
then
cat $CURRENTTLDLIST >> $VALIDDOMAINTLD
fi
