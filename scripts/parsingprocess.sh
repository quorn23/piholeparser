#!/bin/bash
## This is the Parsing Process

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

for f in $PARSINGPROCESSALL
do

## These Variables are to help with Filenaming
source /etc/piholeparser/scripts/scriptvars/dynamicvariables.var

## Loop Variables
SCRIPTTEXT=""$BNAMEPRETTYSCRIPTTEXT"."
timestamp=$(echo `date`)
PARSECOMMENT=""$BNAMEPRETTYSCRIPTTEXT"."

if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
bash $f
FETCHFILESIZE=$(stat -c%s "$TEMPFILEB")
HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEB | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $TEMPFILEB $TEMPFILEA
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
