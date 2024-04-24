# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Backup and Recovery

Information relating to backup and recovery may be found in the Service Availability and Continuity Management plan for this service,  within the EOSC Service Management System (SMS):

<link to the SACM plan, currently under: <https://wiki.eoscfuture.eu/display/EOSCSMS/Capacity+plans+database> >

## Backup procedure

### OpenPlato

Backups are created using rsync and cron.
Backuped directories:

 - /etc 
 - /home 
 - /srv

File backups are pushed into backup server with script:

  #!/bin/bash

  trap 'echo "${BASH_SOURCE[0]} line $LINENO command >>> $BASH_COMMAND <<< exit with error (return code $?)" | logger -p cron.error' ERR
  set -E


  DIRS="/etc /home /srv"

  for d in $DIRS; do
  	rsync -aH --delete --relative -e "ssh -i /etc/backup.ssh -p 2223 -q" $d "`hostname -s`@213.135.60.136:/fs/"
  done

Database backups are pushed:

    #!/bin/bash
    trap  'echo "${BASH_SOURCE[0]} line $LINENO command >>> $BASH_COMMAND <<< exit with error (return code $?)" | logger -p cron.error'  ERR
    set  -E
    
    if [ $# -eq  2 ]; then
      name=dump-$2
      database="$2"
    elif [ $# -gt  2 ]; then
      name=dump-$2-$3
      database="$2"
      shift  3
      database="$database $@"
    else
      name=dump-all
      database="--all-databases --events --ignore-table=mysql.event"
    fi
    mysqldump  --defaults-extra-file=/etc/mysql/debian.cnf  $database  |  lz4  |
    ssh  -i  /etc/backup.ssh  -p  <PORT>  -q  <BACKUP_HOST>  "cat > /db/$name.moodle.openplato.eu.mysql.lz4"

  

## Recovery procedure

**Recover files:**

Download files from BACKUP_HOST on host where moodle is installed and restore them in proper directories for Moodle.

**Database:**

Download mysql dump into server running database dedicated for Moodle.
Uncompress mysqldump with lz4 and restore using mysql command.

    lz4 -d mysql_dump.sql.lz mysql_dump_to_restore.sql
    mysql -u root -p < mysql_dump_to_restore.sql
