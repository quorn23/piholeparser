#!/bin/bash

sudo mv /etc/piholeparser/lists/*.ads.txt /etc/piholeparser/mirroredlists/
sudo rename "s/.lst.ads.txt/.txt/" /etc/piholeparser/mirroredlists/*.txt
sudo rm /etc/piholeparser/mirroredlists/1111ALLPARSEDLISTS1111.txt
