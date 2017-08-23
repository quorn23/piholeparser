#!/bin/bash
## Check File size

## Variables
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
[[ -f $BORIGINALFILETEMP ]]
then
ORIGFILESIZEBYTES=$(stat -c%s "$BORIGINALFILETEMP")
echo "ORIGFILESIZEBYTES="$ORIGFILESIZEBYTES"" | tee --append $TEMPPARSEVARS &>/dev/null
ORIGFILESIZEKB=`expr $FETCHFILESIZE / 1024`
echo "ORIGFILESIZEKB="$ORIGFILESIZEKB"" | tee --append $TEMPPARSEVARS &>/dev/null
ORIGFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
echo "ORIGFILESIZEMB="$ORIGFILESIZEMB"" | tee --append $TEMPPARSEVARS &>/dev/null
fi

timestamp=$(echo `date`)

if 
[[ "$ORIGFILESIZEBYTES" -eq 0 ]]
then
printf "$red"     "$BASEFILENAME List Was An Empty File After Download."
printf "$red"  "List Marked As Dead."
mv $FILEBEINGPROCESSED $BDEADPARSELIST
timestamp=$(echo `date`)
echo "* $BASEFILENAME List Was An Empty File After Download. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BORIGINALFILETEMP
elif
[[ "$ORIGFILESIZEBYTES" -gt 0 ]]
then
ORIGFILESIZENOTZERO=true
echo "ORIGFILESIZENOTZERO="$ORIGFILESIZENOTZERO"" | tee --append $TEMPPARSEVARS &>/dev/null
fi

## File size
if
[[ -n $ORIGFILESIZENOTZERO && "$ORIGFILESIZEMB" -gt 0 && "$ORIGFILESIZEKB" -gt 0 && "$ORIGFILESIZEBYTES" -gt 0 ]]
then
printf "$yellow"  "Size of $BASEFILENAME = $ORIGFILESIZEMB MB."
elif
[[ -n $ORIGFILESIZENOTZERO && "$ORIGFILESIZEMB" -eq 0 && "$ORIGFILESIZEKB" -gt 0 && "$ORIGFILESIZEBYTES" -gt 0 ]]
then
printf "$yellow"  "Size of $BASEFILENAME = $ORIGFILESIZEKB KB."
elif
[[ -n $ORIGFILESIZENOTZERO && "$ORIGFILESIZEMB" -eq 0 && "$ORIGFILESIZEKB" -eq 0 && "$ORIGFILESIZEBYTES" -gt 0 ]]
then
printf "$yellow"  "Size of $BASEFILENAME = $ORIGFILESIZEBYTES Bytes."
fi

## How Many Lines
if
[[ -n $ORIGFILESIZENOTZERO && "$ORIGFILESIZEBYTES" -gt 0 ]]
then
HOWMANYLINES=$(echo -e "`wc -l $BORIGINALFILETEMP | cut -d " " -f 1`")
printf "$yellow"  "$HOWMANYLINES Lines After Download."
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
