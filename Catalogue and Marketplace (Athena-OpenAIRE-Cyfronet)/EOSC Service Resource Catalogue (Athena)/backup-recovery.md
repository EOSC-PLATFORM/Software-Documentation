# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

# Backup and Recovery

Information relating to backup and recovery may be found in the Service Availability and Continuity Management plan for this service,  within the EOSC Service Management System (SMS) [here](https://wiki.eoscfuture.eu/display/EOSCSMS/EOSC+Service+Catalogue+Capacity+plan)

---

## Instructions
It is highly suggested to set up a backup policy. You can do so in two different ways:
- Application-based Backup
- Database Backup
 
If for some reason a data loss or corruption occurs, there is a number of steps you need to follow to restore the data from the latest backup.

---

### Application-based Backup & Recovery
The application has built-in _backup_ and _recovery_ mechanisms. The Application creates backup files able to be fed back for recovery.
The backup and recovery processes can be performed from a remote machine. There is no need to access the machine running the application.

**Application-based Backup & Recovery** performs all necessary actions to populate the _Database_ and create the indices in _Elasticsearch_.
<br>Consequently, this method of backup and recovery **is preferred for the time-being**.

<br>

#### Backup
A backup is a zipped archive (.zip) containing a list of directories. 
<br>Each top-level directory represents one Entity -which we call __Resource Type__- and it contains a collection of JSON files alongside their associated __version folders__ which contain previous versions of the resource.
<br>

```Plain Text
E.g. In the following directory structure of 'backup.zip' we can see two Resource Types (provider / service).
Each of them contains a schema.json file, the resources (.json files) and previous versions (the folders), which in turn contain the 
previous states of the resource.

backup.zip
├── provider
│   ├── 8e29252c-04bd-497b-95a9-67c166db09c4.json
│   ├── 8e29252c-04bd-497b-95a9-67c166db09c4-version
│   │   └── d66fdc59-9891-40b8-94db-303947757c38.json
│   ├── ...
│   └── schema.json
├── service
│   ├── 2ef5d9ea-3576-4cdc-b3b7-f32ff3b2decc.json
│   ├── 2ef5d9ea-3576-4cdc-b3b7-f32ff3b2decc-version
│   │   ├── 3c8e409c-4085-487b-a078-b47e397f7a4e.json
│   │   ├── 4e8e3dfa-fdf5-47a5-bbf4-6b21a27993a4.json
│   │   ├── 2748e120-2ea4-4c1e-801a-2306a4d13118.json
│   │   ├── a0ad02d6-47a6-4093-9fa3-3315686c6dd2.json
│   │   └── ea475049-d272-4d48-b6eb-6bba956512eb.json
│   ├── ...
│   └── schema.json
└── ...
```

There are a number of options regarding the backup method. You can choose to:
1. schema=(true|false) &emsp;&nbsp; - &emsp; Include/ignore the __schema.json__ files.
2. version=(true|false) &emsp;&nbsp;&nbsp; - &emsp; Include/ignore the __version__ files.
3. resourceTypes=x,y,z &emsp; - &emsp; Backup specific Resource Types only.

To execute the backup process use this API method:
```Bash
curl --location 'http://localhost:8080/eic-registry/dump/?schema=true&version=true&resourceTypes=resourceType1,resourceType2' \
--header 'Authorization: Bearer {token}' \
--output backup.zip
```
<br>

#### Recovery
Disaster recovery using the application's built-in mechanism can be performed through the following API call:
```Bash
curl --location 'http://localhost:8080/eic-registry/restore/' \
--header 'Authorization: Bearer {token}' \
--form 'datafile=@"/path/to/backup/file/backup.zip"'
```

You must replace the `{token}` with a valid [Access Token](https://aai.eosc-portal.eu/providers-api/) and the `/path/to/backup/file/backup.zip` with the location of the backup file. 

<br>

---

### Database Backup & Recovery
<br>

#### Backup
Database Backups can be obtained directly through PostgreSQL. For more details, read the [PostgreSQL official documentation](https://www.postgresql.org/docs/current/backup-dump.html). 

<br>

#### Recovery
Database recovery is a more complex procedure because it involves populating the _Elasticsearch_ index as well.
For the time being we do not have an automated indexing mechanism. Indexing is performed only by the [Application-based Recovery](#application-based-backup--recovery), 
consequently, it's a necessary step of the recovery procedure.

###### Recovery Procedure:

1. [Restore a PostgreSQL dump](https://www.postgresql.org/docs/current/backup-dump.html#BACKUP-DUMP-RESTORE)
2. Backup and Recover using [Application-based Backup & Recovery](#application-based-backup--recovery)

