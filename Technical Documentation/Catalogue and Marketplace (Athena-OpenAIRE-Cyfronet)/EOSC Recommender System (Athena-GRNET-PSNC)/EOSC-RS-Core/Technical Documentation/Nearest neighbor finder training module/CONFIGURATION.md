# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

This document describes the configuration of the NN Finder Training Module. The described configuration files are essential for the modules to function properly.

## Configuration Overview

The configuration for this module is a one-time definition of the environment variables and available indexes. The configuration files are to be placed in the repository root directory, which is by default `~/app` as stated in Dockerfile. The configuration is loaded on startup and the variables are used throughout the module. The configuration files are not to be changed after the initial setup, unless the system is to be scaled or new features are to be added.

## Configuration Files

In repository root directory:
- `.env` for environment variables
- `tables_config.json` for configuration of indexed tables.  The content of this file is already included in the repository.

## Configuration Parameters

In `tables_config.json`:
    - `PG` - section corresponding to the PostgreSQL tables containing key-value entries for each of them. The key is the table name, the value is a dictionary with the following keys:
        - `table_type` is the type of data that this table contains. As of now the only allowed types are `users` and `resources` and dictate the behavior of the module when performing training and search on the indexes.
        - `vect_len` (default 256) a parameter corresponding to the length of the embeddings used in the training process. The length corresponds to the amount of columns the vector from PostgreSQL will have after deserialization.
        - `batchsize` (default 500 000) a parameter used in training that optimizes training on big databases. It can be changed when scaling the system.
    - `settings.USER_RESOURCES` is the list of resources that create variations for user tables.
    - `settings.USER_ACTIONS` is the list of user actions that create variations for user tables.

## Environment Variables

The following list contains all variables that must be defined by the developer before running the application

|Variable name|Description|
|---|---|
| POSTGRES_HOST | URL to the PostgreSQL connection |
| POSTGRES_DATABASE | Database name for the PostgreSQL connection |
| POSTGRES_USER | Username for the PostgreSQL connection |
| POSTGRES_PASSWORD | Password for the PostgreSQL connection |
| HDFS_URL | URL for the HDFS connection |
| HDFS_USER | Username for the HDFS connection, `hadoop` by default |
| CELERY_BROKER_URL | URL to RabbitMQ or Redis broker instance for sending tasks to celery worker|
| CELERY_BACKEND_URL | URL to Redis backend instance for storing celery worker results |
| INDEX_TAG | Specifies the subdirectory in which the trained indexes are stored, default corresponds to the Training Module version |
||

The table below contains all optionally configurable environment variables. They already have default values defined in the code and should only be changed in case there are changes to data or module design, or during debugging.

|Variable name|Description|
|---|---|
| PROJECT_NAME | "Nearest Neighbor Finder Training Module" |
| LOGGING_LEVEL | Level of how descriptive the logs are, default value is "WARNING" |
| DYNAMIC_TABLES | List of dynamically trained users indexes, default is ["users_aai", "users_anon", "users"] |
| DYNAMIC_TRAINING_INTERVAL | Time between dynamic training runs in minutes, 30 by default. |
| MAX_N_INDEXERS | Maximum number of versions of a single indexer stored in HDFS |
| INDEX_TAG | Specifies the subdirectory in which the trained indexes are stored , default corresponds to the training module version |
| TABLES_CONFIG_PATH | Specifies the directory of locally stored JSON file with tables data needed for proper functioning of the module |
| HDFS_TIMEOUT | Integer indicating the time for hdfs connection timeout in seconds, default is 60 |
| POSTGRES_TIMEOUT | Integer indicating the time for PostgreSQL connection timeout in seconds |
| REMOVE_ZEROED_USERS | Flag indicating whether the users should be removed from indexes when their embeddings are zeroed out. Default is True |
| REMOVE_ZEROED_RESOURCES | Flag indicating whether the resources should be removed from indexes when their embeddings are zeroed out. Default is False |
| REMOVE_FOREIGN_RESOURCES | Flag indicating whether the resources should be removed from indexes when their language is not RESOURCE_LANGUAGE. Default is True |
| RESOURCE_LANGUAGES | List of languages of the resources that should be kept in the index. Default is ["en"].|
||

## Configuration Sources

- `.env` - apart from the necessary variables for configuration and connection to dependencies, all variables are set to default, and any changes to them should be done when troubleshooting, testing or removing features.
- `tables_config.json` - naming and vector lengths derived from the tables available in PostgreSQL, specified in metadata table. Batch size is a tunabale parameter and can be changed based on performance.

## Configuration Management

On each startup, the configuration files are loaded and the environment variables are set. They can be changed at any time, but the changes will only be applied after the module is restarted.
- `.env` can be modified as desired for test runs and config changes. It must not be added to the repository.
- `tables_config.json` should be modified when a new table is added to the system, as reflected in PostgreSQL metadata table. In such case, the file changes are to be saved in the repository.

## Security Considerations

The `.env` file should be kept secret, as it contains sensitive information about the system. Safety measures are described in [Security](SECURITY.md)

## Troubleshooting

If variables are not loaded properly, make sure that the configuration files are placed in the repository root folder, which should be `~/app`. In case of any config value errors set the `LOGGING_LEVEL` to `DEBUG` and check the logs for more information.
