#!/bin/bash
## Checks for parsed file

## Variables
source ./foldervars.var

if
[[ -f $PARSEDFILE ]]
then
printf "$green"  "Parsed File Currently Available."
else
printf "$red"  "Parsed File Currently Unavailable."
fi
