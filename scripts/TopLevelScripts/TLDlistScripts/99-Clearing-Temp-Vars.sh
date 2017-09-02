#!/bin/bash
## 

## Variables
source ./foldervars.var

if
[[ -f $TEMPPARSEVARS ]]
then
rm $TEMPPARSEVARS
fi
