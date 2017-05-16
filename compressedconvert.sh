#!/bin/bash
## This will convert non-subscribable lists

##########################################################################
## Download, Extract, and Name List Files.                              ##
##########################################################################

## Airelle's Anti-Sex Hosts
sudo wget http://rlwpx.free.fr/WPFF/hsex.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hsex.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.sex /etc/piholeparser/compressedconvert/AirellesAntiSexHosts.text

## Airelle's Malware Hosts
sudo wget http://rlwpx.free.fr/WPFF/hrsk.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hrsk.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.rsk /etc/piholeparser/compressedconvert/AirellesMalwareHosts.text

## Airelle's Anti-Trackers Hosts
sudo wget http://rlwpx.free.fr/WPFF/htrc.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/htrc.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.trc /etc/piholeparser/compressedconvert/AirellesAntiTrackersHosts.text

## Airelle's Anti-Advertisements Hosts
sudo wget http://rlwpx.free.fr/WPFF/hpub.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hpub.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.pub /etc/piholeparser/compressedconvert/AirellesAntiAdvertisementsHosts.text

## Airelle's Anti-Miscellaneous Hosts
sudo wget http://rlwpx.free.fr/WPFF/hmis.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hmis.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.mis /etc/piholeparser/compressedconvert/AirellesAntiMiscellaneousHosts.text

## Airelle's Phishing Hosts
sudo wget http://rlwpx.free.fr/WPFF/hblc.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hblc.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.blc /etc/piholeparser/compressedconvert/AirellesPhishingHosts.text

##########################################################################

## Set File Directory
FILES=/etc/piholeparser/compressedconvert/*.text

## Start File Loop
for f in $FILES
do

## Begin
sudo mv $f "$f"ads.txt

## Filter
echo -e "\nFiltering non-url content..."
sudo perl /etc/piholeparser/parser.pl "$f"ads.txt > "$f"ads_parsed.txt
sudo rm "$f"ads.txt
echo -e "\t`wc -l "$f"ads_parsed.txt | cut -d " " -f 1` lines after parsing"

## Duplicate Removal
echo -e "\nRemoving duplicates..."
sort -u "$f"ads_parsed.txt > "$f"ads_unique.txt
sudo rm "$f"ads_parsed.txt
echo -e "\t`wc -l "$f"ads_unique.txt | cut -d " " -f 1` lines after deduping"
sudo cat "$f"ads_unique.txt >> "$f".txt
sudo rm "$f"ads_unique.txt

## End File Loop
done

## Move Files
mkdir /etc/piholeparser/compressedconvert/test
#mv /etc/piholeparser/lists/*.txt /etc/piholeparser/parsed/
mv /etc/piholeparser/compressedconvert/*.txt /etc/piholeparser/compressedconvert/test
#sudo rename "s/.text.txt/.txt/" /etc/piholeparser/parsed/*.txt
sudo rename "s/.text.txt/.txt/" /etc/piholeparser/compressedconvert/test/*.txt

## Delete Empty Files
sudo find /etc/piholeparser/compressedconvert/test/ -size 0 -delete

## Unset FILES variable
unset FILES
