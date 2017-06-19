#!/bin/bash
## This is the Parsing Process
## For Lists that barely need it

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## File Lists     ##
####################

## Start File Loop
for f in $EVERYLISTFILEWILDCARD
do

echo ""
printf "$blue"    "___________________________________________________________"
echo ""

## Process sources within file.lst
for source in `cat $f`;
do

## Variables
source /etc/piholeparser/scriptvars/dynamicvariables.var

printf "$green"    "Processing $BASEFILENAME list."
echo "" 
printf "$cyan"    "Downloading from:"
printf "$cyan"    "$source"
echo "" 

####################
## Download Lists ##
####################

if
[[ -n $UPCHECK ]]
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
fi

if
[[ -n $SOURCEIP && $source != *.7z && $source != *.tar.gz ]]
then
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of "$SOURCEIP"."
echo ""
sudo wget -q -O $BTEMPFILE $source
sudo cat $BTEMPFILE >> $BORIGINALFILETEMP
sudo touch $BORIGINALFILETEMP
sudo rm $BTEMPFILE
elif
[[ -z $SOURCEIP ]]
then
printf "$yellow"    "Attempting To Fetch List From Git Repo Mirror."
sudo echo "* $BASEFILENAME list unavailable to download. Attempted to use Mirror. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
echo ""
sudo wget -q -O $BTEMPFILE $MIRROREDFILEDL
sudo cat $BTEMPFILE >> $BORIGINALFILETEMP
sudo touch $BORIGINALFILETEMP
sudo rm $BTEMPFILE
elif
[[ $source == *.7z && -n $SOURCEIP ]]
then
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of "$SOURCEIP"."
echo ""
sudo wget -q -O $COMPRESSEDTEMPSEVEN $source
sudo 7z e -so $COMPRESSEDTEMPSEVEN > $BTEMPFILE
sudo cat $BTEMPFILE >> $BORIGINALFILETEMP
sudo touch $BORIGINALFILETEMP
sudo rm $COMPRESSEDTEMPSEVEN
elif
[[ $source == *.tar.gz && -n $SOURCEIP ]]
then
sudo wget -q -O $COMPRESSEDTEMPTAR $source
TARFILEX=$(tar -xavf "$COMPRESSEDTEMPTAR" -C "$TEMPDIR")
sudo mv "$TEMPDIR""$TARFILEX" $BTEMPFILE
sudo cat $BTEMPFILE >> $BORIGINALFILETEMP
sudo touch $BORIGINALFILETEMP
sudo rm $COMPRESSEDTEMPTAR
else
echo " Did Not Download File, Maybe?"
sudo touch $BORIGINALFILETEMP
fi

## This was giving me issues
if
[[ -n $SOURCEIP ]]
then
unset SOURCEIP
fi

## Source completion
done

####################
## Create Mirrors ##
####################

echo ""
printf "$green"   "Attempting Creation of Mirror File."
echo ""

## Copy original, one for mirror, one for next step
sudo cp $BORIGINALFILETEMP $BTEMPFILE
sudo cp $BORIGINALFILETEMP $BFILETEMP
sudo rm $BORIGINALFILETEMP

## Github has a 100mb limit, and empty files are useless
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
timestamp=$(echo `date`)
if 
[ "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was $FETCHFILESIZE bytes, and too large to mirror on github. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BTEMPFILE
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was an empty file upon download. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BTEMPFILE
else
echo ""
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$yellow"  "Creating Mirror of Unparsed File."
echo ""
sudo mv $BTEMPFILE $MIRROREDFILE
fi

####################
## Pre-Processing ##
####################

## Comments #'s and !'s, also empty lines
if
[[ -z $FILESIZEZERO ]]
then
PARSECOMMENT="Removing Lines with Comments or Empty."
printf "$yellow"  "$PARSECOMMENT"
sed '/^\s*#/d; s/[#]/\'$'\n/g; /[#]/d; /[!]/d; /^$/d' < $BFILETEMP > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""
else
:
fi
if
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
fi

## Invalid Characters
## FQDN's  can only have . _ and -
## apparently you can have an emoji domain name?
if
[[ -z $FILESIZEZERO ]]
then
PARSECOMMENT="Removing Invalid FQDN characters."
printf "$yellow"  "$PARSECOMMENT"
sed '/[,]/d; s/"/'\''/g; /\"\//d; /[+]/d; /[\]/d; /[/]/d; /[<]/d; /[>]/d; /[?]/d; /[*]/d; /[#]/d; /[!]/d; /[@]/d; /[~]/d; /[`]/d; /[=]/d; /[:]/d; /[;]/d; /[%]/d; /[&]/d; /[(]/d; /[)]/d; /[$]/d; /\[\//d; /\]\//d; /[{]/d; /[}]/d' < $BFILETEMP > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""
else
:
fi
if
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
fi

#####################################################################
## Perl Parser
if
[[ $f == $BLIGHTPARSELIST && -z $FILESIZEZERO ]]
then
echo "Not a Heavy List, Skipping Perl Parser"
echo ""
else
PARSECOMMENT="Cutting Lists with the Perl Parser."
printf "$yellow"  "$PARSECOMMENT"
sudo perl /etc/piholeparser/scripts/parser.pl $BFILETEMP > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
fi
if
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
fi

#####################################################################

## Pipes and Carrots
if
[[ -z $FILESIZEZERO ]]
then
PARSECOMMENT="Removing Pipes and Carrots."
printf "$yellow"  "$PARSECOMMENT"
sudo cat -s $BFILETEMP | sed 's/^||//' | cut -d'^' -f-1 > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""
else
:
fi
if
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
fi

## Remove IP addresses
if
[[ -z $FILESIZEZERO ]]
then
PARSECOMMENT="Removing IP Addresses."
printf "$yellow"  "$PARSECOMMENT"
sed 's/^PRIMARY[ \t]*//; s/^localhost[ \t]*//; s/blockeddomain.hosts[ \t]*//; s/^0.0.0.0[ \t]*//; s/^127.0.0.1[ \t]*//; s/^::1[ \t]*//' < $BFILETEMP > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""
else
:
fi
if
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
fi

## Replace Spaces then Remove Empty Lines
if
[[ -z $FILESIZEZERO ]]
then
PARSECOMMENT="Replacing Spaces with NewLines then Removing Empty Lines."
printf "$yellow"  "$PARSECOMMENT"
sed 's/\s\+/\n/g; /^$/d' < $BFILETEMP > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""
else
:
fi
if
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
fi

## Domain Requirements,, a period and a letter
if
[[ -z $FILESIZEZERO ]]
then
PARSECOMMENT="Checking for FQDN Requirements."
printf "$yellow"  "$PARSECOMMENT"
sed '/[a-z]/!d; /[.]/!d' < $BFILETEMP > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""
else
:
fi
if
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
fi

## Periods at begining and end of lines
## This should fix Wildcarding
if
[[ -z $FILESIZEZERO ]]
then
PARSECOMMENT="Removing Lines With a Period at the Start or End."
printf "$yellow"  "$PARSECOMMENT"
sed '/^[.],/d; /^[.]/d; /[.]$/d' < $BFILETEMP > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""
else
:
fi
if
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
fi

## Duplicate Removal
## if there are fewer lines after this, is something wrong?
if
[[ -z $FILESIZEZERO ]]
then
PARSECOMMENT="Removing Duplicate Lines."
printf "$yellow"  "$PARSECOMMENT"
sudo cat -s $BFILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
echo -e "\t`wc -l $BTEMPFILE | cut -d " " -f 1` lines after $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
echo ""
else
:
fi
if
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
fi

## This was giving me issues
if
[[ -n $FILESIZEZERO ]]
then
unset FILESIZEZERO
fi

## Prepare for next step
sudo mv $BFILETEMP $BTEMPFILE

####################
## Complete Lists ##
#################### 

echo ""
printf "$green"   "Attempting Creation of Parsed List."
echo ""

## Github has a 100mb limit, and empty files are useless
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
timestamp=$(echo `date`)
if 
[ "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was $FETCHFILESIZE bytes, and too large to mirror on github. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BTEMPFILE
elif
[ "$FETCHFILESIZE" -eq 0 ]
then
echo ""
printf "$red"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes. Deleting."
echo ""
sudo echo "* $BASEFILENAME list was an empty file. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo rm $BTEMPFILE
else
echo ""
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$yellow"  "Copying to the parsed Directory."
echo ""
sudo mv $BTEMPFILE $PARSEDFILE
fi

printf "$magenta" "___________________________________________________________"
echo ""

## End File Loop
done
