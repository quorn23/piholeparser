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
FETCHFILESIZEBYTES=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEKB=`expr $FETCHFILESIZE / 1024`
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
fi

timestamp=$(echo `date`)

if 
[[ "$FETCHFILESIZEBYTES" -eq 0 ]]
then
printf "$red"     "$BASEFILENAME List Was An Empty File After Download."
printf "$red"  "List Marked As Dead."
mv $FILEBEINGPROCESSED $BDEADPARSELIST
timestamp=$(echo `date`)
echo "* $BASEFILENAME List Was An Empty File After Download. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BORIGINALFILETEMP
elif
[[ "$FETCHFILESIZEBYTES" -gt 0 ]]
then
ORIGFILESIZENOTZERO=true
echo "ORIGFILESIZENOTZERO="$ORIGFILESIZENOTZERO"" | tee --append $TEMPPARSEVARS &>/dev/null
fi

## File size
if
[[ -n $ORIGFILESIZENOTZERO && "$FETCHFILESIZEMB" -gt 0 && "$FETCHFILESIZEKB" -gt 0 && "$FETCHFILESIZEBYTES" -gt 0 ]]
then
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZEMB MB."
elif
[[ -n $ORIGFILESIZENOTZERO && "$FETCHFILESIZEMB" -eq 0 && "$FETCHFILESIZEKB" -gt 0 && "$FETCHFILESIZEBYTES" -gt 0 ]]
then
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZEKB KB."
elif
[[ -n $ORIGFILESIZENOTZERO && "$FETCHFILESIZEMB" -eq 0 && "$FETCHFILESIZEKB" -eq 0 && "$FETCHFILESIZEBYTES" -gt 0 ]]
then
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZEBYTES Bytes."
fi

## How Many Lines
if
[[ -n $ORIGFILESIZENOTZERO && "$FETCHFILESIZEBYTES" -gt 0 ]]
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

## Duplicate the downloaded file for the next steps
if
[[ -n $ORIGFILESIZENOTZERO && -f $BORIGINALFILETEMP ]]
then
cp $BORIGINALFILETEMP $BTEMPFILE
cp $BORIGINALFILETEMP $BFILETEMP
rm $BORIGINALFILETEMP
fi
