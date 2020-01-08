#!/bin/bash

# this also assumes you created "backups" on the remote host

DATETIME=`date +%Y%m%d%H%M`
BACKUP_FILENAME=$DATETIME.tar.gz
LOG=/tmp/backup/upload-$DATETIME.log
tar pzcPf /tmp/backup/$BACKUP_FILENAME /opt

# include FTP variables from home directory
. ~/backup_ftp.rc

ftp -inv <<! > $LOG
open $FTP_BACKUP_HOST
user $FTP_BACKUP_USERNAME $FTP_BACKUP_PASSWORD
cd backups
binary
put /tmp/backup/$BACKUP_FILENAME $BACKUP_FILENAME
close
bye
!

# this seems to be different per-host
FTP_SUCCESS_MSG="226-File successfully transferred"
if fgrep "$FTP_SUCCESS_MSG" $LOG ;then
    echo $BACKUP_FILENAME" uploaded successfully to "$FTP_BACKUP_HOST
else
    cat <<EOF
$BACKUP_FILENAME encountered an error!
EOF
    cat $LOG
fi

exit 0
