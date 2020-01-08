HostScrips Shell Scripts for Host
===========

Bash Script to allow create or delete apache/nginx virtual hosts and Backup MysQL Database on Ubuntu on a quick way.

## Installation ##

1. Download the script
2. Apply permission to execute:

### For MySQL Backup Database ###

```bash
$ wget https://raw.githubusercontent.com/pjaun/HostScrips/master/MySQL_Backup/backupmysql.sh
$ wget https://raw.githubusercontent.com/pjaun/HostScrips/master/MySQL_Backup/backupmysql.conf
$ chmod +x backupmysql.sh
```

### For Apache Virtual Host ###

```bash
$ wget https://raw.githubusercontent.com/pjaun/HostScrips/master/ApacheVhost/vhostapache.sh
$ chmod +x vhostapache.sh
```
### Example Used ###
$ ./vhostapache.sh create example.com /var/dir
