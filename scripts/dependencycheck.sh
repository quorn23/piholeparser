#!/bin/bash
## This is where any script dependencies will go.
## It checks if it is installed, and if not,
## it installs the program

## Variables
source /etc/piholeparser/scripts/scriptvars/variables.var

#######################
## Check Dependencies##
#######################

WHATITIS=p7zip-full
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS $DEPENDENCYA"
else
printf "$yellow"  "$DEPENDENCYB $WHATITIS"
apt-get install -y $WHATITIS
fi

WHATITIS=gawk
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS $DEPENDENCYA"
else
printf "$yellow"  "$DEPENDENCYB $WHATITIS"
apt-get install -y $WHATITIS
fi
