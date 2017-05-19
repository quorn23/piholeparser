# piholeparser

## Less than basic usage

In the directory "parsed" are individual lists that I parse daily.

Add these lists directly to piholes webui or the adlists.list file.

It is probably best to copy the link in it's raw format.


### If you want all of the lists

Just add
 
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/parsedall/1111ALLPARSEDLISTS1111.txt

## Advanced Usage

### IF YOU ARE NEW TO LINUX AND PIHOLE, CONSIDER ADDING THE LISTS I HAVE ALREADY PARSED

I'm parsing all of the lists daily and uploading them to the parsed directory in this repository. If you prefer to use this project yourself locally, then run.

    sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/scripts/piholeparserinstall.sh

    sudo bash piholeparserinstall.sh
    

#### Manual Run

    sudo bash /etc/updaterunpiholeparser.sh


### Adding Lists

When this is run, it will fetch new lists that I have added to the lists directory. If you feel there is a list that you would like added, create an "issue" with the name of the list and the URL that it can be retrieved from.

#### A local copy of the big list is available to be used.

http://pi.hole/lists/1111ALLPARSEDLISTS1111.txt


## Disclaimer

    All "Original Unaltered Lists" are located within the mirroredlists directory.

    After going through the parser, many lists contain zero lines and are deleted.

    The filtered lists are in the parsed directory;
    
    with filenames to reflect the Original Creators work/effort.
