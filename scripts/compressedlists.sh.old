#!/bin/bash
## Some lists are not "subscribable" and
## must be downloaded and extracted before parsing.
##
## Airelle gave me troubles, so I added ping tests.
## if a site is down, it will skip to the next list

## Version
source /etc/piholeparser.var

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading and Extracting Compressed Lists."
echo ""

## Airelle UpCheck Start
if ping -c 1 rlwpx.free.fr &> /dev/null
then

## Airelle's Anti-Sex Hosts
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Sex Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/hsex.7z -P $COMPRESSEDDIR
echo ""
printf "$yellow"  "Extracting"
echo ""
sudo 7za e "$COMPRESSEDDIR"hsex.7z -o"$COMPRESSEDDIR"
echo ""
printf "$yellow"  "Renaming"
echo ""
sudo mv "$COMPRESSEDDIR"Hosts.sex "$COMPRESSEDDIR"AirellesAntiSexHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"


## Airelle's Malware Hosts
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Malware Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/hrsk.7z -P $COMPRESSEDDIR
echo ""
printf "$yellow"  "Extracting"
echo ""
sudo 7za e "$COMPRESSEDDIR"hrsk.7z -o"$COMPRESSEDDIR"
echo ""
printf "$yellow"  "Renaming"
echo ""
sudo mv "$COMPRESSEDDIR"Hosts.rsk "$COMPRESSEDDIR"AirellesMalwareHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"

## Airelle's Anti-Trackers Hosts
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Trackers Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/htrc.7z -P $COMPRESSEDDIR
echo ""
printf "$yellow"  "Extracting"
echo ""
sudo 7za e "$COMPRESSEDDIR"htrc.7z -o"$COMPRESSEDDIR"
echo ""
printf "$yellow"  "Renaming"
echo ""
sudo mv "$COMPRESSEDDIR"Hosts.trc "$COMPRESSEDDIR"AirellesAntiTrackersHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"

## Airelle's Anti-Advertisements Hosts
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Advertisements Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/hpub.7z -P $COMPRESSEDDIR
echo ""
printf "$yellow"  "Extracting"
echo ""
sudo 7za e "$COMPRESSEDDIR"hpub.7z -o"$COMPRESSEDDIR"
echo ""
printf "$yellow"  "Renaming"
echo ""
sudo mv "$COMPRESSEDDIR"Hosts.pub "$COMPRESSEDDIR"AirellesAntiAdvertisementsHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"

## Airelle's Anti-Miscellaneous Hosts
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Miscellaneous Hosts"
echo ""
sudo wget http://rlwpx.free.fr/WPFF/hmis.7z -P $COMPRESSEDDIR
echo ""
printf "$yellow"  "Extracting"
echo ""
sudo 7za e "$COMPRESSEDDIR"hmis.7z -o"$COMPRESSEDDIR"
echo ""
printf "$yellow"  "Renaming"
echo ""
sudo mv "$COMPRESSEDDIR"Hosts.mis "$COMPRESSEDDIR"AirellesAntiMiscellaneousHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"

## Airelle's Phishing Hosts
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Airelle's Phishing Hosts"
sudo wget http://rlwpx.free.fr/WPFF/hblc.7z -P $COMPRESSEDDIR
echo ""
printf "$yellow"  "Extracting"
echo ""
sudo 7za e "$COMPRESSEDDIR"hblc.7z -o"$COMPRESSEDDIR"
echo ""
printf "$yellow"  "Renaming"
echo ""
sudo mv "$COMPRESSEDDIR"Hosts.blc "$COMPRESSEDDIR"AirellesPhishingHosts.txt
echo ""
printf "$magenta" "___________________________________________________________"

## Airelle UpCheck End
else
echo ""
printf "$red"     "Airelle's lists are unavailable right now"
echo ""
fi

## Blackweb
if ping -c 1 github.com &> /dev/null
then
printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Blackweb List"
echo ""
sudo wget https://github.com/maravento/blackweb/raw/master/blackweb.tar.gz -P $COMPRESSEDDIR
echo ""
printf "$yellow"  "Extracting"
echo ""
sudo tar -xvf "$COMPRESSEDDIR"blackweb.tar.gz -C $COMPRESSEDDIR
echo ""
printf "$yellow"  "Renaming"
echo ""
sudo mv "$COMPRESSEDDIR"blackweb.txt "$COMPRESSEDDIR"Blackweb.txt
echo ""
printf "$magenta" "___________________________________________________________"
else
echo ""
printf "$red"     "BlackWeb list are unavailable right now"
echo ""
fi

## cleanup
## added this, since when I test, I sometimes stop the script before cleanup, 
## and end up with a directory full of garbage that has to be manually deleted
if 
ls /etc/piholeparser/compressedconvert/*.7z &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.7z
else
:
fi

if 
ls /etc/piholeparser/compressedconvert/*.tar.gz &> /dev/null; 
then
sudo rm /etc/piholeparser/compressedconvert/*.tar.gz
else
:
fi
