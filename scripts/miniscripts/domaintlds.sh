#!/bin/bash
## This Recreates The Valid TLD file

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

CHECKME=$VALIDDOMAINTLD
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

for f in $VALIDDOMAINTLDLINKS
do

for source in `cat $f`;
do

printf "$lightblue"    "___________________________________________________________"
echo ""

## Filenaming Vars
source /etc/piholeparser/scripts/scriptvars/dynamicvariables.var

printf "$cyan"    "The Source In The File Is:"
printf "$yellow"    "$source"
echo ""

if
[[ $source != https* ]]
then
printf "$yellow"    "$BASEFILENAME List Does NOT Use https."
fi

printf "$cyan"    "Pinging $BASEFILENAME To Check Host Availability."

## Check to see if source's host is online
if
[[ -n $UPCHECK ]]
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
elif
[[ -z $UPCHECK ]]
then
printf "$red"    "$BASEFILENAME Host Unavailable."
fi
if
[[ -n $SOURCEIP ]]
then
printf "$green"    "Ping Test Was A Success!"
elif
[[ -z $SOURCEIP ]]
then
printf "$red"    "Ping Test Failed."
fi
echo ""

## Check if file is modified since last download
if 
[[ -f $CURRENTTLDLIST ]]
then
remote_file="$source"
local_file="$CURRENTTLDLIST"
modified=$(curl --silent --head $remote_file | awk -F: '/^Last-Modified/ { print $2 }')
remote_ctime=$(date --date="$modified" +%s)
local_ctimea=$(stat -c %z "$local_file")
local_ctime=$(date --date="$local_ctimea" +%s)
DIDWECHECKONLINEFILE=true
fi
if
[[ -n $DIDWECHECKONLINEFILE && $local_ctime -lt $remote_ctime ]]
then
printf "$yellow"    "File Has Changed Online."
rm $CURRENTTLDLIST
elif
[[ -n $DIDWECHECKONLINEFILE && $local_ctime -gt $remote_ctime ]]
then
MAYBESKIPDL=true
printf "$green"    "File Not Updated Online. No Need To Process."
fi

CHECKME=$VALIDDOMAINTLD
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

timestamp=$(echo `date`)
if
[[ -z $MAYBESKIPDL && -n $SOURCEIP ]]
then
printf "$cyan"    "Fetching List From $UPCHECK Located At The IP address Of "$SOURCEIP"."
curl -s -H "$agent" -L $source >> $BTEMPFILE
cat $BTEMPFILE | sed '/[/]/d; /\#\+/d; s/\s\+$//; /^$/d; /[[:blank:]]/d; /[.]/d; s/\([A-Z]\)/\L\1/g; s/.*/\L\1/g' > $BFILETEMP
rm $BTEMPFILE
cat -s $BFILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BTEMPFILE
rm $BFILETEMP
cp $BTEMPFILE $CURRENTTLDLIST
HOWMANYTLD=$(echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1`")
echo "$HOWMANYTLD Valid TLD's in $BASEFILENAME"
cat $BTEMPFILE >> $VALIDDOMAINTLD
rm $BTEMPFILE
else
cat $CURRENTTLDLIST >> $VALIDDOMAINTLD
fi
done
unset CURRENTTLDLIST
unset MAYBESKIPDL
echo ""
printf "$orange" "___________________________________________________________"
echo ""
done

printf "$lightblue"    "___________________________________________________________"
echo ""

CHECKME=$TLDCOMPARED
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

## Dedupe merge
mv $VALIDDOMAINTLD $BTEMPFILE
cat -s $BTEMPFILE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $VALIDDOMAINTLD
HOWMANYTLD=$(echo -e "\t`wc -l $VALIDDOMAINTLD | cut -d " " -f 1`")
echo "$HOWMANYTLD Valid TLD's Total."
rm $BTEMPFILE

gawk 'NR==FNR{a[$0];next} !($0 in a)' $MAINTLDLIST $VALIDDOMAINTLD > $TLDCOMPARED
HOWMANYTLDNEW=$(echo -e "\t`wc -l $TLDCOMPARED | cut -d " " -f 1`")
echo "$HOWMANYTLDNEW Valid TLD's Not In Main Scan."

CHECKME=$VALIDDOMAINTLDBKUP
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
cp $VALIDDOMAINTLD $VALIDDOMAINTLDBKUP

CHECKME=$TRYNACATCHFIlES
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

echo ""
printf "$orange" "___________________________________________________________"
echo ""
