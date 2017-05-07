#!/bin/bash
for source in `cat /etc/piholeparser/lists/$NAMEOFLIST.lst`; do
    echo $source;
    sudo curl --silent $source >> /etc/piholeparser/temp/"$NAMEOFLIST"ads.txt
    echo -e "\t`wc -l /etc/piholeparser/temp/"$NAMEOFLIST"ads.txt | cut -d " " -f 1` lines downloaded"
done

echo -e "\nFiltering non-url content..."
sudo perl /etc/piholeparser/parser.pl /etc/piholeparser/temp/"$NAMEOFLIST"ads.txt > /etc/piholeparser/temp/"$NAMEOFLIST"ads_parsed.txt
sudo rm /etc/piholeparser/temp/"$NAMEOFLIST"ads.txt
echo -e "\t`wc -l /etc/piholeparser/temp/"$NAMEOFLIST"ads_parsed.txt | cut -d " " -f 1` lines after parsing"

echo -e "\nRemoving duplicates..."
sort -u /etc/piholeparser/temp/"$NAMEOFLIST"ads_parsed.txt > /etc/piholeparser/temp/"$NAMEOFLIST"ads_unique.txt
sudo rm /etc/piholeparser/temp/"$NAMEOFLIST"ads_parsed.txt
echo -e "\t`wc -l /etc/piholeparser/temp/"$NAMEOFLIST"ads_unique.txt | cut -d " " -f 1` lines after deduping"

sudo cat /etc/piholeparser/temp/"$NAMEOFLIST"ads_unique.txt >> /etc/piholeparser/filtered/"$NAMEOFLIST"filtered.txt
sudo rm /etc/piholeparser/temp/"$NAMEOFLIST"ads_unique.txt
