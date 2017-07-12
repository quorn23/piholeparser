#!/bin/bash
## Comments #'s and !'s .'s

cat $TEMPFILEA | sed '/\#\+/d; /\!\+/d; /^[.]/d' | grep -v '\^.' > $TEMPFILEB
mv $TEMPFILEB $TEMPFILEA
