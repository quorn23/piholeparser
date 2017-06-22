#!/bin/bash
## This is the Parsing Process

## Variables
source /etc/piholeparser/scriptvars/staticvariables.var

####################
## File .lst's    ##
####################

## Process Every .lst file within the List Directories
for f in $EVERYLISTFILEWILDCARD
do

printf "$lightblue"    "___________________________________________________________"
echo ""

## Process Every source within the .lst from above
for source in `cat $f`;
do

## These Variables are to help with Filenaming
source /etc/piholeparser/scriptvars/dynamicvariables.var

printf "$green"    "Processing $BASEFILENAME list."
echo "" 
printf "$cyan"    "The Source In The File Is:"
printf "$yellow"    "$source"
echo "" 

####################
## Download Lists ##
####################

printf "$cyan"    "Pinging $BASEFILENAME To Check Host Availability."

## Check to see if source's host is online
if
[[ -n $UPCHECK ]]
then
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`
else
printf "$red"    "$BASEFILENAME Host Unavailable."
fi
if
[[ -n $SOURCEIP ]]
then
printf "$green"    "Ping Test Was A Success!"
else
printf "$red"    "Ping Test Failed."
fi
echo ""

## Logically download based on the Upcheck, and file type
if
[[ -n $SOURCEIP && $source != *.7z && $source != *.tar.gz ]]
then
printf "$cyan"    "Fetching List From $UPCHECK Located At The IP address Of "$SOURCEIP"."
wget -q -O $BTEMPFILE $source
cat $BTEMPFILE >> $BORIGINALFILETEMP
touch $BORIGINALFILETEMP
rm $BTEMPFILE
elif
[[ -z $SOURCEIP ]]
then
printf "$cyan"    "Attempting To Fetch List From Git Repo Mirror."
echo "* $BASEFILENAME List Unavailable To Download. Attempted to use Mirror. $timestamp" | tee --append $RECENTRUN &>/dev/null
wget -q -O $BTEMPFILE $MIRROREDFILEDL
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $BTEMPFILE
elif
[[ $source == *.7z && -n $SOURCEIP ]]
then
printf "$cyan"    "Fetching 7zip List from $UPCHECK located at the IP of "$SOURCEIP"."
wget -q -O $COMPRESSEDTEMPSEVEN $source
7z e -so $COMPRESSEDTEMPSEVEN > $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $COMPRESSEDTEMPSEVEN
elif
[[ $source == *.tar.gz && -n $SOURCEIP ]]
then
printf "$cyan"    "Fetching Tar List from $UPCHECK located at the IP of "$SOURCEIP"."
wget -q -O $COMPRESSEDTEMPTAR $source
TARFILEX=$(tar -xavf "$COMPRESSEDTEMPTAR" -C "$TEMPDIR")
mv "$TEMPDIR""$TARFILEX" $BTEMPFILE
cat $BTEMPFILE >> $BORIGINALFILETEMP
rm $COMPRESSEDTEMPTAR
else
printf "$red"    "Somehow All Download Variables Were Missed."
echo "* $BASEFILENAME List Skipped All Variable Checks at Download. $timestamp" | tee --append $RECENTRUN &>/dev/null
fi

## Check that there was a file downloaded
## If not, touch file
CHECKME=$BORIGINALFILETEMP
if
ls $CHECKME &> /dev/null;
then
printf "$green"    "Download Successful."
else
printf "$red"    "Download Failed."
touch $BORIGINALFILETEMP
fi
echo ""

## This Clears the SourceIP var before the next loop
if
[[ -n $SOURCEIP ]]
then
unset SOURCEIP
fi

## This is the source Loop end
## If multiple sources, it should merge them into one document
done

## If lst file is in Dead Folder, it means that I was unable to access it at some point
## This checks to see if the list is back online
if
[[ -n $FILESIZEZERO && $f == $BDEADPARSELIST ]]
then
printf "$red"     "$BASEFILENAME List is in DeadList folder, but the link is active."
echo "* $BASEFILENAME List is in DeadList folder, but the link is active. $timestamp" | tee --append $RECENTRUN &>/dev/null
else
:
fi

## This should let me know if a document is a bad link
if
[[ -n $FILESIZEZERO && `grep -q "?php" "$BORIGINALFILETEMP"` ]]
then
printf "$red"     "$BASEFILENAME List is a bad link. PHP detected."
echo "* $BASEFILENAME is a bad link. PHP detected. $timestamp" | tee --append $RECENTRUN &>/dev/null
FILESIZEZERO=true
elif
[[ -n $FILESIZEZERO && `grep -q "DOCTYPE html" "$BORIGINALFILETEMP"` ]]
then
printf "$red"     "$BASEFILENAME List is a bad link. HTML detected."
echo "* $BASEFILENAME is a bad link. HTML detected. $timestamp" | tee --append $RECENTRUN &>/dev/null
FILESIZEZERO=true
else
:
fi

####################
## Check Filesize ##
####################

## Throughout the script, if the file has no content, it will skip to the end
## by setting the FILESIZEZERO variable

printf "$cyan"    "Verifying $BASEFILENAME File Size."

PARSECOMMENT="Download."
FETCHFILESIZE=$(stat -c%s "$BORIGINALFILETEMP")
timestamp=$(echo `date`)
if 
[ "$FETCHFILESIZE" -eq 0 ]
then
FILESIZEZERO=true
timestamp=$(echo `date`)
printf "$red"     "$BASEFILENAME List Was An Empty File After "$PARSECOMMENT"."
echo "* $BASEFILENAME list was an empty file upon download. $timestamp" | tee --append $RECENTRUN &>/dev/null
else
HOWMANYLINES=$(echo -e "`wc -l $BORIGINALFILETEMP | cut -d " " -f 1`")
ENDCOMMENT="$HOWMANYLINES Lines After $PARSECOMMENT"
printf "$yellow"  "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
printf "$yellow"  "$ENDCOMMENT"
fi
echo ""

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
printf "$green"  "Old Mirror File removed"
rm $MIRROREDFILE
fi

## Github has a 100mb limit, and empty files are useless
timestamp=$(echo `date`)
if 
[[ -n $FILESIZEZERO ]]
then
printf "$red"     "Not Creating Mirror File. Nothing To Create!"
rm $BTEMPFILE
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]]
then
printf "$red"     "Mirror File Too Large For Github. Deleting."
echo "* $BASEFILENAME list was $FETCHFILESIZE bytes, and too large to mirror on github. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BTEMPFILE
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZE" -lt "$GITHUBLIMIT" ]]
then
printf "$green"  "Creating Mirror of Unparsed File."
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

## Comments #'s and !'s, also empty space
PARSECOMMENT="Removing Lines with Comments and Empty Space."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/^\s*#/d; s/[#]/\'$'\n/g; /[#]/d; /[!]/d; /^$/d; / /d' > $BTEMPFILE
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
PARSECOMMENT="Removing Invalid FQDN characters."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/[,]/d; s/"/'\''/g; /\"\//d; /[+]/d; /[\]/d; /[/]/d; /[<]/d; /[>]/d; /[?]/d; /[*]/d; /[#]/d; /[!]/d; /[@]/d; /[~]/d; /[`]/d; /[=]/d; /[:]/d; /[;]/d; /[%]/d; /[&]/d; /[(]/d; /[)]/d; /[$]/d; /\[\//d; /\]\//d; /[{]/d; /[}]/d; /[][]/d; /\^\//d' > $BTEMPFILE
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

#####################################################################
## Perl Parser
## We skip this if the file is in the "heavy" directory
## I hope to remove this soon
PARSECOMMENT="Cutting Lists with the Perl Parser."
if
[[ -n $FILESIZEZERO && $f == $BLIGHTPARSELIST ]]
then
printf "$cyan"  "$PARSECOMMENT"
perl /etc/piholeparser/scripts/parser.pl $BFILETEMP > $BTEMPFILE
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

#####################################################################

## Pipes
PARSECOMMENT="Removing Pipes."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat -s $BFILETEMP | sed 's/^||//; /[|]/d' > $BTEMPFILE
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

## Remove IP addresses
PARSECOMMENT="Removing IP Addresses."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed 's/^PRIMARY[ \t]*//; s/^localhost[ \t]*//; s/blockeddomain.hosts[ \t]*//; s/^0.0.0.0[ \t]*//; s/^127.0.0.1[ \t]*//; s/^::1[ \t]*//' > $BTEMPFILE
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
PARSECOMMENT="Checking for FQDN Requirements."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/[a-z]/!d; /[.]/!d' > $BTEMPFILE
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

## Periods at begining and end of lines
## This should fix Wildcarding
PARSECOMMENT="Removing Lines With a Period at the Start or End."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/^[.]/d; /[.]$/d' | grep -v '\.$' | grep -v '\^.' > $BTEMPFILE
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

## File Extensions
PARSECOMMENT="Removing Common File Extensions."
if
[[ -z $FILESIZEZERO ]]
then
printf "$cyan"  "$PARSECOMMENT"
cat $BFILETEMP | sed '/gif$/d; /htm$/d; /html$/d; /php$/d; /png$/d; /swf$/d; /jpg$/d; /cgi$/d; /js$/d' > $BTEMPFILE
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

printf "$cyan"   "Attempting Creation of Parsed List."

## this helps with replacing a parsed file
if 
[[ -z $FILESIZEZERO && -f $PARSEDFILE ]]
then
printf "$green"  "Old Parsed File removed"
rm $PARSEDFILE
fi

## Github has a 100mb limit, and empty files are useless
timestamp=$(echo `date`)
if 
[[ -n $FILESIZEZERO ]]
then
printf "$red"     "Not Creating Parsed File. Nothing To Create!"
rm $BTEMPFILE
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZE" -ge "$GITHUBLIMIT" ]]
then
printf "$red"     "Parsed File Too Large For Github. Deleting."
echo "* $BASEFILENAME list was $FETCHFILESIZE bytes, and too large to push to github. $timestamp" | tee --append $RECENTRUN &>/dev/null
rm $BTEMPFILE
elif
[[ -z $FILESIZEZERO && "$FETCHFILESIZE" -lt "$GITHUBLIMIT" ]]
then
printf "$yellow"     "Size of $BASEFILENAME = $FETCHFILESIZE bytes."
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
