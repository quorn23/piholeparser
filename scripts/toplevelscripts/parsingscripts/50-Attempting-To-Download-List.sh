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

## Terminal Display
if
[[ -z $SKIPDOWNLOAD && $SOURCETYPE != usemirrorfile ]]
then
printf "$yellow"    "Fetching $SOURCETYPE List From $SOURCEDOMAIN Located At The IP address Of "$SOURCEIP"."
fi

if
[[ $SOURCETYPE == usemirrorfile ]]
then
printf "$yellow"    "Using Existing Mirror File."
fi

## Logically download based on the Upcheck, and file type
if
[[ $SOURCETYPE == unknown ]]
then
wget -q -O $BTEMPFILE $source
elif
[[ $SOURCETYPE == usemirrorfile ]]
then
cat $MIRROREDFILE >> $BTEMPFILE
USEDMIRRORFILE=true
echo "USEDMIRRORFILE="$USEDMIRRORFILE"" | tee --append $TEMPPARSEVARS &>/dev/null
elif
[[ $SOURCETYPE == plaintext ]]
then
wget -q -O $BTEMPFILE $source
elif
[[ $SOURCETYPE == webpage ]]
then
curl -s -L $source >> $BTEMPFILE
elif
[[ $SOURCETYPE == zip ]]
then
wget -q -O $COMPRESSEDTEMPZIP $source
7z e -so $COMPRESSEDTEMPZIP >> $BTEMPFILE
rm $COMPRESSEDTEMPZIP
elif
[[ $SOURCETYPE == seven ]]
then
wget -q -O $COMPRESSEDTEMPSEVEN $source
7z e -so $COMPRESSEDTEMPSEVEN >> $BTEMPFILE
elif
[[ $SOURCETYPE == tar ]]
then
wget -q -O $COMPRESSEDTEMPTAR $source
TARFILEX=$(tar -xavf "$COMPRESSEDTEMPTAR" -C "$TEMPDIR")
cat "$TEMPDIR""$TARFILEX" >> $BTEMPFILE
fi

## Check If File Was Downloaded
if
[[ -f $BTEMPFILE ]]
then
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
elif
[[ ! -f $BTEMPFILE ]]
then
printf "$red"    "File Download Failed."
DOWNLOADFAILED=true
touch $BORIGINALFILETEMP
fi

## Check that there was a file downloaded
## Try as a browser, and then try a mirror file
if
[[ -f $BORIGINALFILETEMP ]]
then
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if
[[ "$FETCHFILESIZE" -gt 0 ]]
then
printf "$green"    "Download Successful."
elif
[[ "$FETCHFILESIZE" -le 0 ]]
then
printf "$red"    "Download Failed."
DOWNLOADFAILED=true
touch $BORIGINALFILETEMP
fi

## Attempt agent download
if 
[[ -n $DOWNLOADFAILED && "$FETCHFILESIZE" -eq 0 && $source != *.7z && $source != *.tar.gz && $source != *.zip ]]
then
echo ""
printf "$cyan"    "Attempting To Fetch List As if we were a browser."
curl -s -H "$AGENTDOWNLOAD" -L $source >> $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
fi
if
[[ -f $BORIGINALFILETEMP ]]
then
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
fi

## attempt mirror if not done already
if 
[[ -z $DOWNLOADFAILED && "$FETCHFILESIZE" -eq 0 && -z $USEDMIRRORFILE ]]
then
printf "$red"    "File Empty."
printf "$cyan"    "Attempting To Fetch List From Git Repo Mirror."
echo "* $BASEFILENAME List Failed To Download. Attempted to use Mirror. $timestamp" | tee --append $RECENTRUN &>/dev/null
wget -q -O $BTEMPFILE $MIRROREDFILEDL
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
fi
