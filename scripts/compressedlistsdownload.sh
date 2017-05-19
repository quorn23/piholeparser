#!/bin/bash

## Colors
source /etc/piholeparser/scripts/colors.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading and Extracting Compressed Lists."

## Airelle's Anti-Sex Hosts
if ping -c 1 rlwpx.free.fr &> /dev/null
then

## Filter domain name
UPCHECK=`echo rlwpx.free.fr | awk -F/ '{print $3}'`

##Fetch IP of source
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Sex Hosts"
echo ""
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"
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

## Filter domain name
UPCHECK=`echo rlwpx.free.fr | awk -F/ '{print $3}'`

##Fetch IP of source
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Malware Hosts"
echo ""
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"
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

## Filter domain name
UPCHECK=`echo rlwpx.free.fr | awk -F/ '{print $3}'`

##Fetch IP of source
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Trackers Hosts"
echo ""
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"
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

## Filter domain name
UPCHECK=`echo rlwpx.free.fr | awk -F/ '{print $3}'`

##Fetch IP of source
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Advertisements Hosts"
echo ""
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"
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

## Filter domain name
UPCHECK=`echo rlwpx.free.fr | awk -F/ '{print $3}'`

##Fetch IP of source
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`

##Fetch IP of source
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Airelle's Anti-Miscellaneous Hosts"
echo ""
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"
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

## Filter domain name
UPCHECK=`echo rlwpx.free.fr | awk -F/ '{print $3}'`

##Fetch IP of source
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Airelle's Phishing Hosts"
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"
echo ""
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
if ping -c 1 github.com &> /dev/null
then

## Filter domain name
UPCHECK=`echo github.com | awk -F/ '{print $3}'`

##Fetch IP of source
SOURCEIPFETCH=`ping -c 1 $UPCHECK | gawk -F'[()]' '/PING/{print $2}'`
SOURCEIP=`echo $SOURCEIPFETCH`

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Downloading Blackweb List"
echo ""
printf "$yellow"    "Fetching List from $UPCHECK located at the IP of $SOURCEIP"
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
else
echo ""
printf "$red"     "BlackWeb list are unavailable right now"
echo ""
fi
