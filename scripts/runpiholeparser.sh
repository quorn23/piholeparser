#!/bin/bash
## This is the central script that ties the others together

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

####################
## Housekeeping   ##
####################

SCRIPTTEXT="Running Housekeeping Tasks."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
bash $DELETETEMPFILE
bash $HOUSEKEEPINGSCRIPT
bash $DELETETEMPFILE
echo ""
echo "" | sudo tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Dependencies   ##
####################

WHATSCRIPTORUN=$DEPENDENCYCHECKSCRIPT
SCRIPTTEXT="Checking For Script Dependencies."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Script Domains ##
####################

WHATSCRIPTORUN=$REPODOMAINSSCRIPT
SCRIPTTEXT="Compiling Repo Domain List."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Parsing        ##
####################

WHATSCRIPTORUN=$PARSERSCRIPT
SCRIPTTEXT="Running Parser."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## ALLPARSEDLISTS ##
####################

WHATSCRIPTORUN=$CREATEBIGLISTSCRIPT
SCRIPTTEXT="Combining All Parsed Lists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Results        ##
####################

WHATSCRIPTORUN=$RESULTSSCRIPT
SCRIPTTEXT="Results Of The Parsing."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Push Lists     ##
####################

## This looked prettier below, but wasn't getting pushed up.
echo "* Script completed at $timestamp" | tee --append $RECENTRUN &>/dev/null

WHATSCRIPTORUN=$PUSHLISTSSCRIPT
SCRIPTTEXT="Pushing Lists."
timestamp=$(echo `date`)
printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
bash $WHATSCRIPTORUN
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$magenta" "___________________________________________________________"
echo ""

####################
## Script Complete##
####################

printf "$blue"    "___________________________________________________________"
echo ""
printf "$cyan"   "Script Complete"
echo ""
printf "$magenta" "___________________________________________________________"
echo ""
