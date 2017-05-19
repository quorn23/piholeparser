#!/bin/sh

## Colors
source /etc/piholeparser/scripts/colors.var

## Check for whiptail
{ if
which whiptail >/dev/null;
then
:
else
sudo apt-get install -y whiptail
fi }

## Check if already there
{ if
[ -d "/etc/piholeparser/" ] 
then
{ if
(whiptail --title "piholeparser" --yes-button "Remove beore install" --no-button "Abort" --yesno "piholeparser is already installed?" 10 80) 
then
sudo rm -r /etc/piholeparser
sudo rm /etc/piholeparser.var
sudo rm /etc/runpiholeparser.sh
sudo rm /etc/piholeparserlocal.sh
sudo rm /etc/piholeparsergithub.sh
sudo rm /etc/updaterunparser.sh
crontab -l | grep -v 'sudo bash /etc/updaterunpiholeparser.sh'  | crontab -
else
exit
fi }
fi }

## obvious question
{ if
(whiptail --title "piholeparser" --yes-button "yes" --no-button "no" --yesno "Do You want to install piholeparser?" 10 80) 
then
sudo git clone https://github.com/deathbybandaid/piholeparser.git /etc/piholeparser/
#sudo cp /etc/piholeparser/scripts/runpiholeparser.sh /etc/runpiholeparser.sh
sudo cp /etc/piholeparser/scripts/updaterunpiholeparser.sh /etc/updaterunpiholeparser.sh
sudo cp /etc/piholeparser/scripts/piholeparser.var /etc/piholeparser.var
(crontab -l ; echo "20 0 * * * sudo bash /etc/piholeparser/scripts/runpiholeparser.sh") | crontab -
else
exit
fi }

## What version?
{ if 
(whiptail --title "piholeparser" --yes-button "Local Only" --no-button "I'll be uploading to Github" --yesno "What Version of piholeparser to install?" 10 80) 
then
sudo echo "version=local" | sudo tee --append /etc/piholeparser.var
else
sudo echo "version=github" | sudo tee --append /etc/piholeparser.var
GITHUBUSERNAME=$(whiptail --inputbox "Github Username" 10 80 "" 3>&1 1>&2 2>&3)
GITHUBPASSWORD=$(whiptail --inputbox "Github Password" 10 80 "" 3>&1 1>&2 2>&3)
GITHUBEMAIL=$(whiptail --inputbox "Github Email Address" 10 80 "" 3>&1 1>&2 2>&3)
sudo echo "GITHUBUSERNAME="$GITHUBUSERNAME"" | sudo tee --append /etc/piholeparser.var
sudo echo "GITHUBPASSWORD="$GITHUBPASSWORD"" | sudo tee --append /etc/piholeparser.var
sudo echo "GITHUBEMAIL="$GITHUBEMAIL"" | sudo tee --append /etc/piholeparser.var
fi }
