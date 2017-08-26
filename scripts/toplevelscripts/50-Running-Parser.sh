#!/bin/bash
## This is the Parsing Process

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

RECENTRUN="$TOPLEVELLOGSDIR""$SCRIPTBASEFILENAME".md

## Process Every .lst file within the List Directories
for f in $EVERYLISTFILEWILDCARD
do

## Clear Temp Before
if
[[ -f $DELETETEMPFILE ]]
then
bash $DELETETEMPFILE
else
echo "Error Deleting Temp Files."
exit
fi

if
[[ -f $TEMPPARSEVARS ]]
then
rm $TEMPPARSEVARS
fi

printf "$lightblue"    "$DIVIDERBAR"
echo ""

## Declare File Name
FILEBEINGPROCESSED=$f
echo "FILEBEINGPROCESSED="$FILEBEINGPROCESSED"" | tee --append $TEMPPARSEVARS &>/dev/null
echo "RECENTRUN="$RECENTRUN"" | tee --append $TEMPPARSEVARS &>/dev/null
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
echo "BASEFILENAME="$BASEFILENAME"" | tee --append $TEMPPARSEVARS &>/dev/null

printf "$green"    "Processing $BASEFILENAME List."
echo "" 

for p in $ALLPARSINGSCRIPTS
do

PBASEFILENAME=$(echo `basename $p | cut -f 1 -d '.'`)
PBASEFILENAMEDASHNUM=$(echo $PBASEFILENAME | sed 's/[0-9\-]/ /g')
PBNAMEPRETTYSCRIPTTEXT=$(echo $PBASEFILENAMEDASHNUM)
TAGTHEREPOLOG="[Details If Any]("$PARSINGSCRIPTSLOGDIRRAW""$PBASEFILENAME".md)"
BREPOLOG="$PARSINGSCRIPTSLOGDIR""$BASEFILENAME".md

## Create Log
if
[[ -f $BREPOLOG ]]
then
rm $BREPOLOG
fi
touch $BREPOLOG

if
[[ -f $TEMPPARSEVARS ]]
then
source $TEMPPARSEVARS
fi

if
[[ -z $FULLSKIPPARSING && -f $FILEBEINGPROCESSED ]]
then
printf "$cyan"  "$PBNAMEPRETTYSCRIPTTEXT"
bash $p
echo ""
fi

## End of parsing Loop
done

## Dead List Alive
if
[[ -n $UNDEADLIST && -f $FILEBEINGPROCESSED ]]
then
mv $FILEBEINGPROCESSED $BUNDEADPARSELIST
fi

## Clear Temp After
if
[[ -f $DELETETEMPFILE ]]
then
bash $DELETETEMPFILE
else
echo "Error Deleting Temp Files."
exit
fi

printf "$orange" "$DIVIDERBARB"

if
[[ -f $TEMPPARSEVARS ]]
then
rm $TEMPPARSEVARS
fi

unset FULLSKIPPARSING
unset UNDEADLIST

if
[[ -f $BORIGINALFILETEMP ]]
then
rm $BORIGINALFILETEMP
fi

echo "$TAGTHEREPOLOG" | sudo tee --append $RECENTRUN &>/dev/null
echo "" | sudo tee --append $RECENTRUN &>/dev/null
## End of File Loop
done
