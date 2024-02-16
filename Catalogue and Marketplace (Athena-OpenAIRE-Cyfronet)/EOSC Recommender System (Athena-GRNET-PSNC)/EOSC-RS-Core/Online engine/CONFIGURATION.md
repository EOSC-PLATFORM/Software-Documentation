# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction
The Online engine application uses only environmental variables for control its behaviour.
We provide a detailed description of the configuration process below.

## Configuration Overview
configuration can be provided by setting the appropriate environment variables on the system 
or through an `.env` file placed in the root directory of the project.
`.env` file should never be placed in the repository.

## Environmental Variables

The following environment variables must be set to run the module:

|<b>Variable name</b> |Description  | Default |
|:---:|:---:|:---:|
| PROJECT_NAME | Project name | `Online engine` |
| NN_FINDER_URL | URL to the Nearest Neighbor Finder | |
| HBASE_HOST | URL to the HBase connection | |
| HBASE_PORT | HBase Thrift Server port | |
| RESOURCE_DB | The type of database used as resource database. <br>Possible values: `postgresql`(recommended), `hbase` | `postgresql` |
| USER_DB | The type of database used as user database. <br>Possible values: `postgresql`(recommended), `hbase` | `postgresql` |
| POSTGRESQL_HOST | Preprocesor PostgreSQL URL | |
| POSTGRESQL_PORT | Preprocesor PostgreSQL port | |
| POSTGRESQL_PREPROCESOR_USER | Preprocesor PostgreSQL user | |
| POSTGRESQL_PREPROCESOR_PASSWORD | Preprocesor PostgreSQL password | |
| POSTGRESQL_PREPROCESOR_DATABASE | Preprocesor PostgreSQL database name | |
| POSTGRESQL_PREPROCESOR_SCHEMA | Preprocesor PostgreSQL table schema name  | `base` |
| POSTGRESQL_RESOURCES_USER | team_ai PostgreSQL user | |
| POSTGRESQL_RESOURCES_PASSWORD | team_ai PostgreSQL password | |
| POSTGRESQL_RESOURCES_DATABASE | team_ai PostgreSQL database name | |
| NUMBER_OF_RECOMMENDATION | Number of recommendation | `5` |
| NUMBER_OF_CANDIDATES | Number of generated candidates for recommendation| `5`|
| DEFAULT_POPULARITY_RECOMENDATION | For value `True`, if the user does not exist in the database, <br>a recommendation will be made based on popularity. | `True` |
| RERANKING_PARAMETER_LAMBDA | Parameter used by MMR reranking method, <br>with range between 0 (maximum diversity) and 1 (maximum relevance)  = `0.8` | `0.4` |
| POSTGRESQL_CONNECTION_POOL | A switch that determines whether to use the connection pool for postgres | `False` |
| CONNECTION_POOL_SIZE | Maximal size of conncection pool per worker| `2`|
| EXTERNAL_API_TIMEOUT | How long to wait for external API response| `3600.0`|
| SORT_INCLUDE_MISSING | Whether to consider missing resources when sorting | `False` |
| LOG_LEVEL | Log level <br>Possible values: `CRITICAL`, `ERROR`, `WARNING`, `INFO`, `DEBUG` | `INFO` |
| WORKERS_PER_CORE | Number of fastapi workers per core | `4` |
| WEB_CONCURRENCY | Override the automatic definition of number of fastapi workers. Independent of how many CPU cores are available in the server | |



## Security Considerations
The .env file should never be committed to the repository. It should be created manually on the server.


