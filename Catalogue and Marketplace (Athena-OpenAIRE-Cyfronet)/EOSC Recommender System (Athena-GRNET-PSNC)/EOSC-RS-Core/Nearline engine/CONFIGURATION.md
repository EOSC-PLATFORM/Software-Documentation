# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0 -- >

## Introduction

The Nearline engine application uses only environmental variables for control its behaviour.
We provide a detailed description of the configuration process below.

## Configuration Overview

Configuration can be provided by setting the appropriate environment variables on the system
or through an `.env` file placed in the root directory of the project.
`.env` file should never be placed in the repository.

## Environmental Variables

The following environment variables must be set to run the module:

|       <b>Variable name</b>       |                                                                  Description                                                                   |                    Default                    |
|:--------------------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------:|:---------------------------------------------:|
|         `POSTGRES_HOST`          |                                                                 PostgreSQL URL                                                                 |                                               |
|       `POSTGRES_DATABASE`        |                                                          team_ai PostgreSQL database                                                           |                                               |
|         `POSTGRES_USER`          |                                                            team_ai PostgreSQL user                                                             |                                               |
|         `POSTGRES_PORT`          |                                                                PostgreSQL port                                                                 |                     5432                      |
|       `POSTGRES_PASSWORD`        |                                                          team_ai PostgreSQL password                                                           |                                               |
|         `METADATA_TABLE`         |                                                           PostgreSQL metadata table                                                            |              metadata_resources               |
|        `ANON_USERS_TABLE`        |                                                        table name with anonymous users                                                         |                  anon_users                   |
|       `LOGGED_USERS_TABLE`       |                                                  table with logged users using marketplaceId                                                   |                 logged_users                  |
|     `LOGGED_USERS_AAI_TABLE`     |                                                      table with logged users using aaiID                                                       |               logged_users_aai                |
|          `KAFKA_SERVER`          |                                                    IP of the machine where Kafka is running                                                    |                                               |
|         `KAFKA_TOPIC_UA`         |                                                    topic where the data with UA is received                                                    |                   eosc-dev                    |
|        `KAFKA_TOPIC_USER`        |                                               topic where the data with user events is received                                                |                 sync-user-dev                 |
|      `KAFKA_TOPIC_SERVICE`       |                                              topic where the data with service events is received                                              |               sync-service-dev                |
|      `KAFKA_TOPIC_TRAINING`      |                                             topic where the data with training events is received                                              |               sync-service-dev                |
|        `KAFKA_LIKE_TOPIC`        |                                                topic where the data with user likes is received                                                |          recommendations-evaluation           |
|         `KAFKA_GROUP_ID`         |                                                        name of the kafka consumer group                                                        |                      foo                      |
|    `KAFKA_AUTO_OFFSET_RESET`     |                                    from where read kafka messages. 2 possible values: `latest`, `earliest`                                     |                    latest                     |
|   `PREPROCESSOR_DIAG_ENDPOINT`   |                                  address to diagnostic endpoint of preprocessor (should end with `.../diag`)                                   |                                               |
|          `HBASE_SERVER`          |                                                    IP of the machine where HBase is running                                                    |                                               |
|           `HBASE_PORT`           |                                                            HBase Thrift Server port                                                            |                     7710                      |
|         `HBASE_METADATA`         |                                                          table name of hbase metadata                                                          |               metadata_resource               |
|        `DATABASE_STORAGE`        |      Which databased is used for nearline for both modes: continues and spark. Possible values are: `POSTGRES`, `HBASE`, `POSTGRES:HBASE`      |                   POSTGRES                    |
|           `LOG_LEVEL`            |                  how much information should be logged <br/> Possible values: `CRITICAL`, `ERROR`, `WARNING`, `INFO`, `DEBUG`                  |                    WARNING                    |
|          `PROJECT_NAME`          |                                                           name displayed in the API                                                            |                nearline_engine                |
|   `NUMBER_OF_PROCESS_SWITCHES`   |                                         Number of thread that are responsible for processing messages                                          |
|   `NUMBER_OF_STORING_SWITCHES`   | Number of thread that are responsible for storing process messages (real number of threads is this times number of databases used for storage) |
|      `SPARK_EXECUTOR_CORES`      |                                                        number of spark executors cores                                                         |                       3                       |
|       `SPARK_DRIVER_CORES`       |                                                          number of spark driver cores                                                          |                       3                       |
|      `SPARK_NUM_EXECUTORS`       |                                                              number of executors                                                               |                       2                       |
|     `SPARK_EXECUTOR_MEMORY`      |                                                           amount of executor memory                                                            |                      5g                       |
|      `SPARK_DRIVER_MEMORY`       |                                                            amount of driver memory                                                             |                      5g                       |
| `SPARK_EXECUTOR_MEMORY_OVERHEAD` |                                                       amount of executor overhead memory                                                       |
|  `SPARK_DRIVER_MEMORY_OVERHEAD`  |                                                        amount of driver overhead memory                                                        |
|         `SPARK_COMMAND`          |                                                         command that run spark-submit                                                          |          /opt/spark/bin/spark-submit          |
|    `SPARK_PYTHON_ENVIRONMENT`    |                                                  path to python environment on spark cluster                                                   |                                               |
|        `SPARK_BERT_PATH`         |                                                      path to bert model on spark cluster                                                       |                                               |
|       `SPARK_JARS_FOLDER`        |                                                   path to folder with jars on spark cluster                                                    |                                               |
|       `SPARK_MAPPING_PATH`       |                                                     path to mapping file on spark cluster                                                      |                                               |
|           `MODEL_PATH`           |                                                   path to the file with weights of the model                                                   | nearline_app/embedders/resources/best_ckpt.pt |

### Important note

`SPARK_*_MEMORY` +  `SPARK_*_MEMORY_OVERHEAD` should be less or equal than the memory available on the machine.
Also, we needed 3g of overhead for processing

## Security Considerations

The .env file should never be committed to the repository. It should be created manually on the server.
