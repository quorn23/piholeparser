# piholeparser

This Project Aims To Universally take ANY Blacklist, and ensure that it is formatted to be compatible with [Pi-hole(tm)](https://pi-hole.net/)

Other aims of this project:

* Lists update daily if there are any changes.
* Build a user-driven blacklist.
* Build a user-driven whitelist.
* Mirror and Filter, any user-submitted blacklist.
* Handle ANY list, even if it is compressed in tar or 7zip.

### Contribute

* If you think you know the best and most efficient way to parse the lists, please submit a pull request.
* Help me create the best blocklists by submitting issues.

### Last Run On

* Script Started At Thu 22 Jun 10:17:42 EDT 2017
* Script Ended At Thu 22 Jun 11:28:01 EDT 2017
* Script Took 70 minutes To Filter Lists.
* [Log Available](https://github.com/deathbybandaid/piholeparser/tree/master/RecentRunLog)

## Individual Lists

* Individual lists tend to be safer than all of them Combined.
* You will find them Within the "parsed" directory.

#### Adding Them to [Pi-hole(tm)](https://pi-hole.net/)

Simply copy the RAW format url for the list and add them.

* In the Web Interface on the Settings page.
* Directly to your adlists.list file found in /etc/pihole/.

###### All of the lists combined.

* Note, I honestly don't recomend adding the big list, it may break websites.

Just add
 
    https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/parsedall/1111ALLPARSEDLISTS1111.txt

###### I also have a list that is driven by the userbase.

* To request a list to be whitelisted or blacklisted, please submit an issue containing WHY it should be added or removed.

    https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/parsedall/1111ALLPARSEDLISTS1111edited.txt

_______________________________________________________________________________________________________________________

### IF YOU ARE NEW TO LINUX AND PI-HOLE, CONSIDER ADDING THE LISTS I HAVE ALREADY PARSED

* I'm already parsing all of the lists daily and uploading them to the parsed directory in this repository.
* If you prefer to use this project yourself locally, Keep Reading.

### IF YOU HAVE USED THIS SCRIPT BEFORE 6/16/2017, YOU WILL NEED TO RUN/RERUN THIS (updated) INSTALLER

    sudo wget https://raw.githubusercontent.com/deathbybandaid/piholeparser/master/piholeparserinstall.sh

    sudo bash piholeparserinstall.sh
    
#### Manual Run

    sudo bash /etc/updaterunpiholeparser.sh

#### A local copy of the big list is available to be used.

http://pi.hole/lists/1111ALLPARSEDLISTS1111.txt

_______________________________________________________________________________________________________________________

## Query Lists Tool

As of 6/20/2017, there is a querylists.sh within the scripts directory.

This will allow me to query the individual parsed files for a specific domain.

## Log

As of 6/13/2017, there is a [Log Available](https://github.com/deathbybandaid/piholeparser/tree/master/RecentRunLog)

This should provide some insights as to what lists are dead, empty, or too large for github.

_______________________________________________________________________________________________________________________

## Basic Things about this script

* Script updates first thing on every run, always the most up to date version.
* Script Checks for dependencies.
* .lst files are named on purpose to help name the end results better.
* Script skips steps if the file is empty
* Script skips IP Lists (for now)
* Script appends RecentRunLog to tell me that a list is no longer dead.
* Script Pushes the results to localhost, and Github (if selected).
* Script runs daily with cron, or Manually.
* Allparsed list is based on the userbase.

### Downloading

* Check to see if host of list is available.
* Download based on host availability, file extension (tar or 7z), or attempt to use a mirrored copy from this repository.

### Parsing

* Creates a mirror if file is not empty, or over the Github 100MB limit.
* Remove Commented lines #'s !'s and Empty Lines.
* Remove Invalid Characters. FQDN's are allowed to use dashes, underscores, and emoji's. all other symbols are not allowed.
* Remove Pipes | and Carots ^
* Removes IP Addresses.
* Remove Empty Space.
* Checks for FQDN Requirements. A Period and a Letter.
* Remove Periods at Beginning and End Of Lines.
* Filter out common file extensions used in assets
* Remove Duplicates, If any.
* Create Parsed File, if it survives this process.

_______________________________________________________________________________________________________________________

## Disclaimer

    All "Original Unaltered Lists" are located within the mirroredlists directory.

    After going through the parser, many lists contain zero lines and are deleted.

    The filtered lists are in the parsed directory;
    
    with filenames to reflect the Original Creators work/effort.
