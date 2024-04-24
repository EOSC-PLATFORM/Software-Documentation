# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Disaster Recovery

Critical and unrecoverable data (without proper database backup) resides in PostgreSQL. 
Data stored on HDFS can be recovered assuming access to previous OAG dumps, 
but this may prove resource-intensive and time-consuming. 
In this case, initialize processing by processing only the last dump. 
This will result in a slight loss of data regarding the number of visits and orders. 
Other information can be found in `BACKUP-RECOVERY.md`