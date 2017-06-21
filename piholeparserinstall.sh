#!/bin/sh
## This script helps install the parser
##
## It checks if it's already installed
## and removes "old version" files
## It may spit out errors such as
## File does not exist
##
## It also sets the variable for the installation


## Check for whiptail
{ if
which whiptail >/dev/null;
then
:
else
apt-get install -y whiptail
fi }

## Check if already there
{ if
[ -d "/etc/piholeparser/" ] 
then
{ if
(whiptail --title "piholeparser" --yes-button "Remove beore install" --no-button "Abort" --yesno "piholeparser is already installed?" 10 80) 
then
rm -r /etc/piholeparser
rm /etc/piholeparser.var
rm /etc/updaterunpiholeparser.sh
crontab -l | grep -v 'sudo bash /etc/updaterunpiholeparser.sh'  | crontab -
else
exit
fi }
fi }

## obvious question
{ if
(whiptail --title "piholeparser" --yes-button "yes" --no-button "no" --yesno "Do You want to install piholeparser?" 10 80) 
then
git clone https://github.com/deathbybandaid/piholeparser.git /etc/piholeparser/
cp /etc/piholeparser/scripts/updaterunpiholeparser.sh /etc/updaterunpiholeparser.sh
cp /etc/piholeparser/scriptvars/piholeparser.var /etc/piholeparser.var
(crontab -l ; echo "20 0 * * * sudo bash /etc/updaterunpiholeparser.sh") | crontab -
else
exit
fi }

## What version?
{ if 
(whiptail --title "piholeparser" --yes-button "Local Only" --no-button "I'll be uploading to Github" --yesno "What Version of piholeparser to install?" 10 80) 
then
echo "version=local" | tee --append /etc/piholeparser.var
else
echo "version=github" | tee --append /etc/piholeparser.var
GITHUBUSERNAME=$(whiptail --inputbox "Github Username" 10 80 "" 3>&1 1>&2 2>&3)
GITHUBPASSWORD=$(whiptail --inputbox "Github Password" 10 80 "" 3>&1 1>&2 2>&3)
GITHUBEMAIL=$(whiptail --inputbox "Github Email Address" 10 80 "" 3>&1 1>&2 2>&3)
echo "GITHUBUSERNAME="$GITHUBUSERNAME"" | tee --append /etc/piholeparser.var
echo "GITHUBPASSWORD="$GITHUBPASSWORD"" | tee --append /etc/piholeparser.var
echo "GITHUBEMAIL="$GITHUBEMAIL"" | tee --append /etc/piholeparser.var
fi }
