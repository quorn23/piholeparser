#!/bin/bash

printf "$blue"    "___________________________________________________________"
echo ""
printf "$green"   "Checking Dependencies"
{ if
which p7zip >/dev/null;
then
echo ""
printf "$yellow"  "p7zip is installed"
else
printf "$yellow"  "Installing p7zip"
sudo apt-get install -y p7zip-full
fi }
printf "$magenta" "___________________________________________________________"
echo ""
