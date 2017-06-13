#!/bin/bash
## This runs towards the beginning of the script to avoid
## file collisions that might cause errors.
##
## I added file checks to reduce on-screen errors

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Creating RecentRunLog."

## Recent Run Log
timestamp=$(echo `date`)
if 
ls $RECENTRUN &> /dev/null; 
then
sudo rm $RECENTRUN
sudo echo "## Recent Run Log. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
sudo echo "RecentRunLog Removed and Recreated. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "RecentRunLog Created. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Clearing the Path."
timestamp=$(echo `date`)
sudo echo "## Clearing The Path $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

## Stuff to remove if there

WHATITIS="Whitelist File"
CHECKME=/etc/piholeparser/whitelisted/whitelist.domains
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS removed $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS  $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Heavy Parsing Folder txt files"
CHECKME=/etc/piholeparser/lists/heavyparsing/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Light Parsing Folder txt files"
CHECKME=/etc/piholeparser/lists/lightparsing/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="7zip Parsing Folder txt files"
CHECKME=/etc/piholeparser/lists/7zip/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Tar Parsing Folder txt files"
CHECKME=/etc/piholeparser/lists/tar/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Old Parsed Folder txt files"
CHECKME=/etc/piholeparser/parsed/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Locally Hosted Biglist"
CHECKME=/var/www/html/lists/1111ALLPARSEDLISTS1111.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="All Parsed List"
CHECKME=$BIGAPL
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="All Parsed List (edited)"
CHECKME=$BIGAPLE
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="parsedall Directory txt"
CHECKME=/etc/piholeparser/parsedall/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="The Source List"
CHECKME=$BIGAPLSOURCE
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Old Mirrored Lists"
CHECKME=/etc/piholeparser/mirroredlists/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="txt Files in the lists directory"
CHECKME=/etc/piholeparser/lists/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="7z Files"
CHECKME=/etc/piholeparser/lists/7zip/*.7z
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Tar Files"
CHECKME=/etc/piholeparser/lists/tar/*.tar.gz
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "$WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "$WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

## MAKE THESE DIRECTORIES

WHATITIS="whitelisted directory"
CHECKME=/etc/piholeparser/whitelisted/
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo echo "$WHATITIS Already there no need to mkdir. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo mkdir $CHECKME
sudo echo "$WHATITIS Created. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="web host lists directory"
CHECKME=/var/www/html/lists/
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo echo "$WHATITIS Already there no need to mkdir. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo mkdir $CHECKME
sudo echo "$WHATITIS Created. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""
