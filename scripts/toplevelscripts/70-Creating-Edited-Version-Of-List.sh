#!/bin/bash
## This takes the big list and makes the edited version

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../scriptvars/staticvariables.var

## Cheap error handling
touch $BLACKLISTTEMP
touch $WHITELISTTEMP

WHATITIS="All Parsed List (edited)"
CHECKME=$BIGAPLE
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
echo "* $WHATITIS Removed. $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "* $WHATITIS Not Removed. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

## Add Blacklist Domains
cat $BLACKLISTTEMP $BIGAPL > $FILETEMP
rm $BLACKLISTTEMP
cat -s $FILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
rm $FILETEMP

## Remove Whitelist Domains
gawk 'NR==FNR{a[$0];next} !($0 in a)' $WHITELISTTEMP $TEMPFILE > $FILETEMP
rm $WHITELISTTEMP
cat -s $FILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
rm $FILETEMP

## Github has a 100mb limit and empty files are useless
FETCHFILESIZE=$(stat -c%s $TEMPFILE)
timestamp=$(echo `date`)
if
[ "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Parsed File Too Large For Github. Deleting."
echo "* Allparsedlist list was too large to host on github. $FETCHFILESIZE bytes $timestamp" | tee --append $RECENTRUN &>/dev/null
echo "File exceeded Githubs 100mb limitation" | tee --append $TEMPFILE
mv $TEMPFILE $BIGAPLE
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "File Empty"
echo "File Size equaled zero." | tee --append $TEMPFILE
echo "* Allparsedlist list was an empty file $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $TEMPFILE $BIGAPLE
else
echo ""
mv $TEMPFILE $BIGAPLE
printf "$yellow"  "Big List Edited Created Successfully."
fi
