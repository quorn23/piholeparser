#!/bin/bash
## This downloads the valid tld lists

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

for f in $VALIDDOMAINTLDLINKS
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

printf "$lightblue"    "$DIVIDERBAR"
echo ""

## Declare File Name
FILEBEINGPROCESSED=$f
echo "FILEBEINGPROCESSED="$FILEBEINGPROCESSED"" | tee --append $TEMPPARSEVARS &>/dev/null
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
echo "BASEFILENAME="$BASEFILENAME"" | tee --append $TEMPPARSEVARS &>/dev/null
TAGTHEREPOLOG="[Details If Any]("$TLDSCRIPTSLOGDIRRAW""$BASEFILENAME".log)"
BREPOLOG="$TLDSCRIPTSLOGDIR""$BASEFILENAME".log
echo "RECENTRUN="$RECENTRUN"" | tee --append $TEMPPARSEVARS &>/dev/null

printf "$green"    "Processing $BASEFILENAME List."
echo "" 

## Create Log
if
[[ -f $BREPOLOG ]]
then
rm $BREPOLOG
fi
touch $BREPOLOG

for p in $ALLTLDSCRIPTS
do

PBASEFILENAME=$(echo `basename $p | cut -f 1 -d '.'`)
PBASEFILENAMEDASHNUM=$(echo $PBASEFILENAME | sed 's/[0-9\-]/ /g')
PBNAMEPRETTYSCRIPTTEXT=$(echo $PBASEFILENAMEDASHNUM)

printf "$cyan"  "$PBNAMEPRETTYSCRIPTTEXT"

bash $p

echo ""

## End of parsing Loop
done

## Clear Temp After
if
[[ -f $DELETETEMPFILE ]]
then
bash $DELETETEMPFILE
else
echo "Error Deleting Temp Files."
exit
fi

echo "$TAGTHEREPOLOG" | sudo tee --append $RECENTRUN &>/dev/null
echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$orange" "$DIVIDERBARB"
echo ""

done
