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

printf "$lightblue"    "___________________________________________________________"
echo ""

## Declare File Name
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)

printf "$green"    "Processing $BASEFILENAME List."
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
echo "* $BASEFILENAME Has $HOWMANYLINES sources. $timestamp" | tee --append $RECENTRUN &>/dev/null
printf "$yellow"    "$BASEFILENAME Has $HOWMANYLINES Sources."
elif
[[ "$HOWMANYLINES" -le 1 ]]
then
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
printf "$yellow"    "$BASEFILENAME List Does NOT Use https."
fi

####################
## Determine DL   ##
####################

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
[[ -f $MIRROREDFILE ]]
then
remote_file="$source"
local_file="$MIRROREDFILE"
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
elif
[[ -n $DIDWECHECKONLINEFILE && $local_ctime -gt $remote_ctime ]]
then
MAYBESKIPPARSING=true
printf "$green"    "File Not Updated Online. No Need To Process."
fi
if
[[ -n $MAYBESKIPPARSING && -f $PARSEDFILE ]]
then
FULLSKIPPARSING=true
fi

####################
## Download Lists ##
####################

## Logically download based on the Upcheck, and file type
timestamp=$(echo `date`)
if
[[ -z $FULLSKIPPARSING && -n $SOURCEIP && $source != *.7z && $source != *.tar.gz && $source != *.zip && $source != *.php ]]
then
printf "$cyan"    "Fetching List From $UPCHECK Located At The IP address Of "$SOURCEIP"."
wget -q -O $BTEMPFILE $source
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && $source == *.php && -n $SOURCEIP ]]
then
printf "$cyan"    "Fetching List From $UPCHECK Located At The IP address Of "$SOURCEIP"."
curl -s -L $source >> $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && -z $SOURCEIP ]]
then
MIRRORVAR=true
printf "$cyan"    "Attempting To Fetch List From Git Repo Mirror."
echo "* $BASEFILENAME List Unavailable To Download. Attempted to use Mirror. $timestamp" | tee --append $RECENTRUN &>/dev/null
#wget -q -O $BTEMPFILE $MIRROREDFILEDL
#cat $BTEMPFILE >> $BORIGINALFILETEMP
#rm $BTEMPFILE
cat $MIRROREDFILE >> $BORIGINALFILETEMP
elif
[[ -z $FULLSKIPPARSING && -z $SOURCEIP && $f != $BDEADPARSELIST ]]
then
MIRRORVAR=true
printf "$cyan"    "Attempting To Fetch List From Git Repo Mirror."
echo "* $BASEFILENAME List Unavailable To Download. Attempted to use Mirror. $timestamp" | tee --append $RECENTRUN &>/dev/null
#wget -q -O $BTEMPFILE $MIRROREDFILEDL
#cat $BTEMPFILE >> $BORIGINALFILETEMP
#rm $BTEMPFILE
cp $MIRROREDFILE $BORIGINALFILETEMP
mv $f $BDEADPARSELIST
elif
[[ -z $FULLSKIPPARSING && $source == *.zip && -n $SOURCEIP ]]
then
printf "$cyan"    "Fetching zip List From $UPCHECK Located At The IP Of "$SOURCEIP"."
wget -q -O $COMPRESSEDTEMPSEVEN $source
7z e -so $COMPRESSEDTEMPSEVEN > $BTEMPFILE
cp $MIRROREDFILE $BORIGINALFILETEMP
rm $COMPRESSEDTEMPSEVEN
elif
[[ -z $FULLSKIPPARSING && $source == *.7z && -n $SOURCEIP ]]
then
printf "$cyan"    "Fetching 7zip List From $UPCHECK Located At The IP Of "$SOURCEIP"."
wget -q -O $COMPRESSEDTEMPSEVEN $source
7z e -so $COMPRESSEDTEMPSEVEN > $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $COMPRESSEDTEMPSEVEN
elif
[[ -z $FULLSKIPPARSING && $source == *.tar.gz && -n $SOURCEIP ]]
then
printf "$cyan"    "Fetching Tar List From $UPCHECK Located At The IP Of "$SOURCEIP"."
wget -q -O $COMPRESSEDTEMPTAR $source
TARFILEX=$(tar -xavf "$COMPRESSEDTEMPTAR" -C "$TEMPDIR")
mv "$TEMPDIR""$TARFILEX" $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $COMPRESSEDTEMPTAR
fi

## If lst file is in Dead Folder, it means that I was unable to access it at some point
## This checks to see if the list is back online
if
[[ -z $FULLSKIPPARSING ]]
then
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if
[[ -z $FULLSKIPPARSING && -n $SOURCEIP && "$FETCHFILESIZE" -gt 0 && $f == $BDEADPARSELIST ]]
then
printf "$red"     "$BASEFILENAME List Is In DeadList Directory, But The Link Is Active."
echo "* $BASEFILENAME List Is In DeadList Directory, But The Link Is Active. $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $BDEADPARSELIST $BMAINLIST
fi

## Check that there was a file downloaded
## Try as a browser, and then try a mirror file
if
[[ -z $FULLSKIPPARSING ]]
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
touch $BORIGINALFILETEMP
echo ""
fi
if 
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 && $source != *.7z && $source != *.tar.gz && $source != *.zip ]]
then
printf "$cyan"    "Attempting To Fetch List As if we were a browser."
agent="User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.89 Safari/537.36"
curl -s -H "$agent" -L $source >> $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
echo ""
fi
if
[[ -z $FULLSKIPPARSING ]]
then
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if 
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 && -z $MIRRORVAR ]]
then
printf "$red"    "File Empty."
printf "$cyan"    "Attempting To Fetch List From Git Repo Mirror."
echo "* $BASEFILENAME List Failed To Download. Attempted to use Mirror. $timestamp" | tee --append $RECENTRUN &>/dev/null
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
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO && `grep -q "?php" "$BORIGINALFILETEMP"` ]]
then
printf "$red"     "$BASEFILENAME List is a bad link. PHP detected."
echo "* $BASEFILENAME Is A Bad Link. PHP Detected. $timestamp" | tee --append $RECENTRUN &>/dev/null
FILESIZEZERO=true
elif
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO && `grep -q "DOCTYPE html" "$BORIGINALFILETEMP"` ]]
then
printf "$red"     "$BASEFILENAME Is A Bad Link. HTML Detected."
echo "* $BASEFILENAME Is A Bad Link. HTML Detected. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BORIGINALFILETEMP
touch $BORIGINALFILETEMP
FILESIZEZERO=true
fi

####################
## Check Filesize ##
####################

## Throughout the script, if the file has no content, it will skip to the end
## by setting the FILESIZEZERO variable

printf "$cyan"    "Verifying $BASEFILENAME File Size."

## set filesizezero variable if empty
if
[[ -z $FULLSKIPPARSING ]]
then
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if 
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
timestamp=$(echo `date`)
printf "$red"     "$BASEFILENAME List Was An Empty File After Download."
echo "* $BASEFILENAME List Was An Empty File After Download. $timestamp" | tee --append $RECENTRUN &>/dev/null
touch $BORIGINALFILETEMP
elif
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -gt 0 ]]
then
ORIGFILESIZENOTZERO=true
HOWMANYLINES=$(echo -e "`wc -l $BORIGINALFILETEMP | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After Download."
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZEMB MB."
printf "$yellow"  "$ENDCOMMENT"
echo ""
fi

## Duplicate the downloaded file for the next steps
touch $BORIGINALFILETEMP
if
ls $BORIGINALFILETEMP &> /dev/null;
then
cp $BORIGINALFILETEMP $BTEMPFILE
cp $BORIGINALFILETEMP $BFILETEMP
rm $BORIGINALFILETEMP
fi

####################
## Create Mirrors ##
####################

printf "$cyan"   "Attempting Creation of Mirror File."

if
[[ -n $FULLSKIPPARSING ]]
then
printf "$green"  "Old Mirror File Retained."
echo ""
fi

## This helps when replacing the mirrored file
if 
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && -f $MIRROREDFILE ]]
then
printf "$green"  "Old Mirror File Removed"
rm $MIRROREDFILE
fi

## Github has a 100mb limit, and empty files are useless
if
[[ -z $FULLSKIPPARSING ]]
then
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO ]]
then
printf "$red"     "Not Creating Mirror File. Nothing To Create!"
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && "$FETCHFILESIZEMB" -ge "$GITHUBLIMITMB" ]]
then
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo "* $BASEFILENAME list was $FETCHFILESIZEMB MB, and too large to mirror on github. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && "$FETCHFILESIZEMB" -lt "$GITHUBLIMITMB" ]]
then
printf "$green"  "Creating Mirror Of Unparsed File."
mv $BTEMPFILE $MIRROREDFILE
fi
echo ""

####################
## Processing     ##
####################

## I haven't decided what to do with IP Lists yet, so this will skip them after mirroring
if
[[ -z $FULLSKIPPARSING && $f == $BIPPARSELIST ]]
then
FILESIZEZERO=true
fi

## Comments #'s and !'s .'s
PARSECOMMENT="Removing Lines With Comments."
if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/\#\+/d; /\!\+/d; /^[.]/d' | grep -v '\^.' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
fi
if
[[ -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Content Filtering and IP addresses
PARSECOMMENT="Removing Content Filtering Lines and IP Addresses."
if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/^https\?:\/\//d; /third-party$/d; /popup$/d; s/^PRIMARY\s\+[ \t]*//; s/^localhost\s\+[ \t]*//; s/blockeddomain.hosts\s\+[ \t]*//; s/^0.0.0.0\s\+[ \t]*//; s/^127.0.0.1\s\+[ \t]*//; s/^::1\s\+[ \t]*//' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
sudo mv $BTEMPFILE $BFILETEMP
fi
if
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Empty Space
PARSECOMMENT="Removing Lines With Empty Space."
if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed 's/\s\+$//; /^$/d; /[[:blank:]]/d' > $BTEMPFILE
#cat $BFILETEMP | sed '/^$/d; /\s\+/d' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
fi
if
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
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
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Invalid Characters
## FQDN's  can only have . _ and -
## apparently you can have an emoji domain name?
PARSECOMMENT="Removing Invalid FQDN Characters."
if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/,/d; s/"/'\''/g; /\"\//d; /[+]/d; /[\]/d; /[/]/d; /[<]/d; /[>]/d; /[?]/d; /[*]/d; /[@]/d; /~/d; /[`]/d; /[=]/d; /[:]/d; /[;]/d; /[%]/d; /[&]/d; /[(]/d; /[)]/d; /[$]/d; /\[\//d; /\]\//d; /[{]/d; /[}]/d; /[][]/d; /\^\//d; s/^||//; /[|]/d' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
fi
if
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Domain Requirements,, a period and a letter
PARSECOMMENT="Checking For FQDN Requirements."
if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/[a-z]/!d; /[.]/!d; /[a-z]$/!d; /^[.]/d' | grep -v '\^.' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
fi
if
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Invalid TLD's
PARSECOMMENT="Checking For Invalid TLD's."
if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cp $BFILETEMP $TEMPFILEA
for source in `cat $VALIDDOMAINTLD`;
do
HOWMANYTIMESTLD=$(echo -e "`grep -o [.]$source\$ $TEMPFILEA | wc -l`")
if
[[ "$HOWMANYTIMESTLD" != 0 ]]
then
cat $TEMPFILEA | sed '/[\.$source]$/Id' > $TEMPFILEB
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
fi
done
gawk 'NR==FNR{a[$0];next} !($0 in a)' $TEMPFILEA $BFILETEMP > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
fi
if
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
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
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Duplicate Removal
PARSECOMMENT="Removing Duplicate Lines."
if
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat -s $BFILETEMP | sort -u | gawk '{if (++dup[$0] == 1) print $0;}' > $BTEMPFILE
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
HOWMANYLINES=$(echo -e "`wc -l $BTEMPFILE | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
mv $BTEMPFILE $BFILETEMP
fi
if
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -eq 0 ]]
then
printf "$red"  "$ENDCOMMENT $SKIPPINGTOENDOFPARSERLOOP"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
elif
[[ -z $FULLSKIPPARSING && -n $ENDCOMMENT && $HOWMANYLINES -gt 0 ]]
then
printf "$yellow"  "$ENDCOMMENT"
echo ""
unset ENDCOMMENT
unset HOWMANYLINES
fi
if
[[ -z $FULLSKIPPARSING && "$FETCHFILESIZE" -eq 0 ]]
then
FILESIZEZERO=true
fi

## Prepare for next step
mv $BFILETEMP $BTEMPFILE

####################
## Complete Lists ##
#################### 

printf "$cyan"   "Attempting Creation Of Parsed List."

## if we skipped parsing due to file not changing
if
[[ -n $FULLSKIPPARSING && -f $PARSEDFILE ]]
then
HOWMANYLINES=$(echo -e "`wc -l $PARSEDFILE | cut -d " " -f 1`")
printf "$green"  "Old Parsed File Retained."
printf "$yellow"  "$HOWMANYLINES Lines In File."
echo ""
elif
[[ -n $FULLSKIPPARSING && ! -f $PARSEDFILE ]]
then
printf "$red"  "No Existing Parsed File?"
fi

## this helps with replacing a parsed file
if 
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && -f $PARSEDFILE ]]
then
printf "$green"  "Old Parsed File Removed"
rm $PARSEDFILE
fi

## Delete Parsed file if current parsing method empties it
if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO && -n $ORIGFILESIZENOTZERO && -f $PARSEDFILE ]]
then
printf "$red"  "Current Parsing Method Emptied File. Old File Removed."
rm $PARSEDFILE
fi

## let's get rid of the deadweight
if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO && -n $ORIGFILESIZENOTZERO ]]
then
printf "$red"  "Current Parsing Method Emptied File. It will be skipped in the future."
echo "* $BASEFILENAME List Was Killed By The Parsing Process. It will be skipped in the future. $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $f $KILLTHELIST
fi

## Github has a 100mb limit, and empty files are useless
if
[[ -z $FULLSKIPPARSING ]]
then
FETCHFILESIZE=$(stat -c%s "$BTEMPFILE")
FETCHFILESIZEMB=`expr $FETCHFILESIZE / 1024 / 1024`
timestamp=$(echo `date`)
fi
if 
[[ -z $FULLSKIPPARSING && -n $FILESIZEZERO ]]
then
printf "$red"     "Not Creating Parsed File. Nothing To Create!"
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && "$FETCHFILESIZEMB" -ge "$GITHUBLIMITMB" ]]
then
printf "$red"     "Parsed File Too Large For Github. Deleting."
echo "* $BASEFILENAME list was $FETCHFILESIZEMB MB, and too large to push to github. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BTEMPFILE
elif
[[ -z $FULLSKIPPARSING && -z $FILESIZEZERO && "$FETCHFILESIZEMB" -lt "$GITHUBLIMITMB" ]]
then
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZEMB MB."
printf "$green"  "Parsed File Completed Succesfully."
echo "* $BASEFILENAME list was Updated. $timestamp" | tee --append $RECENTRUN &>/dev/null
mv $BTEMPFILE $PARSEDFILE
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

if
[[ -n $FULLSKIPPARSING ]]
then
unset FULLSKIPPARSING
fi

if
[[ -n $MAYBESKIPPARSING ]]
then
unset MAYBESKIPPARSING
fi

if
[[ -n $DIDWECHECKONLINEFILE ]]
then
unset DIDWECHECKONLINEFILE
fi

## End File Loop
done
