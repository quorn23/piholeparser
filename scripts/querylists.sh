#!/bin/bash
## This should help me find what parsed list contains a domain
## whiptail required

DOMAINTOLOOKFOR=$(whiptail --inputbox "What Domain are you hunting for?" 10 80 "" 3>&1 1>&2 2>&3)
for f in /etc/piholeparserdev/parsed/*.txt
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
if 
grep -q $DOMAINTOLOOKFOR "$f"
then
echo "$DOMAINTOLOOKFOR was found in $BASEFILENAME "
else
:
fi
done
echo " The Search For $DOMAINTOLOOKFOR completed. "
