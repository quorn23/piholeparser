#!/bin/bash
sudo rm -r /etc/piholeparser/lists/*.txt
sudo rm -r /etc/piholeparser/parsed/*.txt
FILES=/etc/piholeparser/lists/*.lst

for f in $FILES
do
for source in `cat $f`;
do
    echo $f;
    sudo curl --silent $f >> "$f"ads.txt
    sudo curl --silent $f >> "$f"ads.txt
    echo -e "\t`wc -l "$f"ads.txt | cut -d " " -f 1` lines downloaded"
done

#echo -e "\nFiltering non-url content..."
#sudo perl /etc/piholeparser/parser.pl "$f"ads.txt > "$f"ads_parsed.txt
#sudo rm "$f"ads.txt
#echo -e "\t`wc -l "$f"ads_parsed.txt | cut -d " " -f 1` lines after parsing"

#echo -e "\nRemoving duplicates..."
#sort -u "$f"ads_parsed.txt > "$f"ads_unique.txt
#sudo rm "$f"ads_parsed.txt
#echo -e "\t`wc -l "$f"ads_unique.txt | cut -d " " -f 1` lines after deduping"

#sudo cat "$f"ads_unique.txt >> /etc/piholeparser/parsed/"$f".txt
#sudo rm "$f"ads_unique.txt
done
