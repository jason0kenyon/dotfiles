#!/bin/bash

#check number of backups
if ((`ls /snapshots/jason | wc -l`-1 > 10)) ; then
    for file in /snapshots/jason/* ; do
        if [ "$file" != "/snapshots/jason/last" ] ; then
            rm  -r $file
        fi
    done
fi

# Config
OPT="-aPh"
LINK="--link-dest=/snapshots/jason/last/"
SRC="/home/jason"
SNAP="/snapshots/jason/"
LAST="/snapshots/jason/last"
date=`date "+%Y-%b-%d:_%T"`

# Run rsync to create snapshot
rsync $OPT $LINK $SRC ${SNAP}$date

# Remove symlink to previous snapshot
rm -f $LAST

# Create new symlink to latest snapshot for the next backup to hardlink
ln -s ${SNAP}$date $LAST
