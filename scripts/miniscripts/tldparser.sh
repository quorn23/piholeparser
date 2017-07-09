#!/bin/bash
## Used in the Parsing Process,,, a bit extreme, but makes the list accurate

## Variables
source /etc/piholeparser/scripts/scriptvars/staticvariables.var

## Start the the most popilar
#cat $TEMPFILEA | sed '/com$/Id; /ru$/Id; /org$/Id; /net$/Id; /de$/Id; /jp$/Id; /uk$/Id; /br$/Id; /it$/Id; /pl$/Id; /fr$/Id; /in$/Id; /ir$/Id; /au$/Id; /info$/Id' > $TEMPFILEB
#rm $TEMPFILEA
#mv $TEMPFILEB $TEMPFILEA

#########################################
## If still contents in file, continue ##
#########################################

for source in `cat $TLDCATLIST`;
do
HOWMANYLINES=$(echo -e "`wc -l $TEMPFILEA | cut -d " " -f 1`")
if
[[ $HOWMANYLINES -gt 0 ]]
then
:
else
STOPTLDSEARCH=true
fi
if
[[ -z $FULLSKIPPARSING && -z $STOPTLDSEARCH ]]
then
$source
rm $TEMPFILEA
mv $TEMPFILEB $TEMPFILEA
fi
done

##  unset
unset STOPTLDSEARCH
