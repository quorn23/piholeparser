#!/bin/bash
## Phasing out DYNOVARS by claiming vars here

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
if
[[ -f $TEMPPARSEVARS ]]
then
source $TEMPPARSEVARS
else
echo "Temp Parsing Vars File Missing, Exiting."
exit
fi

## Download URL
if
[[ "$AMOUNTOFSOURCES" -le 1 ]]
then
source="$(echo `cat $FILEBEINGPROCESSED`)"
elif
[[ "$AMOUNTOFSOURCES" -gt 1 ]]
then
source="$(echo `cat $FILEBEINGPROCESSED | head -1`)"
fi

#echo "source="$source"" | tee --append $TEMPPARSEVARS &>/dev/null
echo "source='$source'" | tee --append $TEMPPARSEVARS &>/dev/null

## This extracts the domain from source
SOURCEDOMAIN=`echo $source | awk -F/ '{print $3}'`
echo "SOURCEDOMAIN="$SOURCEDOMAIN"" | tee --append $TEMPPARSEVARS &>/dev/null

## Mirrored File (local directory)
MIRROREDFILE="$MIRRORDIR""$BASEFILENAME".txt
echo "MIRROREDFILE="$MIRROREDFILE"" | tee --append $TEMPPARSEVARS &>/dev/null

## Mirrored File (github)
MIRROREDFILEDL="$MIRROREDLISTSDIRRAW""$BASEFILENAME".txt
echo "MIRROREDFILEDL="$MIRROREDFILEDL"" | tee --append $TEMPPARSEVARS &>/dev/null

## Parsed File
PARSEDFILE="$PARSEDDIR""$BASEFILENAME".txt
echo "PARSEDFILE="$PARSEDFILE"" | tee --append $TEMPPARSEVARS &>/dev/null

## DeadList
BDEADPARSELIST="$DEADLISTDIR""$BASEFILENAME".lst
echo "BDEADPARSELIST="$BDEADPARSELIST"" | tee --append $TEMPPARSEVARS &>/dev/null

## Un-DeadList
BUNDEADPARSELIST="$MAINLISTSDIR""$BASEFILENAME".lst
echo "BUNDEADPARSELIST="$BUNDEADPARSELIST"" | tee --append $TEMPPARSEVARS &>/dev/null

## Kill The List
KILLTHELIST="$LISTSTHATDIEDIR""$BASEFILENAME".list
echo "KILLTHELIST="$KILLTHELIST"" | tee --append $TEMPPARSEVARS &>/dev/null

## Temp Files
BTEMPFILE="$TEMPDIR""$BASEFILENAME".tempfile.txt
echo "BTEMPFILE="$BTEMPFILE"" | tee --append $TEMPPARSEVARS &>/dev/null
BFILETEMP="$TEMPDIR""$BASEFILENAME".filetemp.txt
echo "BFILETEMP="$BFILETEMP"" | tee --append $TEMPPARSEVARS &>/dev/null
BORIGINALFILETEMP="$TEMPDIR""$BASEFILENAME".original.txt
echo "BORIGINALFILETEMP="$BORIGINALFILETEMP"" | tee --append $TEMPPARSEVARS &>/dev/null
BPARSEDFILETEMP="$TEMPDIR""$BASEFILENAME".parsed.txt
echo "BPARSEDFILETEMP="$BPARSEDFILETEMP"" | tee --append $TEMPPARSEVARS &>/dev/null

## Terminal Display
printf "$yellow"    "$BASEFILENAME TempVars Have Been Set."
