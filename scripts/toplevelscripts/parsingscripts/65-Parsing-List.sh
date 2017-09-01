#!/bin/bash
## Parsing loop

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

## Start time
STARTPARSESTAMP=$(date +"%s")
echo "STARTPARSESTAMP="$STARTPARSESTAMP"" | tee --append $TEMPPARSEVARS &>/dev/null

## Cheap error handling
if
[[ -f $BFILETEMP ]]
then
rm $BFILETEMP
fi
if
[[ -f $BTEMPFILE ]]
then
rm $BTEMPFILE
fi

## Transition File for Processing
if
[[ -f $BORIGINALFILETEMP ]]
then
cp $BORIGINALFILETEMP $BFILETEMP
fi

if
[[ ! -f $BFILETEMP ]]
then
touch $BFILETEMP
fi

HOWMANYLINES=$(echo -e "`wc -l $BFILETEMP | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -eq 0 ]]
then
GOTOENDPARSING=true
echo "GOTOENDPARSING="$GOTOENDPARSING"" | tee --append $TEMPPARSEVARS &>/dev/null
fi

## Start File Loop
## For .sh files In The actualparsing scripts Directory
echo ""
for p in $ALLACTUALPARSINGSCRIPTS
do

PBASEFILENAME=$(echo `basename $p | cut -f 1 -d '.'`)
PBASEFILENAMEDASHNUM=$(echo $PBASEFILENAME | sed 's/[0-9\-]/ /g')
PBNAMEPRETTYSCRIPTTEXT=$(echo $PBASEFILENAMEDASHNUM)

if
[[ -f $TEMPPARSEVARS ]]
then
source $TEMPPARSEVARS
fi

if
[[ -z $GOTOENDPARSING ]]
then
printf "$cyan"  "$PBNAMEPRETTYSCRIPTTEXT"
HOWMANYLINESSTART=$(echo -e "`wc -l $BFILETEMP | cut -d " " -f 1`")
bash $p
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PBNAMEPRETTYSCRIPTTEXT"
{ if
[[ $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT List File Now Empty."
GOTOENDPARSING=true
echo "GOTOENDPARSING="$GOTOENDPARSING"" | tee --append $TEMPPARSEVARS &>/dev/null
elif
[[ $HOWMANYLINES -ge 1 && $HOWMANYLINESSTART -ge $HOWMANYLINES ]]
then
printf "$yellow"  "$ENDCOMMENT"
elif
[[ $HOWMANYLINES -ge 1 && $HOWMANYLINESSTART -lt $HOWMANYLINES ]]
then
printf "$green"  "$ENDCOMMENT"
fi }
mv $BTEMPFILE $BFILETEMP
echo ""
fi

done

## End Time
ENDPARSESTAMP=$(date +"%s")
echo "ENDPARSESTAMP="$ENDPARSESTAMP"" | tee --append $TEMPPARSEVARS &>/dev/null

## Prepare for next step
if
[[ -f $BFILETEMP ]]
then
HOWMANYLINES=$(echo -e "`wc -l $BFILETEMP | cut -d " " -f 1`")
{ if
[[ $HOWMANYLINES -eq 0 ]]
then
PARSINGEMPTIEDFILE=true
echo "PARSINGEMPTIEDFILE="$PARSINGEMPTIEDFILE"" | tee --append $TEMPPARSEVARS &>/dev/null
elif
[[ $HOWMANYLINES -ge 1 ]]
then
cp $BFILETEMP $BPARSEDFILETEMP
fi }
fi

## Cheap error handling
if
[[ -f $BFILETEMP ]]
then
rm $BFILETEMP
fi
if
[[ -f $BTEMPFILE ]]
then
rm $BTEMPFILE
fi
