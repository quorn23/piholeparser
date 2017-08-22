#!/bin/bash

## Variables
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi

## whiptail required
if
which whiptail >/dev/null;
then
:
else
printf "$yellow"  "Installing whiptail"
apt-get install -y whiptail
fi

#########################
## Clean Mirror Folder ##
#########################

echo "Cleaning Mirror Directory"
CHECKME=$MIRROREDLISTSALL
if
[[ -f $CHECKME ]]
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
[[ -f $CHECKME ]]
then
rm $CHECKME
fi
echo ""

#########################
## Revert Killed Lists ##
#########################

echo "Reverting Killed Lists"
if
[[ -f $KILLTHELISTALL ]]
then
for f in $KILLTHELISTALL
do
# Dynamic Variables
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
if
[[ -f $DYNOVARS ]]
then
source $DYNOVARS
else
echo "Dynamic Vars File Missing, Exiting."
exit
fi
mv $f "$MAINLISTDIR""$BASEFILENAME".lst
done
fi
echo ""

#####################
## Clean TLD Lists ##
#####################

echo "Cleaning TLD Lists"
if
[[ -f $CLEANTLDS ]]
then
rm $CLEANTLDS
fi

if
[[ -f $VALIDDOMAINTLDBKUP ]]
then
rm $VALIDDOMAINTLDBKUP
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
