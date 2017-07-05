#!/bin/bash
## This should do some initial housekeeping for the script

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

######################
## Recreate Tempvars##
######################

SCRIPTTEXT=$TEMPVARCREATE
timestamp=$(echo `date`)
printf "$lightblue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
CHECKME=$TEMPVARS
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
echo "## $SCRIPTTEXT" | tee --append $TEMPVARS &>/dev/null
source $TEMPVARS
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$orange" "___________________________________________________________"
echo ""

######################
## Set Start Time   ##
######################

SCRIPTTEXT=$SETSTARTTIMEVAR
timestamp=$(echo `date`)
printf "$lightblue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
STARTTIME="$SCRIPTSTARTEDAT $timestamp"
STARTIMEVAR=$(echo $STARTIME)
STARTTIMESTAMP=$(date +"%s")
echo "STARTTIME='"$STARTTIME"'" | tee --append $TEMPVARS &>/dev/null
echo "STARTTIMESTAMP=$STARTTIMESTAMP" | tee --append $TEMPVARS &>/dev/null
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$orange" "___________________________________________________________"
echo ""

######################
## Recent Run Log   ##
######################

SCRIPTTEXT=$RECENTRUNLOGCREATE
timestamp=$(echo `date`)
printf "$lightblue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
if 
ls $RECENTRUN &> /dev/null; 
then
rm $RECENTRUN
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
echo "* $STARTTIME" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$orange" "___________________________________________________________"
echo ""

######################
## https-less lists ##
######################

SCRIPTTEXT=$CREATENOHTTPSLOG
timestamp=$(echo `date`)
printf "$lightblue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
if 
ls $NOHTTPSLISTS &> /dev/null; 
then
rm $NOHTTPSLISTS
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
else
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
fi
for f in $EVERYLISTFILEWILDCARD
do
BASEFILENAME=$(echo `basename $f | cut -f 1 -d '.'`)
for source in `cat $f`;
do
if
[[ $source != https* ]]
then
echo "* $BASEFILENAME" | tee --append $NOHTTPSLISTS &>/dev/null
fi
done
done
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$orange" "___________________________________________________________"
echo ""

#######################
## Parsed Not In Use ##
#######################

SCRIPTTEXT=$REMOVEDELETEDPARSEDLISTS
timestamp=$(echo `date`)
printf "$lightblue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
for f in $EVERYLISTFILEWILDCARD
do
source /etc/piholeparser/scripts/scriptvars/dynamicvariables.var
TEMPOFILE="$TEMPDIR"TEMPOFILE.txt
TEMPOFILEB="$TEMPDIR"TEMPOFILEB.txt
LISTBASENAMETXT="$BASEFILENAME".txt
echo "$LISTBASENAMETXT" | tee --append $FILETEMP &>/dev/null
done
ls $PARSEDDIR > $TEMPFILE
cat $TEMPFILE | sed '/README.md/d' > $TEMPOFILE
gawk 'NR==FNR{a[$0];next} !($0 in a)' $FILETEMP $TEMPOFILE > $TEMPOFILEB
for source in `cat $TEMPOFILEB`;
do
REMPARSEDFILE="$PARSEDDIR""$source"
if
[[ $source == *.txt ]]
then
rm $REMPARSEDFILE
printf "$red"    "$source $REMOVEDELETEDPARSEDLISTSB"
fi
done
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$orange" "___________________________________________________________"
echo ""

#########################
## Mirrored Not In Use ##
#########################

SCRIPTTEXT=$REMOVEDELETEDMIRROREDLISTS
timestamp=$(echo `date`)
printf "$lightblue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
for f in $EVERYLISTFILEWILDCARD
do
source /etc/piholeparser/scripts/scriptvars/dynamicvariables.var
TEMPOFILE="$TEMPDIR"TEMPOFILE.txt
TEMPOFILEB="$TEMPDIR"TEMPOFILEB.txt
LISTBASENAMETXT="$BASEFILENAME".txt
echo "$LISTBASENAMETXT" | tee --append $FILETEMP &>/dev/null
done
ls $MIRRORDIR > $TEMPFILE
cat $TEMPFILE | sed '/README.md/d' > $TEMPOFILE
gawk 'NR==FNR{a[$0];next} !($0 in a)' $FILETEMP $TEMPOFILE > $TEMPOFILEB
for source in `cat $TEMPOFILEB`;
do
REMMIRRORFILE="$MIRRORDIR""$source"
if
[[ $source == *.txt ]]
then
rm $REMMIRRORFILE
printf "$red"    "$source $REMOVEDELETEDMIRROREDLISTSB"
fi
done
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$orange" "___________________________________________________________"
echo ""

####################
## Big Source     ##
####################

SCRIPTTEXT=$BIGSOURCEGEN
timestamp=$(echo `date`)
printf "$lightblue"    "___________________________________________________________"
echo ""
printf "$cyan"   "$SCRIPTTEXT $timestamp"
echo ""
echo "## $SCRIPTTEXT $timestamp" | tee --append $RECENTRUN &>/dev/null
bash $DELETETEMPFILE
CHECKME=$BIGAPLSOURCE
if
ls $CHECKME &> /dev/null;
then
rm $CHECKME
fi
cat $EVERYLISTFILEWILDCARD | sort > $TEMPFILE
HOWMANYSOURCELISTS=$(echo -e "\t`wc -l $TEMPFILE | cut -d " " -f 1`")
HOWMANYSOURCE="$HOWMANYSOURCELISTS $SCRIPTLISTCOUNT"
echo "HOWMANYSOURCELISTS='"$HOWMANYSOURCELISTS"'" | tee --append $TEMPVARS &>/dev/null
echo "HOWMANYSOURCE='"$HOWMANYSOURCE"'" | tee --append $TEMPVARS &>/dev/null
echo "$HOWMANYSOURCE"
echo "* $HOWMANYSOURCE $timestamp" | tee --append $RECENTRUN &>/dev/null
sed '/^$/d' $TEMPFILE > $FILETEMP
mv $FILETEMP $BIGAPLSOURCE
bash $DELETETEMPFILE
echo ""
echo "" | tee --append $RECENTRUN &>/dev/null
printf "$orange" "___________________________________________________________"
echo ""
