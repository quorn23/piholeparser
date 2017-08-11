#!/bin/bash
## Adjusting Readme.md

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
[[ -f $TEMPVARS ]]
then
source $TEMPVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi


rm $MAINREADME
sed "s/NAMEOFTHEREPOSITORY/$REPONAME/; s/AVERAGELISTPARSINGTIME/$AVERAGEPARSETIME/; s/LASTRUNSTART/$STARTTIME/; s/LASTRUNSTOP/$ENDTIME/; s/TOTALELAPSEDTIME/$TOTALRUNTIME/; s/EDITEDALLPARSEDSIZE/$EDITEDALLPARSEDSIZEMB/" $MAINREADMEDEFAULT > $MAINREADME
