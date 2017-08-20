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

## FULLSKIPPARSING text
if
[[ -n $FULLSKIPPARSING ]]
then
printf "$yellow"    "Not Downloading List."
fi

## What type of source?
if
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.7z ]]
then
SOURCETYPE=sevenzip
elif
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.tar.gz ]]
then
SOURCETYPE=tar
elif
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.zip ]]
then
SOURCETYPE=zip
elif
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.php ]]
then
SOURCETYPE=php
elif
[[ -z $FULLSKIPPARSING && -z PINGTESTFAILED && $source != *.txt ]]
then
SOURCETYPE=text
elif
[[ -z $FULLSKIPPARSING && -n PINGTESTFAILED && -f $MIRROREDFILE ]]
then
SOURCETYPE=usemirrorfile
else
SOURCETYPE=unknown
fi

## Terminal Display
timestamp=$(echo `date`)
if
[[ -z $FULLSKIPPARSING && -n $SOURCEIP && -n $UPCHECK && -n $SOURCETYPE ]]
then
printf "$cyan"    "Fetching $SOURCETYPE List From $UPCHECK Located At The IP address Of "$SOURCEIP"."
elif
[[ -z $FULLSKIPPARSING && $SOURCETYPE == usemirrorfile ]]
then
printf "$cyan"    "Attempting To Fetch List From Git Repo Mirror."
echo "* $BASEFILENAME List Unavailable To Download. Attempted to use Mirror. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

## Logically download based on the Upcheck, and file type
if
[[ -z $FULLSKIPPARSING && $SOURCETYPE == unknown ]]
then
wget -q -O $BTEMPFILE $source
elif
[[ -z $FULLSKIPPARSING && $SOURCETYPE == text ]]
then
wget -q -O $BTEMPFILE $source
elif
[[ -z $FULLSKIPPARSING && $SOURCETYPE == php ]]
then
curl -s -L $source >> $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && $SOURCETYPE == usemirrorfile ]]
then
cat $MIRROREDFILE >> $BTEMPFILE
USEDMIRRORFILE=true
echo "USEDMIRRORFILE="$USEDMIRRORFILE"" | tee --append $TEMPPARSEVARS &>/dev/null
elif
[[ -z $FULLSKIPPARSING && $SOURCETYPE == zip ]]
then
wget -q -O $COMPRESSEDTEMPZIP $source
7z e -so $COMPRESSEDTEMPZIP > $BTEMPFILE
rm $COMPRESSEDTEMPZIP
elif
[[ -z $FULLSKIPPARSING && $SOURCETYPE == seven ]]
then
wget -q -O $COMPRESSEDTEMPSEVEN $source
7z e -so $COMPRESSEDTEMPSEVEN > $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && $SOURCETYPE == tar ]]
then
wget -q -O $COMPRESSEDTEMPTAR $source
TARFILEX=$(tar -xavf "$COMPRESSEDTEMPTAR" -C "$TEMPDIR")
mv "$TEMPDIR""$TARFILEX" $BTEMPFILE
fi

## Check If File Was Downloaded
if
[[ -z $FULLSKIPPARSING && -f $BTEMPFILE ]]
then
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && ! -f $BTEMPFILE ]]
then
printf "$red"    "File Download Failed."
DOWNLOADFAILED=true
touch $BORIGINALFILETEMP
fi

## Check that there was a file downloaded
## Try as a browser, and then try a mirror file
if
[[ -z $FULLSKIPPARSING && -f $BORIGINALFILETEMP ]]
then
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -gt 0 ]]
then
printf "$green"    "Download Successful."
echo ""
elif
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -le 0 ]]
then
printf "$red"    "Download Failed."
DOWNLOADFAILED=true
touch $BORIGINALFILETEMP
echo ""
fi

## Attempt agent download
if 
[[ -z $FULLSKIPPARSING && -n $DOWNLOADFAILED && "$FETCHFILESIZE" -eq 0 && $source != *.7z && $source != *.tar.gz && $source != *.zip ]]
then
printf "$cyan"    "Attempting To Fetch List As if we were a browser."
curl -s -H "$AGENTDOWNLOAD" -L $source >> $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
echo ""
fi
if
[[ -z $FULLSKIPPARSING && -f $BORIGINALFILETEMP ]]
then
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
fi

## attempt mirror if not done already
if 
[[ -z $FULLSKIPPARSING && -z $DOWNLOADFAILED && "$FETCHFILESIZE" -eq 0 && -z $USEDMIRRORFILE ]]
then
printf "$red"    "File Empty."
printf "$cyan"    "Attempting To Fetch List From Git Repo Mirror."
echo "* $BASEFILENAME List Failed To Download. Attempted to use Mirror. $timestamp" | tee --append $RECENTRUN &>/dev/null
wget -q -O $BTEMPFILE $MIRROREDFILEDL
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
echo ""
fi
