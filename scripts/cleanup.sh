#!/bin/bash
## This script Cleans up directories 
## mainly to avoid pushing excess files to Github

## Variables
source /etc/piholeparser/scriptvars/variables.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Cleaning Up."
timestamp=$(echo `date`)
sudo echo "## Cleanup $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

## Clean list directories

WHATITIS="Heavy Parsing Folder txt files"
CHECKME=/etc/piholeparser/lists/heavyparsing/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Light Parsing Folder txt files"
CHECKME=/etc/piholeparser/lists/lightparsing/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="7zip Parsing Folder txt files"
CHECKME=/etc/piholeparser/lists/7zip/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Tar Parsing Folder txt files"
CHECKME=/etc/piholeparser/lists/tar/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="7z Files"
CHECKME=/etc/piholeparser/lists/7zip/*.7z
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="Tar Files"
CHECKME=/etc/piholeparser/lists/tar/*.tar.gz
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="txt Files in the lists directory"
CHECKME=/etc/piholeparser/lists/*.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

WHATITIS="garbage txt Files in the mirrored directory"
CHECKME=/etc/piholeparser/mirroredlists/*.orig.txt
timestamp=$(echo `date`)
if
ls $CHECKME &> /dev/null;
then
sudo rm $CHECKME
sudo echo "* $WHATITIS Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
else
sudo echo "* $WHATITIS Not Removed. $timestamp" | sudo tee --append $RECENTRUN &>/dev/null
fi

## Clean parsed directory if using locally
if 
[ "$version" = "local" ]
then
sudo rm /etc/piholeparser/parsed/*.txt
else
:
fi

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Updating Readme file."

timestamp=$(echo `date`)
sudo echo "## Updating README.md $timestamp" | sudo tee --append $RECENTRUN &>/dev/null

sudo rm $READMEVAR
#sudo sed "s/LASTRUNVARIABLEGOESHERE/$TIMESTAMP/" $READMEVARD > $READMEVAR
sudo sed "s|LASTRUNVARIABLEGOESHERE|$TIMESTAMP|g" $READMEVARD > $READMEVAR

sudo echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""
