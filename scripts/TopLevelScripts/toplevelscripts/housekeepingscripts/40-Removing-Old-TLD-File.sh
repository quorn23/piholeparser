#!/bin/bash
## This downloads the valid tld lists

## Variables
source ./foldervars.var

SCRIPTTEXT="Checking For Old TLD File."
printf "$cyan"    "$SCRIPTTEXT"
echo "### $SCRIPTTEXT" | sudo tee --append $RECENTRUN &>/dev/null
if
[[ -f $VALIDDOMAINTLD ]]
then
printf "$cyan"    "Old TLD List Removed."
rm $VALIDDOMAINTLD
echo "* Old TLD List Removed." | tee --append $RECENTRUN &>/dev/null
else
printf "$cyan"    "Old TLD List Not Present."
echo "* Old TLD List Not Present." | tee --append $RECENTRUN &>/dev/null
fi
