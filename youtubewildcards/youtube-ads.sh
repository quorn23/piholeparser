#!/bin/bash
## Youtube adblocking

## Directory Location
YTDOMAINS=/etc/piholeparser/youtubewildcards/youtube-domains.txt
YTFILTERED=/etc/piholeparser/youtubewildcards/youtube-filtered.txt
YTADS=/etc/piholeparser/youtubewildcards/youtube-ads.txt
APIPY=/etc/piholeparser/youtubewildcards/API.py
#RDOMAINS=
#KDOMAINS=
#ZDOMAINS=
#7DOMAINS=
#SDOMAINS=
#EDOMAINS=
#RDOMAINS=
#DDOMAINS=
#YDOMAINS=
#6DOMAINS=
#LDOMAINS=

## Cleanup
if 
ls $YTDOMAINS &> /dev/null; 
then
sudo rm $YTDOMAINS
else
:
fi

if 
ls $YTFILTERED &> /dev/null; 
then
sudo rm $YTFILTERED
else
:
fi

if 
ls $YTADS &> /dev/null; 
then
$YTADS
else
:
fi

sudo python $APIPY > $YTDOMAINS
sudo grep "^r" $YTDOMAINS > $YTFILTERED
sudo sed 's/\s.*$//' $YTFILTERED > $YTADS
sudo cp $YTADS $YTSIFT

#greps the log for youtube ads and appends to /var/www/html/lists/youtube.txt
#sudo grep r*.googlevideo.com /var/log/pihole.log | awk '{print $6}'| grep -v '^googlevideo.com\|redirector' | sort -nr | uniq >> /var/www/html/lists/youtube.txt

#removes duplicate lines from /var/www/html/lists/youtube.txt
#sudo perl -i -ne 'print if ! $x{$_}++' /var/www/html/lists/youtube.txt
