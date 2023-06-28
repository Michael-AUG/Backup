#!/bin/bash

#Written by Michael Topple GM5AUG

date=$(date '+%Y-%m-%d')
echo "Backup begun on $date" >> backuplog #Echoes backup begun confirmation to log
ssh pi nohup tar -czf - /media/gm5aug/michael/ > /home/gm5aug/backup/backup$date.tar.gz #Executes tar command on the Pi and saves the file to the backup directory on the laptop
echo "Backup completed on $date" >> backuplog #Echoes backup completed confirmation to log
find ~/backup/* -type f -mtime +2 -print0 | xargs -r0 rm -- #Finds backup file(s) older than 2 days and deletes them
echo "Removed previous backup on $date" >> backuplog #Echoes confirmation to backuplog
currls=$(ls /home/gm5aug/backup) #Writes contents of ~/backup to a variable (there should only be one file in there now
echo "Backup file titled $currls" >> backuplog #Echoes the directory contents to backuplog
echo "" >> backuplog #A quick and nasty way to make a new line ready for the next entry
