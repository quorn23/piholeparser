#!/bin/bash
## 

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

## Start time
STARTPARSESTAMP=$(date +"%s")

## Start File Loop
## For .sh files In The actualparsing scripts Directory
echo ""
for p in $ALLACTUALPARSINGSCRIPTS
do
PBASEFILENAME=$(echo `basename $p | cut -f 1 -d '.'`)
PBASEFILENAMEDASHNUM=$(echo $PBASEFILENAME | sed 's/[0-9\-]/ /g')
PBNAMEPRETTYSCRIPTTEXT=$(echo $PBASEFILENAMEDASHNUM)
SCRIPTTEXT=""$PBNAMEPRETTYSCRIPTTEXT"."
PARSECOMMENT="$SCRIPTTEXT"

if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
touch $BFILETEMP
FETCHFILESIZE=$(stat -c%s "$BFILETEMP")
fi

if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
bash $p
touch $BTEMPFILE
rm $BFILETEMP
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
fi

if
[[ -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi

if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

done

printf "$cyan"   "Calculating Parse Time."

## end time
ENDPARSESTAMP=$(date +"%s")
DIFFTIMEPARSESEC=`expr $ENDPARSESTAMP - $STARTPARSESTAMP`
DIFFTIMEPARSE=`expr $DIFFTIMEPARSESEC / 60`
if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
echo "$DIFFTIMEPARSESEC" | tee --append $PARSEAVERAGEFILE &>/dev/null
fi
if
[[ $DIFFTIMEPARSE != 0 ]]
then
printf "$yellow"   "List took $DIFFTIMEPARSE Minutes To Parse."
else
printf "$yellow"   "List took Less Than A Minute To Parse."
fi
echo ""

unset ENDPARSESTAMP
unset STARTPARSESTAMP
unset DIFFTIMEPARSE
unset DIFFTIMEPARSESEC

## Prepare for next step
mv $BFILETEMP $BTEMPFILE
