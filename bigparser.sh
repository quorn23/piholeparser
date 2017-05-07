#!/bin/bash
FILES=/etc/piholeparser/lists/*

for f in $FILES
do

for source in `cat $f`; 
do
    echo $source;
    sudo curl --silent $source >> /etc/piholeparser/temp/"$f"ads.txt
    echo -e "\t`wc -l /etc/piholeparser/temp/"$f"ads.txt | cut -d " " -f 1` lines downloaded"
done


echo -e "\nFiltering non-url content..."
sudo perl /etc/piholeparser/parser.pl /etc/piholeparser/temp/"$f"ads.txt > /etc/piholeparser/temp/"$f"ads_parsed.txt
sudo rm /etc/piholeparser/temp/"$f"ads.txt
echo -e "\t`wc -l /etc/piholeparser/temp/"$f"ads_parsed.txt | cut -d " " -f 1` lines after parsing"

echo -e "\nRemoving duplicates..."
sort -u /etc/piholeparser/temp/"$f"ads_parsed.txt > /etc/piholeparser/temp/"$f"ads_unique.txt
sudo rm /etc/piholeparser/temp/"$f"ads_parsed.txt
echo -e "\t`wc -l /etc/piholeparser/temp/"$f"ads_unique.txt | cut -d " " -f 1` lines after deduping"

sudo cat /etc/piholeparser/temp/"$f"ads_unique.txt >> /etc/piholeparser/filtered/"$f"filtered.txt
sudo rm /etc/piholeparser/temp/"$f"ads_unique.txt
done
