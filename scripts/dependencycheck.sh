#!/bin/bash
## This is where any script dependencies will go.
## It checks if it is installed, and if not,
## it installs the program

## Version
source /etc/piholeparser.var

## Colors
source /etc/piholeparser/scripts/colors.var

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Checking Dependencies"

if
which p7zip >/dev/null;
then
echo ""
printf "$yellow"  "p7zip is installed"
else
printf "$yellow"  "Installing p7zip"
sudo apt-get install -y p7zip-full
fi


#if
#which python >/dev/null;
#then
#echo ""
#printf "$yellow"  "python is installed"
#else
#printf "$yellow"  "Installing python"
#sudo apt-get install -y python
#fi

#if
#which python-pip >/dev/null;
#then
#echo ""
#printf "$yellow"  "python-pip is installed"
#else
#printf "$yellow"  "Installing python-pip"
#sudo apt-get install -y python-pip
#fi

#if
#pip list --format=legacy | grep -F requests >/dev/null;
#then
#echo ""
#printf "$yellow"  "pip module requests is installed"
#else
#printf "$yellow"  "Installing pip module requests"
#sudo pip install requests
#fi

#if
#pip list --format=legacy | grep -F beautifulsoup4 >/dev/null;
#then
#echo ""
#printf "$yellow"  "pip module beautifulsoup4 is installed"
#else
#printf "$yellow"  "Installing pip module beautifulsoup4"
#sudo pip install beautifulsoup4
#fi

printf "$magenta" "___________________________________________________________"
echo ""
