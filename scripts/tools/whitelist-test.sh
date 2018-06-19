#!/bin/bash
## This should help me find what parsed list contains a domain

## Variables
SCRIPTDIRA=$(dirname $0)
source "$SCRIPTDIRA"/foldervars.var

if [[ ! -f $COMBINEDBLACKLISTS ]]
then
  printf "$red"  "Big Black List File Missing."
  touch $COMBINEDBLACKLISTS
fi

## Check if white list is present
if [[ ! -f $COMBINEDWHITELISTS ]]
then
  printf "$red"  "Big White List File Missing."
  touch $COMBINEDWHITELISTS
fi

DOMAINTOLOOKFOR=$(whiptail --inputbox "What Domain Whould be Whitelisted?" 10 80 "" 3>&1 1>&2 2>&3)

BLACKHOWMANYLINES=$(echo -e "`wc -l $COMBINEDBLACKLISTS | cut -d " " -f 1`")
echo "Black file is $BLACKHOWMANYLINES lines"
WHITEHOWMANYLINES=$(echo -e "`wc -l $COMBINEDWHITELISTS | cut -d " " -f 1`")
echo "White file is $WHITEHOWMANYLINES lines"

if grep -q $DOMAINTOLOOKFOR "$COMBINEDWHITELISTS"
then
  echo "Found on Big WhiteList"
  WHITEHOWMANYLINES=$(echo -e "`wc -l $COMBINEDWHITELISTS | cut -d " " -f 1`")
  echo "Big List Contains $WHITEHOWMANYLINES lines."
  echo " "

  echo ""
  echo "Using Method 1 comm"
  comm -23 $COMBINEDBLACKLISTS $COMBINEDWHITELISTS > $FILETEMP
  METHODHOWMANYLINES=$(echo -e "`wc -l $FILETEMP | cut -d " " -f 1`")
  echo "new file is $METHODHOWMANYLINES lines"
  if grep -q $DOMAINTOLOOKFOR "$FILETEMP"
  then
    echo "$DOMAINTOLOOKFOR in file."
  else
    echo "$DOMAINTOLOOKFOR not in file."
  fi
  rm $FILETEMP
  echo ""

  echo "Using Method 2 gawk"
  gawk 'NR==FNR{a[$0];next} !($0 in a)' $COMBINEDWHITELISTS $COMBINEDBLACKLISTS >> $FILETEMP
  METHODHOWMANYLINES=$(echo -e "`wc -l $FILETEMP | cut -d " " -f 1`")
  echo "new file is $METHODHOWMANYLINES lines"
  if grep -q $DOMAINTOLOOKFOR "$FILETEMP"
  then
    echo "$DOMAINTOLOOKFOR in file."
  else
    echo "$DOMAINTOLOOKFOR not in file."
  fi
  rm $FILETEMP
  echo ""

  echo "Using Method 3 grep"
  grep -Fvxf $COMBINEDWHITELISTS $COMBINEDBLACKLISTS >> $FILETEMP
  METHODHOWMANYLINES=$(echo -e "`wc -l $FILETEMP | cut -d " " -f 1`")
  echo "new file is $METHODHOWMANYLINES lines"
  if grep -q $DOMAINTOLOOKFOR "$FILETEMP"
  then
    echo "$DOMAINTOLOOKFOR in file."
  else
    echo "$DOMAINTOLOOKFOR not in file."
  fi
  rm $FILETEMP
  echo ""
  
  echo "Using Method 4 diff"
  diff -a --suppress-common-lines $COMBINEDWHITELISTS $COMBINEDBLACKLISTS | grep '> ' | sed 's/> //' >> $FILETEMP
  METHODHOWMANYLINES=$(echo -e "`wc -l $FILETEMP | cut -d " " -f 1`")
  echo "new file is $METHODHOWMANYLINES lines"
  if grep -q $DOMAINTOLOOKFOR "$FILETEMP"
  then
    echo "$DOMAINTOLOOKFOR in file."
  else
    echo "$DOMAINTOLOOKFOR not in file."
  fi
  rm $FILETEMP
  echo ""
  
  echo "Using Method 5 Loop Echo"
  for WHITEDOMAINTOLOOKFOR in `cat $COMBINEDWHITELISTS`;
  do
    if grep -q $WHITEDOMAINTOLOOKFOR "$COMBINEDBLACKLISTS"
    then
      for BLACKLISTDOMAIN in `cat $COMBINEDBLACKLISTS`;
      do
        if [[ $WHITEDOMAINTOLOOKFOR != $BLACKLISTDOMAIN ]]
        then
          echo "$BLACKLISTDOMAIN" | tee --append $FILETEMP &>/dev/null
        fi
      done
    fi
  done
  METHODHOWMANYLINES=$(echo -e "`wc -l $FILETEMP | cut -d " " -f 1`")
  echo "new file is $METHODHOWMANYLINES lines"
  if grep -q $DOMAINTOLOOKFOR "$FILETEMP"
  then
    echo "$DOMAINTOLOOKFOR in file."
  else
    echo "$DOMAINTOLOOKFOR not in file."
  fi
  rm $FILETEMP
  echo ""
  


else
  echo "Not Found on Big WhiteList"
fi

