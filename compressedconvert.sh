#!/bin/bash
## This will convert non-subscribable lists
mkdir /var/www/html/compressedconvert

## Dependency
{ if
which p7zip >/dev/null;
then
:
else
sudo apt-get install -y p7zip
fi }


## Airelle's Anti-Sex Hosts
sudo wget http://rlwpx.free.fr/WPFF/hsex.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hsex.7z
sudo rm /etc/piholeparser/compressedconvert/hsex.7z
sudo cp /etc/piholeparser/compressedconvert/hsex/hosts /var/www/html/compressedconvert/AirellesAntiSexHosts.txt
sudo rm -r /etc/piholeparser/compressedconvert/hsex

## Airelle's Malware Hosts
sudo wget http://rlwpx.free.fr/WPFF/hrsk.7z -P /etc/piholeparser/compressedconvert/

## Airelle's Anti-Trackers Hosts
sudo wget http://rlwpx.free.fr/WPFF/htrc.7z -P /etc/piholeparser/compressedconvert/

## Airelle's Anti-Advertisements Hosts
sudo wget http://rlwpx.free.fr/WPFF/hpub.7z -P /etc/piholeparser/compressedconvert/

## Airelle's Anti-Miscellaneous Hosts
sudo wget http://rlwpx.free.fr/WPFF/hmis.7z -P /etc/piholeparser/compressedconvert/

## Airelle's Phishing Hosts
sudo wget http://rlwpx.free.fr/WPFF/hblc.7z -P /etc/piholeparser/compressedconvert/
