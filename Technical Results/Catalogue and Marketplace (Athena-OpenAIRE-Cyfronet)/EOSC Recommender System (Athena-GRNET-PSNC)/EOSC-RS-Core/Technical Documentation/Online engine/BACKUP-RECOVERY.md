# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Backup and Recovery

### Data backup
This application is stateless and does not store any information in local storage. Therefore, there is no need for backup for this application.

This application does not produce any data however it uses data stored in a PostgreSQL database (HBase) for its operation. The use of a particular database depends on the [configuration](CONFIGURATION.md).

Essential tables that are consumed by this module:
1. PostgreSQL:
    - users.anon_users
    - users.logged_users
    - users.logged_users_aai
    - metadata.metadata_resources
    - tables in metadata.metadata_resources
    - metadata.metadata_users_hbase
    - stats_day_table_dataset
    - stats_total_table_dataset
    - visits_week_weight_view
    - visits_month_weight_view
    - stats_day_table_publication
    - stats_total_table_publication
    - stats_day_table_software
    - stats_total_table_software
    - stats_day_table_training
    - stats_total_table_training
    - stats_day_table_other
    - stats_total_table_other

2. Hbase:
    - anon_users
    - logged_users
    - logged_users_aai
    - tables in metadata.metadata_users_hbase in PostgreSQL

In order to maintain the integrity of the system after a disaster, these databases and tables should have a backup.

### Configuration backup
All configuration is stored as environment variables or, in the case of a local deployment, in an .env file. If you use the .env file, you should backup this file to restore the configuration when recovering from a failure.

### Recovery
The disaster recovery procedure consists of restarting the docker container.