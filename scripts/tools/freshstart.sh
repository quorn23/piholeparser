#!/bin/bash

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

#########################
## Clean Mirror Folder ##
#########################
echo "Cleaning Mirror Directory"
CHECKME=$MIRROREDLISTSALL
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
echo ""

#########################
## Clean Parsed Folder ##
#########################
echo "Cleaning Parsed Directory"
CHECKME=$PARSEDLISTSALL
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
echo ""

#########################
## Revert Killed Lists ##
#########################
echo "Reverting Killed Lists"
for f in $KILLTHELISTALL
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
mv $f "$MAINLISTDIR""$BASEFILENAME".lst
done
echo ""

#####################
## Clean TLD Lists ##
#####################
echo "Cleaning TLD Lists"
CHECKME=$CLEANTLDS
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi

CHECKME=$VALIDDOMAINTLDBKUP
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
echo ""

###############################
## Push Changes up to Github ##
###############################
timestamp=$(echo `date`)
WHYYOUDODIS=$(whiptail --inputbox "Why are you doing a manual push?" 10 80 " $timestamp" 3>&1 1>&2 2>&3)
echo "Pushing Lists to Github"
git -C $REPODIR pull
git -C $REPODIR remote set-url origin $GITWHERETOPUSH
git -C $REPODIR add .
git -C $REPODIR commit -m "$WHYYOUDODIS"
git -C $REPODIR push -u origin master
