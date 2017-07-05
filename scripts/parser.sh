#!/bin/bash
## This is the Parsing Process

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

####################
## File .lst's    ##
####################

## Process Every .lst file within the List Directories
for f in $EVERYLISTFILEWILDCARD
do

printf "$lightblue"    "$DIVIDERBARB"
echo ""

## Declare File Name
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)

printf "$green"    "$BASEFILENAME"
echo "" 

####################
## Sources .lst   ##
####################

## Amount of sources greater than one?
timestamp=$(echo `date`)
HOWMANYLINES=$(echo -e "`wc -l $f | cut -d " " -f 1`")
if
[[ "$HOWMANYLINES" -gt 1 ]]
then
echo "* $BASEFILENAME Has $HOWMANYLINES Sources. $timestamp" | tee --append $RECENTRUN &>/dev/null
printf "$yellow"    "$BASEFILENAME Has $HOWMANYLINES Sources."
else
printf "$yellow"    "$BASEFILENAME Has Only One Source."
fi

## Process Every source within the .lst from above
for source in `cat $f`;
do

## These Variables are to help with Filenaming
source /etc/piholeparser/scripts/scriptvars/dynamicvariables.var

printf "$cyan"    "The Source In The File Is:"
printf "$yellow"    "$source"
echo "" 

## Is source not using https
if
[[ $source != https* ]]
then
printf "$yellow"    "$BASEFILENAME $NOHTTPSLIST"
fi

####################
## Download Lists ##
####################

printf "$cyan"    "$PINGCHECKING"

## Check to see if source's host is online
if
[[ -n $UPCHECK ]]
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
fi
if
[[ -n $SOURCEIP ]]
then
printf "$green"    "$PINGSUCCESS"
else
printf "$red"    "$PINGFAIL"
fi
echo ""

## Logically download based on the Upcheck, and file type
timestamp=$(echo `date`)
if
[[ -n $SOURCEIP && $source != *.7z && $source != *.tar.gz && $source != *.zip && $source != *.php ]]
then
printf "$cyan"    "$FETCHINGFROM $UPCHECK $IPADDRESSIS "$SOURCEIP"."
wget -q -O $BTEMPFILE $source
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
elif
[[ $source == *.php && -n $SOURCEIP ]]
then
printf "$cyan"    "$FETCHINGFROM $UPCHECK $IPADDRESSIS "$SOURCEIP"."
curl -s -L $source >> $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
elif
[[ -z $SOURCEIP ]]
then
MIRRORVAR=true
printf "$cyan"    "$ATTEMPTGITMIRROR"
echo "* $BASEFILENAME $ATTEMPTGITMIRROR $timestamp" | tee --append $RECENTRUN &>/dev/null
wget -q -O $BTEMPFILE $MIRROREDFILEDL
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
elif
[[ $source == *.zip && -n $SOURCEIP ]]
then
printf "$cyan"    "$FETCHINGFROM $UPCHECK $IPADDRESSIS "$SOURCEIP"."
wget -q -O $COMPRESSEDTEMPSEVEN $source
7z e -so $COMPRESSEDTEMPSEVEN > $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $COMPRESSEDTEMPSEVEN
elif
[[ $source == *.7z && -n $SOURCEIP ]]
then
printf "$cyan"    "$FETCHINGFROM $UPCHECK $IPADDRESSIS "$SOURCEIP"."
wget -q -O $COMPRESSEDTEMPSEVEN $source
7z e -so $COMPRESSEDTEMPSEVEN > $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $COMPRESSEDTEMPSEVEN
elif
[[ $source == *.tar.gz && -n $SOURCEIP ]]
then
printf "$cyan"    "$FETCHINGFROM $UPCHECK $IPADDRESSIS "$SOURCEIP"."
wget -q -O $COMPRESSEDTEMPTAR $source
TARFILEX=$(tar -xavf "$COMPRESSEDTEMPTAR" -C "$TEMPDIR")
mv "$TEMPDIR""$TARFILEX" $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $COMPRESSEDTEMPTAR
fi

## If lst file is in Dead Folder, it means that I was unable to access it at some point
## This checks to see if the list is back online
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
timestamp=$(echo `date`)
if
[[ -n $SOURCEIP && "$FETCHFILESIZE" -gt 0 && $f == $BDEADPARSELIST ]]
then
printf "$red"     "$BASEFILENAME $LISTNOLONGERDEAD"
echo "* $BASEFILENAME $LISTNOLONGERDEAD $timestamp" | tee --append $RECENTRUN &>/dev/null
else
:
fi

## Check that there was a file downloaded
## Try as a browser, and then try a mirror file
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
timestamp=$(echo `date`)
if
[[ "$FETCHFILESIZE" -gt 0 ]]
then
printf "$green"    "Download Successful."
echo ""
else
printf "$red"    "Download Failed."
touch $BORIGINALFILETEMP
echo ""
fi
if 
[[ "$FETCHFILESIZE" -eq 0 && $source != *.7z && $source != *.tar.gz && $source != *.zip ]]
then
printf "$cyan"    "$AGENTDOWNLOAD"
curl -s -H "$agent" -L $source >> $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
echo ""
fi
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
if 
[[ "$FETCHFILESIZE" -eq 0 && -z $MIRRORVAR ]]
then
printf "$red"    "$EMPTYFILE"
printf "$cyan"    "$ATTEMPTGITMIRROR"
echo "* $BASEFILENAME $ATTEMPTGITMIRROR $timestamp" | tee --append $RECENTRUN &>/dev/null
wget -q -O $BTEMPFILE $MIRROREDFILEDL
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
echo ""
fi

## This Clears the SourceIP var before the next loop
if
[[ -n $SOURCEIP ]]
then
unset SOURCEIP
fi

## This is the source Loop end
## If multiple sources, it should merge them into one document
done

## This should let me know if a document is a bad link
timestamp=$(echo `date`)
if
[[ -n $FILESIZEZERO && `grep -q "?php" "$BORIGINALFILETEMP"` ]]
then
printf "$red"     "$BASEFILENAME $PHPFILEDOWNLOADED"
echo "* $BASEFILENAME $PHPFILEDOWNLOADED $timestamp" | tee --append $RECENTRUN &>/dev/null
FILESIZEZERO=true
elif
[[ -n $FILESIZEZERO && `grep -q "DOCTYPE html" "$BORIGINALFILETEMP"` ]]
then
printf "$red"     "$BASEFILENAME $HTMLDOWNLOADED"
echo "* $BASEFILENAME $HTMLDOWNLOADED $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BORIGINALFILETEMP
touch $BORIGINALFILETEMP
FILESIZEZERO=true
fi

####################
## Check Filesize ##
####################

## Throughout the script, if the file has no content, it will skip to the end
## by setting the FILESIZEZERO variable

printf "$cyan"    "$VERIFYFILESIZE"

## set filesizezero variable if empty
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
if 
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
timestamp=$(echo `date`)
printf "$red"     "$BASEFILENAME $EMPTYFILE  $AFTERDOWNLOAD"
echo "* $BASEFILENAME $EMPTYFILE $AFTERDOWNLOAD $timestamp" | tee --append $RECENTRUN &>/dev/null
touch $BORIGINALFILETEMP
else
HOWMANYLINES=$(echo -e "`wc -l $BORIGINALFILETEMP | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines $AFTERDOWNLOAD"
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZEMB MB."
printf "$yellow"  "$ENDCOMMENT"
echo ""
fi

## Duplicate the downloaded file for the next steps
cp $BORIGINALFILETEMP $BTEMPFILE
cp $BORIGINALFILETEMP $BFILETEMP
rm $BORIGINALFILETEMP

####################
## Create Mirrors ##
####################

printf "$cyan"   "Attempting Creation of Mirror File."

## This helps when replacing the mirrored file
if 
[[ -z $FILESIZEZERO && -f $MIRROREDFILE ]]
then
printf "$green"  "Old Mirror File Removed"
rm $MIRROREDFILE
fi

## Github has a 100mb limit, and empty files are useless
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
if 
[[ -n $FILESIZEZERO ]]
then
printf "$red"     "Not Creating Mirror File. Nothing To Create!"
rm $BTEMPFILE
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZEMB" -ge "$GITHUBLIMITMB" ]]
then
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo "* $BASEFILENAME list was $FETCHFILESIZEMB MB, and too large to mirror on github. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BTEMPFILE
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZEMB" -lt "$GITHUBLIMITMB" ]]
then
printf "$green"  "Creating Mirror Of Unparsed File."
mv $BTEMPFILE $MIRROREDFILE
else
rm $BTEMPFILE
fi
echo ""

####################
## Processing     ##
####################

## I haven't decided what to do with IP Lists yet, so this will skip them after mirroring
if
[[ $f == $BIPPARSELIST ]]
then
FILESIZEZERO=true
fi

## Comments #'s and !'s .'s
PARSECOMMENT="Removing Lines With Comments."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/\#\+/d; /\!\+/d; /^[.]/d' | grep -v '\^.' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
else
:
fi
if
[[ -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Content Filtering and IP addresses
PARSECOMMENT="Removing Content Filtering Lines and IP Addresses."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/^https\?:\/\//d; /third-party$/d; /popup$/d; s/^PRIMARY\s\+[ \t]*//; s/^localhost\s\+[ \t]*//; s/blockeddomain.hosts\s\+[ \t]*//; s/^0.0.0.0\s\+[ \t]*//; s/^127.0.0.1\s\+[ \t]*//; s/^::1\s\+[ \t]*//' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
else
:
fi
if
[[ -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Empty Space
PARSECOMMENT="Removing Lines With Empty Space."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed 's/\s\+$//; /^$/d; /[[:blank:]]/d' > $BTEMPFILE
#cat $BFILETEMP | sed '/^$/d; /\s\+/d' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
else
:
fi
if
[[ -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Invalid Characters
## FQDN's  can only have . _ and -
## apparently you can have an emoji domain name?
PARSECOMMENT="Removing Invalid FQDN Characters."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/,/d; s/"/'\''/g; /\"\//d; /[+]/d; /[\]/d; /[/]/d; /[<]/d; /[>]/d; /[?]/d; /[*]/d; /[@]/d; /~/d; /[`]/d; /[=]/d; /[:]/d; /[;]/d; /[%]/d; /[&]/d; /[(]/d; /[)]/d; /[$]/d; /\[\//d; /\]\//d; /[{]/d; /[}]/d; /[][]/d; /\^\//d; s/^||//; /[|]/d' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
else
:
fi
if
[[ -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Domain Requirements,, a period and a letter
PARSECOMMENT="Checking For FQDN Requirements."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/[a-z]/!d; /[.]/!d; /[a-z]$/!d; /^[.]/d' | grep -v '\^.' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
else
:
fi
if
[[ -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Duplicate Removal
PARSECOMMENT="Removing Duplicate Lines."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat -s $BFILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
else
:
fi
if
[[ -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Prepare for next step
mv $BFILETEMP $BTEMPFILE

####################
## Complete Lists ##
#################### 

printf "$cyan"   "Attempting Creation Of Parsed List."

## this helps with replacing a parsed file
if 
[[ -z $FILESIZEZERO && -f $PARSEDFILE ]]
then
printf "$green"  "Old Parsed File Removed"
rm $PARSEDFILE
fi

## Github has a 100mb limit, and empty files are useless
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
if 
[[ -n $FILESIZEZERO ]]
then
printf "$red"     "Not Creating Parsed File. Nothing To Create!"
rm $BTEMPFILE
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZEMB" -ge "$GITHUBLIMITMB" ]]
then
printf "$red"     "Parsed File Too Large For Github. Deleting."
echo "* $BASEFILENAME list was $FETCHFILESIZEMB MB, and too large to push to github. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BTEMPFILE
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZEMB" -lt "$GITHUBLIMITMB" ]]
then
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZEMB MB."
printf "$green"  "Parsed File Completed Succesfully."
mv $BTEMPFILE $PARSEDFILE
else
rm $BTEMPFILE
fi
echo ""
printf "$orange" "___________________________________________________________"
echo ""

## This could give issues in the file loop if not set
if
[[ -n $FILESIZEZERO ]]
then
unset FILESIZEZERO
fi

## End File Loop
done
