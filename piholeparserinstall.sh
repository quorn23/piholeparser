#!/bin/sh
{ if
which whiptail >/dev/null;
then
:
else
sudo apt-get install -y whiptail
fi }
{ if 
(whiptail --title "piholeparser" --yes-button "yes" --no-button "No" --yesno "Do you want to install piholeparser?" 10 80) 
then
sudo git clone https://github.com/deathbybandaid/piholeparser.git /etc/piholeparser/
{ if 
(whiptail --title "piholeparser" --yes-button "Local Only" --no-button "I'll be uploading to Github" --yesno "What version do you plan on using" 10 80) 
then
sudo cp /etc/piholeparser/piholeparserlocal.sh /etc/piholeparserlocal.sh
(crontab -l ; echo "## piholeparser") | crontab -
(crontab -l ; echo "20 0 * * * sudo bash /etc/piholeparserlocal.sh") | crontab -
(crontab -l ; echo "") | crontab -
else
sudo cp /etc/piholeparser/piholeparsergithub.sh /etc/piholeparsergithub.sh
(crontab -l ; echo "## piholeparser") | crontab -
(crontab -l ; echo "20 0 * * * sudo bash /etc/piholeparsergithub.sh") | crontab -
(crontab -l ; echo "") | crontab -
## End of Version Installs
fi }
## User said no to installing
else
exit
fi }
