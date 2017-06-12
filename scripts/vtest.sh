#!/bin/bash

## Variables
source /etc/piholeparser/scriptvars/variables.var

{ if 
[ "$version" = "github" ]
then
printf "$green"   "Pushing Lists to Github"
else
printf "$red"   "Not Pushing Lists to Github"
fi }
