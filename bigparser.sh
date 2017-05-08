#!/bin/bash
sudo rm -r /etc/piholeparser/lists/*.txt
sudo rm -r /etc/piholeparser/parsed/*.txt
FILES=/etc/piholeparser/lists/*.lst

for f in $FILES
do

for source in `cat $f`; 
do
    echo $source;
    sudo curl --silent $source >> /etc/piholeparser/"$f"ads.txt
    echo -e "\t`wc -l /etc/piholeparser/"$f"ads.txt | cut -d " " -f 1` lines downloaded"
done


echo -e "\nFiltering non-url content..."
sudo perl /etc/piholeparser/parser.pl /etc/piholeparser/"$f"ads.txt > /etc/piholeparser/"$f"ads_parsed.txt
sudo rm /etc/piholeparser/"$f"ads.txt
echo -e "\t`wc -l /etc/piholeparser/"$f"ads_parsed.txt | cut -d " " -f 1` lines after parsing"

echo -e "\nRemoving duplicates..."
sort -u /etc/piholeparser/"$f"ads_parsed.txt > /etc/piholeparser/"$f"ads_unique.txt
sudo rm /etc/piholeparser/"$f"ads_parsed.txt
echo -e "\t`wc -l /etc/piholeparser/"$f"ads_unique.txt | cut -d " " -f 1` lines after deduping"

sudo cat /etc/piholeparser/"$f"ads_unique.txt >> /etc/piholeparser/parsed/"$f".txt
sudo rm /etc/piholeparser/"$f"ads_unique.txt
done
