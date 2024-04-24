# Guide for loading new data
In the case of delivery of a new dataset to the system:

If the new data is in the same tables in HBase and PostgreSQL then no
additional steps are required. Otherwise, after uploading all the data
to the databases and after updating the metadata tables in PostgreSQL,
you need to reload the application. During the loading process, 
the application automatically retrieves the names of the latest data 
tables from the metadata tables in Postgresql.

## Tables with metadata

Resources PostgreSQL:
 `metadata.metadata_resources`

Resources HBase:
 `metadata.metadata_resources_hbase`

Users HBase:
 `metadata.metadata_users_hbase`
