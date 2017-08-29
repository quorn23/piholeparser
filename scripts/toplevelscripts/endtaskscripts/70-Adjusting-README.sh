#!/bin/bash
## Adjusting Readme.md

## Variables
SCRIPTBASEFILENAME=$(echo `basename $0 | cut -f 1 -d '.'`)
script_dir=$(dirname $0)
SCRIPTVARSDIR="$script_dir"/../../scriptvars/
STATICVARS="$SCRIPTVARSDIR"staticvariables.var
if
[[ -f $STATICVARS ]]
then
source $STATICVARS
else
echo "Static Vars File Missing, Exiting."
exit
fi
if
[[ -f $TEMPVARS ]]
then
source $TEMPVARS
else
echo "Temp Vars File Missing, Exiting."
exit
fi

RECENTRUN="$ENDTASKSCRIPTSLOGDIR""$SCRIPTBASEFILENAME".md

## Remove old
if
[[ -f $MAINREADME ]]
then
rm $MAINREADME
fi

## Replace with new
if
[[ ! -f $MAINREADME ]]
then
cp $MAINREADMEDEFAULT $MAINREADME
fi

## Repository Name
if
[[ -f $MAINREADME ]]
then
sed -i "s/NAMEOFTHEREPOSITORY/$REPONAME/g" $MAINREADME
fi

Start Time
if
[[ -n $STARTTIME ]]
then
STARTTIMEMD="Script Started $STARTTIME"
else
STARTTIMEMD="Error Setting Start Time."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/LASTRUNSTART/$STARTTIMEMD/g" $MAINREADME
fi

## End Time
if
[[ -n $ENDTIME ]]
then
ENDTIMEMD="Script Ended $ENDTIME"
else
STARTTIMEMD="Error Setting End Time."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/LASTRUNSTOP/$ENDTIMEMD/g" $MAINREADME
fi

## Log Description
if
[[ -n $TOTALRUNTIME && -n $HOWMANYSOURCELISTS && -n $RECENTRUNLOGSDIRRAWMD ]]
then
RECENTRUNMAINLINKA="Script Took $TOTALRUNTIME Minutes To Filter $HOWMANYSOURCELISTS Lists. See Log Here."
else
RECENTRUNMAINLINKA="Error Calculating Script Run Time."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/RECENTRUNMAINLINKA/$THEMAINLOGFILEA/g" $MAINREADME
sed -i "s,RECENTRUNMAINLINKB,$RECENTRUNLOGSDIRRAWMD,g" $MAINREADME
fi

## edited results
if
[[ -n $EDITEDALLPARSEDSIZEMB && -n $EDITEDALLPARSEDHOWMANYLINES ]]
then
EDITEDALLPARSEDMD="The Edited AllParsed File is $EDITEDALLPARSEDSIZEMB MB And Contains $EDITEDALLPARSEDHOWMANYLINES Domains."
else
EDITEDALLPARSEDMD="Error Calculating Size of AllParsed File."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/EDITEDALLPARSEDINFO/$EDITEDALLPARSEDMD/g" $MAINREADME
fi

## average parsing time
if
[[ -n $AVERAGEPARSETIME ]]
then
AVERAGELISTPARSINGTIMEMD="Average Parsing Time Was $AVERAGEPARSETIME Seconds."
else
AVERAGELISTPARSINGTIMEMD="Error Setting Average Parse Time."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/AVERAGELISTPARSINGTIME/$AVERAGELISTPARSINGTIMEMD/g" $MAINREADME
fi

## TLD's
if
[[ -n $HOWMANYTLDTOTAL && -n $HOWMANYTLDNEW ]]
then
THEAMOUNTOFVALIDTLDSMD="$HOWMANYTLDTOTAL Valid Top Level Domains. $HOWMANYTLDNEW New TLD's."
else
THEAMOUNTOFVALIDTLDSMD="Error Setting The Amount Of Valid TLD's."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/THEAMOUNTOFVALIDTLDS/$THEAMOUNTOFVALIDTLDSMD/g" $MAINREADME
fi

## https
if
[[ -n $RECENTRUNWITHOUTHTTPSMD && -n $HOWMANYLISTSWITHOUTHTTPS ]]
then
LISTSWITHOUTHTTPSLOGA="$HOWMANYLISTSWITHOUTHTTPS Lists That Do NOT Use https"
else
LISTSWITHOUTHTTPSLOGA="Error Setting https-less Link"
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s/LISTSWITHOUTHTTPSLINKA/$LISTSWITHOUTHTTPSLOGA/g" $MAINREADME
sed -i "s,LISTSWITHOUTHTTPSLINKB,$RECENTRUNWITHOUTHTTPSMD,g" $MAINREADME
fi

if
[[ -n $ALLPARSEDORIGRAW ]]
then
BIGAPLMD="$ALLPARSEDORIGRAW"
else
BIGAPLMD="Error Setting Original List Link."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s,BIGAPLRAWLINK,$BIGAPLMD,g" $MAINREADME
fi

if
[[ -n $ALLPARSEDEDITRAW ]]
then
BIGAPLEMD="$ALLPARSEDEDITRAW"
else
BIGAPLEMD="Error Setting Edited List Link."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s,BIGAPLERAWLINK,$BIGAPLEMD,g" $MAINREADME
fi

if
[[ -n $INSTALLERFILERAW ]]
then
INSTALLERMD="$INSTALLERFILERAW"
else
INSTALLERMD="Error Setting Installer Link."
fi
if
[[ -f $MAINREADME ]]
then
sed -i "s,INSTALLERLINKRAW,$INSTALLERMD,g" $MAINREADME
fi
