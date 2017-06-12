# piholeparser

## Less than basic usage

In the directory "parsed" are individual lists that I parse daily.

Add these lists directly to piholes webui or the adlists.list file.

It is probably best to copy the link in it's raw format.

* I parse all lists individually, for a reason. If you want the easiest Pi-Hole experience, consider adding the smaller individual lists.

#### If you want all of the lists

* Note, I honestly don't recomend adding the big list, it may break websites, as it blocks close to 4 million domains.

Just add
 
https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/parsedall/1111ALLPARSEDLISTS1111.txt

#### I also have a list that removes domains that are requested.

* To request a list to be removed, please submit an issue.

https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/parsedall/1111ALLPARSEDLISTS1111edited.txt

## Advanced Usage

### IF YOU ARE NEW TO LINUX AND PI-HOLE, CONSIDER ADDING THE LISTS I HAVE ALREADY PARSED

I'm parsing all of the lists daily and uploading them to the parsed directory in this repository. If you prefer to use this project yourself locally, Keep Reading.

### IF YOU HAVE USED THIS SCRIPT BEFORE 6/12/2017, YOU WILL NEED TO RUN/RERUN THIS (updated) INSTALLER

#### Sorry for the major changes. I wanted to give the script the ability to be updated easier.

    sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/piholeparserinstall.sh

    sudo bash piholeparserinstall.sh
    
#### Manual Run

    sudo bash /etc/updaterunpiholeparser.sh

### Adding Lists

* If you feel there is a list that I could add to the project, submit an issue as a request with the name of the list, and the url for the list. (If github, use RAW format.)

#### A local copy of the big list is available to be used.

http://pi.hole/lists/1111ALLPARSEDLISTS1111.txt

## Contribute some code

If you think you know the best and most efficient way to parse the lists, please submit a pull request.

## Disclaimer

    All "Original Unaltered Lists" are located within the mirroredlists directory.

    After going through the parser, many lists contain zero lines and are deleted.

    The filtered lists are in the parsed directory;
    
    with filenames to reflect the Original Creators work/effort.
