#!/bin/bash
## This will convert non-subscribable lists

sudo rm -r /etc/piholeparser/compressedconvert/*.txt

## Dependency check
{ if
which p7zip >/dev/null;
then
:
else
sudo apt-get install -y p7zip-full
fi }

## Airelle's Anti-Sex Hosts
sudo wget http://rlwpx.free.fr/WPFF/hsex.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hsex.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.sex /etc/piholeparser/compressedconvert/AirellesAntiSexHosts.txt

## Airelle's Malware Hosts
sudo wget http://rlwpx.free.fr/WPFF/hrsk.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hrsk.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.rsk /etc/piholeparser/compressedconvert/AirellesMalwareHosts.txt

## Airelle's Anti-Trackers Hosts
sudo wget http://rlwpx.free.fr/WPFF/htrc.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/htrc.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.trc /etc/piholeparser/compressedconvert/AirellesAntiTrackersHosts.txt

## Airelle's Anti-Advertisements Hosts
sudo wget http://rlwpx.free.fr/WPFF/hpub.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hpub.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.pub /etc/piholeparser/compressedconvert/AirellesAntiAdvertisementsHosts.txt

## Airelle's Anti-Miscellaneous Hosts
sudo wget http://rlwpx.free.fr/WPFF/hmis.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hmis.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.mis /etc/piholeparser/compressedconvert/AirellesAntiMiscellaneousHosts.txt

## Airelle's Phishing Hosts
sudo wget http://rlwpx.free.fr/WPFF/hblc.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hblc.7z -o/etc/piholeparser/compressedconvert/
sudo mv /etc/piholeparser/compressedconvert/Hosts.blc /etc/piholeparser/compressedconvert/AirellesPhishingHosts.txt

## Cleanup
sudo rm /etc/piholeparser/compressedconvert/*.7z

## Process txt files
# /etc/piholeparser/compressedconvert/
# sudo rm -r /etc/piholeparser/compressedconvert/*.txt
