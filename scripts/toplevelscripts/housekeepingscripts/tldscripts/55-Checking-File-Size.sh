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

## set filesizezero variable if empty
if
[[ -z $FULLSKIPPARSING ]]
then
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if 
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
echo "FILESIZEZERO="$FILESIZEZERO"" | tee --append $TEMPPARSEVARS &>/dev/null
timestamp=$(echo `date`)
printf "$red"     "$BASEFILENAME List Was An Empty File After Download."
echo "* $BASEFILENAME List Was An Empty File After Download. $timestamp" | tee --append $RECENTRUN &>/dev/null
touch $BORIGINALFILETEMP
elif
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -gt 0 ]]
then
ORIGFILESIZENOTZERO=true
echo "ORIGFILESIZENOTZERO="$ORIGFILESIZENOTZERO"" | tee --append $TEMPPARSEVARS &>/dev/null
HOWMANYLINES=$(echo -e "`wc -l $BORIGINALFILETEMP | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After Download."
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZEMB MB."
printf "$yellow"  "$ENDCOMMENT"
fi

## Cheap error handling
if
[[ -f $BTEMPFILE ]]
then
rm $BTEMPFILE
fi

if
[[ -f $BFILETEMP ]]
then
rm $BFILETEMP
fi

## Duplicate the downloaded file for the next steps
touch $BORIGINALFILETEMP
if
[[ -f $BORIGINALFILETEMP ]]
then
cp $BORIGINALFILETEMP $BTEMPFILE
cp $BORIGINALFILETEMP $BFILETEMP
rm $BORIGINALFILETEMP
fi
