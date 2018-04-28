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
REPONAME=piholeparser
REPOOWNER=deathbybandaid
INSTALLPLACE=/etc/"$REPONAME"/

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
(whiptail --title "$REPONAME" --yes-button "Remove beore install" --no-button "Abort" --yesno "$REPONAME is already installed?" 10 80) 
then
rm -r /etc/"$REPONAME"
rm /etc/updaterun"$REPONAME".sh
crontab -l | grep -v 'sudo bash /etc/"$REPONAME".sh'  | crontab -
else
exit
fi }
fi

## obvious question
{ if
(whiptail --title ""$REPONAME"" --yes-button "yes" --no-button "no" --yesno "Do You want to install "$REPONAME"?" 10 80) 
then
git clone https://github.com/"$REPOOWNER"/"$REPONAME".git /etc/"$REPONAME"/
cp /etc/"$REPONAME"/scripts/updaterun"$REPONAME".sh /etc/updaterun"$REPONAME".sh
(crontab -l ; echo "20 0 * * * sudo bash /updaterun"$REPONAME".sh") | crontab -
else
exit
fi }

## Save a pervious config?
if
[[ -z $PREVIOUSINSTALL ]]
then
{ if
(whiptail --title ""$REPONAME"" --yes-button "keep config" --no-button "create new config" --yesno "Keep a previous config?" 10 80) 
then
echo "keeping old config"
else
rm /etc/"$REPONAME".var
cp /etc/"$REPONAME"/scriptvars/"$REPONAME".var /etc/"$REPONAME".var
fi }
fi

## What version?
if
[[ -n $PREVIOUSINSTALL ]]
then
{ if 
(whiptail --title ""$REPONAME"" --yes-button "Local Only" --no-button "I'll be uploading to Github" --yesno "What Version of "$REPONAME" to install?" 10 80) 
then
echo "version=local" | tee --append /etc/"$REPONAME".var
else
echo "version=github" | tee --append /etc/"$REPONAME".var
GITHUBUSERNAME=$(whiptail --inputbox "Github Username" 10 80 "" 3>&1 1>&2 2>&3)
GITHUBPASSWORD=$(whiptail --inputbox "Github Password" 10 80 "" 3>&1 1>&2 2>&3)
GITHUBEMAIL=$(whiptail --inputbox "Github Email Address" 10 80 "" 3>&1 1>&2 2>&3)
echo "GITHUBUSERNAME="$GITHUBUSERNAME"" | tee --append /etc/"$REPONAME".var
echo "GITHUBPASSWORD="$GITHUBPASSWORD"" | tee --append /etc/"$REPONAME".var
echo "GITHUBEMAIL="$GITHUBEMAIL"" | tee --append /etc/"$REPONAME".var
fi }
fi
[Return To Repository](https://github.com/deathbybandaid/piholeparser/)
[Return To Main](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/Mainlog.md)
[Go Up One Level](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/TopLevelScripts/15-Processing-Top-Level-Domains.md)
____________________________________
# LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp
## Processing LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp List.
## Setting Temporary Parsing Variables
## Checking If Multiple Sources
## The Source In The File To Download Is
## Checking For HTTPS
## Checking For Existing Mirror File
## Pinging Source To Check Host Availability
## Checking If List Updated Online
## Determining Download Attempt
## Attempting To Download List
## Checking File Size
## Attempting Creation Of Mirror File
## Clearing Temp Vars
[Return To Repository](https://github.com/deathbybandaid/piholeparser/)
[Return To Main](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/Mainlog.md)
[Go Up One Level](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/TopLevelScripts/30-Processing-Blacklists.md)
____________________________________
# LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md
[Return To Repository](https://github.com/deathbybandaid/piholeparser/)
[Return To Main](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/Mainlog.md)
[Go Up One Level](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/TopLevelScripts/15-Processing-Top-Level-Domains.md)
____________________________________
# LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md temp.md.md
## Processing LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md temp.md.md List.
## Setting Temporary Parsing Variables
## Checking If Multiple Sources
## The Source In The File To Download Is
## Checking For HTTPS
## Checking For Existing Mirror File
## Pinging Source To Check Host Availability
## Checking If List Updated Online
## Determining Download Attempt
## Attempting To Download List
## Checking File Size
## Attempting Creation Of Mirror File
## Clearing Temp Vars
[Return To Repository](https://github.com/deathbybandaid/piholeparser/)
[Return To Main](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/Mainlog.md)
[Go Up One Level](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/TopLevelScripts/30-Processing-Blacklists.md)
____________________________________
# LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md temp.md.md temp.md.md.md
[Return To Repository](https://github.com/deathbybandaid/piholeparser/)
[Return To Main](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/Mainlog.md)
[Go Up One Level](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/TopLevelScripts/15-Processing-Top-Level-Domains.md)
____________________________________
# LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md temp.md.md temp.md.md.md temp.md.md.md.md
## Processing LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md temp.md.md temp.md.md.md temp.md.md.md.md List.
## Setting Temporary Parsing Variables
## Checking If Multiple Sources
## The Source In The File To Download Is
## Checking For HTTPS
## Checking For Existing Mirror File
## Pinging Source To Check Host Availability
## Checking If List Updated Online
## Determining Download Attempt
## Attempting To Download List
## Checking File Size
## Attempting Creation Of Mirror File
## Clearing Temp Vars
[Return To Repository](https://github.com/deathbybandaid/piholeparser/)
[Return To Main](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/Mainlog.md)
[Go Up One Level](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/TopLevelScripts/30-Processing-Blacklists.md)
____________________________________
# LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md temp.md.md temp.md.md.md temp.md.md.md.md temp.md.md.md.md.md
[Return To Repository](https://github.com/deathbybandaid/piholeparser/)
[Return To Main](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/Mainlog.md)
[Go Up One Level](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/TopLevelScripts/30-Processing-Blacklists.md)
____________________________________
# LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md temp.md.md temp.md.md.md temp.md.md.md.md temp.md.md.md.md.md temp.md.md.md.md.md.md
[Return To Repository](https://github.com/deathbybandaid/piholeparser/)
[Return To Main](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/Mainlog.md)
[Go Up One Level](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/TopLevelScripts/30-Processing-Blacklists.md)
____________________________________
# LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md temp.md.md temp.md.md.md temp.md.md.md.md temp.md.md.md.md.md temp.md.md.md.md.md.md temp.md.md.md.md.md.md.md
[Return To Repository](https://github.com/deathbybandaid/piholeparser/)
[Return To Main](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/Mainlog.md)
[Go Up One Level](https://github.com/deathbybandaid/piholeparser/blob/dev-nomerge/RecentRunLogs/TopLevelScripts/30-Processing-Blacklists.md)
____________________________________
# LICENSE MirroredFiles README.md RecentRunLogs ScriptLsts Subscribable-Lists piholeparserinstall.sh scripts temp temp.md temp.md.md temp.md.md.md temp.md.md.md.md temp.md.md.md.md.md temp.md.md.md.md.md.md temp.md.md.md.md.md.md.md temp.md.md.md.md.md.md.md.md
