# Guide for developers

This document explains coding conventions, typical tasks such as compilation,
building and testing.

## How to run User Action processing

1. Make sure to be in root catalog.
2. Fill in the necessary environment variables in the `.env` file, and put this file
in  main directory.
3. Type `uvicorn app.user_entity.main:app --host 0.0.0.0` to run the application.

## How to run using *docker compose*

Required version for `docker compose`: `>1.28`.

1. Copy Hadoop configuration files to `hadoop-config` directory.
2. Fill in the necessary environment variables in the `.env` file, and put this file
in  main directory.
3. Type `docker compose build` and after that `docker compose up`.

## System Design

Nearline Engine is a module that has 2 main responsibilities:

### User Action Processing

This part of the service is responsible for processing user actions in real time.
Processing user actions is done by the `Processor` class.
It takes all resources that given user visited,
and using them create user profile. Then it saves this profile to the database.
Currently, 2 databases are supported: `PostgreSQL`, `HBase`.

### Resource Processing

Right now is done via slurm cluster, but in near future it will be done by Spark.
For each resource that is available in system, it creates vector of embeddings
using Artificial Intelligence. Then it saves this vector to the database.
Currently, 3 databases are supported: `PostgreSQL`, `HBase` and `HDFS`.
