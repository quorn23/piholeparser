#!/bin/bash
## This takes the work done in parser.sh and merges it all into one

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

####################
## Big List       ##
#################### 

## Remove old APL if it is there
if
ls $BIGAPL &> /dev/null;
then
rm $BIGAPL
fi

## Combine Small lists
cat $PARSEDLISTSALL > $TEMPFILE
HOWMANYLINES=$(echo -e "`wc -l $TEMPFILE | cut -d " " -f 1`")
printf "$yellow"  "$HOWMANYLINES $LINESAFTER $MERGEINDIVIDUALS"
echo ""

## Duplicate Removal
printf "$yellow"  "$DEDUPE"
cat -s $TEMPFILE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $FILETEMP
HOWMANYLINES=$(echo -e "`wc -l $FILETEMP | cut -d " " -f 1`")
printf "$yellow"  "$HOWMANYLINES $LINESAFTER $DEDUPE"
mv $FILETEMP $TEMPFILE
echo ""

## Github has a 100mb limit and empty files are useless
WHATISIT="AllPARSEDLIST"
FETCHFILESIZE=$(stat -c%s $TEMPFILE)
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
if
[[ "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi
timestamp=$(echo `date`)
if
[[ -n $FILESIZEZERO ]]
then
echo ""
printf "$red"     "$EMPTYFILE"
echo "$EMPTYFILE" | tee --append $TEMPFILE
echo "* $WHATISIT $EMPTYFILE $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $TEMPFILE $BIGAPL
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZEMB" -ge "$GITHUBLIMITMB" ]]
then
echo ""
printf "$red"     "$GITHUBUPLOADTOOBIG"
echo "* $WHATISIT $GITHUBUPLOADTOOBIG $FETCHFILESIZEMB MB $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $FILETEMP
echo "$WHATISIT $GITHUBUPLOADTOOBIG" | tee --append $TEMPFILE
mv $TEMPFILE $BIGAPL
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZEMB" -lt "$GITHUBLIMITMB" ]]
then
echo ""
mv $TEMPFILE $BIGAPL
printf "$yellow"  "$WHATISIT $FILESUCCESS"
fi

####################
## Big List edit  ##
####################

## Remove old APLE if it is there
if
ls $BIGAPLE &> /dev/null;
then
rm $BIGAPLE
fi

## Add Blacklist Domains
cat $BLACKLISTTEMP $BIGAPL > $FILETEMP
cat -s $FILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
rm $BLACKLISTTEMP
rm $FILETEMP

## Remove Whitelist Domains
gawk 'NR==FNR{a[$0];next} !($0 in a)' $WHITELISTTEMP $TEMPFILE > $FILETEMP
cat -s $FILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $TEMPFILE
rm $WHITELISTTEMP
rm $FILETEMP

## Duplicate Removal
printf "$yellow"  "$DEDUPE"
cat -s $TEMPFILE | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $FILETEMP
HOWMANYLINES=$(echo -e "`wc -l $FILETEMP | cut -d " " -f 1`")
printf "$yellow"  "$HOWMANYLINES $LINESAFTER $DEDUPE"
mv $FILETEMP $TEMPFILE
echo ""

## Github has a 100mb limit and empty files are useless
WHATISIT="AllPARSEDLIST (Edited)"
FETCHFILESIZE=$(stat -c%s $TEMPFILE)
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
if
[[ "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi
timestamp=$(echo `date`)
if
[[ -n $FILESIZEZERO ]]
then
echo ""
printf "$red"     "$EMPTYFILE"
echo "$EMPTYFILE" | tee --append $TEMPFILE
echo "* $WHATISIT $EMPTYFILE $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $TEMPFILE $BIGAPL
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZEMB" -ge "$GITHUBLIMITMB" ]]
then
echo ""
printf "$red"     "$GITHUBUPLOADTOOBIG"
echo "* $WHATISIT $GITHUBUPLOADTOOBIG $FETCHFILESIZEMB MB $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $FILETEMP
echo "$WHATISIT $GITHUBUPLOADTOOBIG" | tee --append $TEMPFILE
mv $TEMPFILE $BIGAPL
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZEMB" -lt "$GITHUBLIMITMB" ]]
then
echo ""
mv $TEMPFILE $BIGAPL
printf "$yellow"  "$WHATISIT $FILESUCCESS"
fi
