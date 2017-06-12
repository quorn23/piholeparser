#!/bin/bash

## Variables
source /etc/piholeparser/scriptvars/variables.var

{ if 
[ "$version" = "github" ]
then
printf "$green"   "Pushing Lists to Github"
elif
[ "$version" = "local" ]
then
printf "$red"   "Not Pushing Lists to Github"
fi }
