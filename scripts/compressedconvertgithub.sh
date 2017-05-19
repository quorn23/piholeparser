#!/bin/bash
## This will convert non-subscribable lists

##########################################################################
## Download, Extract, and Name List Files.                              ##
##########################################################################

## Colors
source /etc/piholeparser/scripts/colors.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading and Extracting Compressed Lists."


## Airelle's lists gave me issues, so I built in a pingtest

## Airelle's Anti-Sex Hosts
if ping -c 1 rlwpx.free.fr &> /dev/null
then
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Sex Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/hsex.7z -P /etc/piholeparser/compressedconvert/
printf "$yellow"  "Extracting"
echo ""
sudo 7za e /etc/piholeparser/compressedconvert/hsex.7z -o/etc/piholeparser/compressedconvert/
printf "$yellow"  "Renaming"
echo ""
sudo mv /etc/piholeparser/compressedconvert/Hosts.sex /etc/piholeparser/compressedconvert/AirellesAntiSexHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"
else
echo ""
printf "$red"     "Airelle's lists are unavailable right now"
echo ""
fi

## Airelle's Malware Hosts
if ping -c 1 rlwpx.free.fr &> /dev/null
then
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Malware Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/hrsk.7z -P /etc/piholeparser/compressedconvert/
printf "$yellow"  "Extracting"
echo ""
sudo 7za e /etc/piholeparser/compressedconvert/hrsk.7z -o/etc/piholeparser/compressedconvert/
printf "$yellow"  "Renaming"
echo ""
sudo mv /etc/piholeparser/compressedconvert/Hosts.rsk /etc/piholeparser/compressedconvert/AirellesMalwareHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"
else
echo ""
printf "$red"     "Airelle's lists are unavailable right now"
echo ""
fi

## Airelle's Anti-Trackers Hosts
if ping -c 1 rlwpx.free.fr &> /dev/null
then
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Trackers Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/htrc.7z -P /etc/piholeparser/compressedconvert/
printf "$yellow"  "Extracting"
echo ""
sudo 7za e /etc/piholeparser/compressedconvert/htrc.7z -o/etc/piholeparser/compressedconvert/
printf "$yellow"  "Renaming"
echo ""
sudo mv /etc/piholeparser/compressedconvert/Hosts.trc /etc/piholeparser/compressedconvert/AirellesAntiTrackersHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"
else
echo ""
printf "$red"     "Airelle's lists are unavailable right now"
echo ""
fi

## Airelle's Anti-Advertisements Hosts
if ping -c 1 rlwpx.free.fr &> /dev/null
then
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Advertisements Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/hpub.7z -P /etc/piholeparser/compressedconvert/
printf "$yellow"  "Extracting"
echo ""
sudo 7za e /etc/piholeparser/compressedconvert/hpub.7z -o/etc/piholeparser/compressedconvert/
printf "$yellow"  "Renaming"
echo ""
sudo mv /etc/piholeparser/compressedconvert/Hosts.pub /etc/piholeparser/compressedconvert/AirellesAntiAdvertisementsHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"
else
echo ""
printf "$red"     "Airelle's lists are unavailable right now"
echo ""
fi

## Airelle's Anti-Miscellaneous Hosts
if ping -c 1 rlwpx.free.fr &> /dev/null
then
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Miscellaneous Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/hmis.7z -P /etc/piholeparser/compressedconvert/
printf "$yellow"  "Extracting"
echo ""
sudo 7za e /etc/piholeparser/compressedconvert/hmis.7z -o/etc/piholeparser/compressedconvert/
printf "$yellow"  "Renaming"
echo ""
sudo mv /etc/piholeparser/compressedconvert/Hosts.mis /etc/piholeparser/compressedconvert/AirellesAntiMiscellaneousHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"
else
echo ""
printf "$red"     "Airelle's lists are unavailable right now"
echo ""
fi

## Airelle's Phishing Hosts
if ping -c 1 rlwpx.free.fr &> /dev/null
then
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Airelle's Phishing Hosts"
sudo wget http://rlwpx.free.fr/WPFF/hblc.7z -P /etc/piholeparser/compressedconvert/
printf "$yellow"  "Extracting"
echo ""
sudo 7za e /etc/piholeparser/compressedconvert/hblc.7z -o/etc/piholeparser/compressedconvert/
printf "$yellow"  "Renaming"
echo ""
sudo mv /etc/piholeparser/compressedconvert/Hosts.blc /etc/piholeparser/compressedconvert/AirellesPhishingHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"
else
echo ""
printf "$red"     "Airelle's lists are unavailable right now"
echo ""
fi

## Blackweb
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Blackweb List"
echo ""
sudo wget https://github.com/maravento/blackweb/raw/master/blackweb.tar.gz -P /etc/piholeparser/compressedconvert/
printf "$yellow"  "Extracting"
echo ""
sudo tar -xvf /etc/piholeparser/compressedconvert/blackweb.tar.gz -C /etc/piholeparser/compressedconvert
printf "$yellow"  "Renaming"
echo ""
sudo mv /etc/piholeparser/compressedconvert/blackweb.txt /etc/piholeparser/compressedconvert/Blackweb.txt
echo ""
printf "$magenta" "___________________________________________________________"


## Testing filtering the extracted lists seperately

## Set File Directory
FILES=/etc/piholeparser/compressedconvert/*.txt

## Start File Loop
for f in $FILES
do

echo ""
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Processing $f"

sudo mv $f "$f".ads.txt
#sudo curl --silent $f >> "$f".ads.txt
echo -e "\t`wc -l "$f".ads.txt | cut -d " " -f 1` lines downloaded"


## Filter
echo ""
printf "$yellow"  "Filtering non-url content..."
sudo perl /etc/piholeparser/parser/parser.pl "$f".ads.txt > "$f".ads_parsed.txt
echo -e "\t`wc -l "$f".ads_parsed.txt | cut -d " " -f 1` lines after parsing"
sudo rm "$f".ads.txt

## Duplicate Removal
echo ""
printf "$yellow"  "Removing duplicates..."
sort -u "$f".ads_parsed.txt > "$f".ads_unique.txt
sudo rm "$f".ads_parsed.txt
echo -e "\t`wc -l "$f".ads_unique.txt | cut -d " " -f 1` lines after deduping"
sudo cat "$f".ads_unique.txt >> "$f".txt
sudo rm "$f".ads_unique.txt
echo ""
printf "$magenta" "___________________________________________________________"
echo ""

## Remove Empty Files
if 
[ -s "$f".txt ]
then
echo ""
printf "$yellow"  "File will be moved to the parsedall directory."
sudo mv "$f".txt /etc/piholeparser/parsedall/
sudo rename "s/.lst.txt/.txt/" /etc/piholeparser/parsedall/*.txt
else
echo ""
printf "$red"     "File Empty. It will be deleted."
rm -rf "$f".txt
fi

## Create Mirrors
if 
test $(stat -c%s "$f".ads.txt) -ge 100000000
then
echo ""
printf "$red"     "Mirror File Too Large For Github. Deleting."
sudo rm "$f".ads.txt
else
echo ""
printf "$yellow"  "Creating Mirror of Unparsed File."
sudo mv "$f".ads.txt /etc/piholeparser/mirroredlists/
sudo rename "s/.lst.ads.txt/.txt/" /etc/piholeparser/mirroredlists/*.txt
fi

## End File Loop
done

printf "$magenta" "___________________________________________________________"
echo ""
