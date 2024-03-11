# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

### Prerequisites

- `.env` file in the project root (check `configuration.md` for more info)
- PostgreSQL
- Kafka
- Hadoop (HDFS + Spark)
- hadoop configuration files (see more in the official hadoop documentation)
  - `core-site.xml`
  - `hdfs-site.xml`
  - `yarn-site.xml`

### Steps

1. Build app - `BUILDING.md`
2. Fill environment variables `.env`
3. Place hadoop configuration files in mounted volume to `/opt/hadoop/etc/hadoop/`
4. Run app `docker run --env-file ./.env -p <port>:8095 preprocessor`
5. Transfer job files to hadoop cluster to `hdfs:///user/hadoop/preproc/jars/jobs` directory
6. Process OAG dump - more details in [operations](../operations/Operations.md).

### Note

The preprocessor does not validate messages arriving via JMS and treats each message as valid.