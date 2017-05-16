#!/bin/bash
## This will convert non-subscribable lists
mkdir /var/www/html/compressedconvert

## Dependency
sudo apt-get install -y p7zip

## Airelle's Anti-Sex Hosts
sudo wget http://rlwpx.free.fr/WPFF/hsex.7z -P /etc/piholeparser/compressedconvert/
sudo 7za e /etc/piholeparser/compressedconvert/hsex.7z
sudo rm /etc/piholeparser/compressedconvert/hsex.7z
sudo cp /etc/piholeparser/compressedconvert/hsex/hosts /var/www/html/compressedconvert/AirellesAntiSexHosts.txt
sudo rm -r /etc/piholeparser/compressedconvert/hsex
