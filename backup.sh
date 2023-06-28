#!/bin/bash

#Written by Michael Topple GM5AUG

#------------
#Set the below variables
server=[server_location_here]
network=[network_location_here]
local=[local_location_here]

#------------

date=$(date '+%Y-%m-%d')
echo "Backup begun on $date" >> backuplog #Echoes backup begun confirmation to log
ssh $server nohup tar -czf - $network > $local/backup$date.tar.gz #Executes tar command on the Pi and saves the file to the backup directory on the laptop
echo "Backup completed on $date" >> backuplog #Echoes backup completed confirmation to log
find ~/backup/* -type f -mtime +2 -print0 | xargs -r0 rm -- #Finds backup file(s) older than 2 days and deletes them
echo "Removed previous backup on $date" >> backuplog #Echoes confirmation to backuplog
currls=$(ls $local) #Writes contents of ~/backup to a variable (there should only be one file in there now
echo "Backup file titled $currls" >> backuplog #Echoes the directory contents to backuplog
echo "" >> backuplog #A quick and nasty way to make a new line ready for the next entry
