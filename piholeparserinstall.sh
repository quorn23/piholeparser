#!/bin/sh
## This script helps install the parser
##
## It checks if it's already installed
## and removes "old version" files
## It may spit out errors such as
## File does not exist
##
## It also sets the variable for the installation

## Install Variables
INSTALLPLACE=/etc/piholeparser/

## Check for whiptail
{ if
which whiptail >/dev/null;
then
:
else
apt-get install -y whiptail
fi }

## Check for previous install
if
[[ -f $INSTALLPLACE ]]
then
PREVIOUSINSTALL=true
fi

## Remove Prior install
if
[[ -z $PREVIOUSINSTALL ]]
then
{ if
(whiptail --title "piholeparser" --yes-button "Remove beore install" --no-button "Abort" --yesno "piholeparser is already installed?" 10 80) 
then
rm -r /etc/piholeparser
rm /etc/updaterunpiholeparser.sh
crontab -l | grep -v 'sudo bash /etc/updaterunpiholeparser.sh'  | crontab -
else
exit
fi }
fi

## obvious question
{ if
(whiptail --title "piholeparser" --yes-button "yes" --no-button "no" --yesno "Do You want to install piholeparser?" 10 80) 
then
git clone https://github.com/deathbybandaid/piholeparser.git /etc/piholeparser/
cp /etc/piholeparser/scripts/updaterunpiholeparser.sh /etc/updaterunpiholeparser.sh
(crontab -l ; echo "20 0 * * * sudo bash /etc/updaterunpiholeparser.sh") | crontab -
else
exit
fi }

## Save a pervious config?
if
[[ -z $PREVIOUSINSTALL ]]
then
{ if
(whiptail --title "piholeparser" --yes-button "keep config" --no-button "create new config" --yesno "Keep a previous config?" 10 80) 
then
echo "keeping old config"
else
rm /etc/piholeparser.var
cp /etc/piholeparser/scriptvars/piholeparser.var /etc/piholeparser.var
fi }
fi

## What version?
if
[[ -n $PREVIOUSINSTALL ]]
then
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
fi
