#!/bin/bash

date=`date "+%Y-%b-%d:_%T"`
rsync -aAXHv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found", "/backups/*", "/home/jason/Downloads/*"} / /backups/$date
