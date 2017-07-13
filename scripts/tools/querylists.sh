#!/bin/bash
## This should help me find what parsed list contains a domain

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../scriptvars/staticvariables.var

## whiptail required
WHATITIS=whiptail
WHATPACKAGE=whiptail
if
which $WHATITIS >/dev/null;
then
:
else
printf "$yellow"  "Installing $WHATITIS"
apt-get install -y $WHATPACKAGE
fi

DOMAINTOLOOKFOR=$(whiptail --inputbox "What Domain are you hunting for?" 10 80 "" 3>&1 1>&2 2>&3)
echo ""
echo "Searching for $DOMAINTOLOOKFOR"
echo ""
for f in $PARSEDLISTSALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
if 
grep -q $DOMAINTOLOOKFOR "$f"
then
echo "Found In "$BASEFILENAME". Matching Included:"
echo "`grep $DOMAINTOLOOKFOR $f`"
echo ""
else
:
fi
done
echo ""
echo ""
echo "The Search For $DOMAINTOLOOKFOR completed. "
