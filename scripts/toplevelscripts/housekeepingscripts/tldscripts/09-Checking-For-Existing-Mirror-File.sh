#!/bin/bash
##

## Variables
source ./foldervars.var

if
[[ -f $CURRENTTLDLIST ]]
then
printf "$green"  "Mirror File Currently Available."
else
printf "$red"  "Mirror File Currently Unavailable."
fi
