#!/bin/bash
## This should help me find what parsed list contains a domain

## Variables
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

## whiptail required
if
which whiptail >/dev/null;
then
:
else
printf "$yellow"  "Installing whiptail"
apt-get install -y whiptail
fi

DOMAINTOLOOKFOR=$(whiptail --inputbox "What Domain are you hunting for?" 10 80 "" 3>&1 1>&2 2>&3)
echo ""
echo "Searching for $DOMAINTOLOOKFOR"
echo ""

for f in $PARSEDBLACKLISTSSUBALL
do

BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)

if 
grep -q $DOMAINTOLOOKFOR "$f"
then
echo "Found In "$BASEFILENAME". Matching Included:"
echo "`grep $DOMAINTOLOOKFOR $f`"
echo ""
fi

done
echo ""
echo ""

echo "Checking Big Lists"
if 
grep -q $DOMAINTOLOOKFOR "$COMBINEDBLACKLISTS"
then
echo "Found on Big List (Normal)"
echo "`grep $DOMAINTOLOOKFOR $COMBINEDBLACKLISTS`"
echo ""
else
echo "Not Found on Big List (Normal)"
fi

if 
grep -q $DOMAINTOLOOKFOR "$COMBINEDBLACKLISTSDBB"
then
echo "Found on Big List (Edited)"
echo "`grep $DOMAINTOLOOKFOR $COMBINEDBLACKLISTSDBB`"
echo ""
else
echo "Not Found on Big List (Edited)"
fi
echo ""
echo ""

echo "The Search For $DOMAINTOLOOKFOR completed. "
