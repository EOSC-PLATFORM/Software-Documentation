# Guide for loading new data

In order to search new data using Nearest Neighbor Finder, new indexes have to be trained. Use the following endpoints of the NN Finder Training Module in order to train new indexes and load them to HDFS.

Prerequisites:
- New resource embeddings in PostgreSQL or HDFS
- Up-to-date Metadata tables in PostgreSQL

## Train Indexes in NNFinder Trainig Module
- In order to perform search on new data using NN Finder, new indexes have to be trained.
- Before training, ensure that the directory for the new indexes is present in HDFS. If it does not exist yet, create the folder `user/{settings.HDFS_USER}/nn-finder/{settings.INDEX_TAG}/`, parametrized by the environment variables in brackets. Those variables must have the same values in all NN Finder modules.
- Use the following endpoints of the NN Finder Training Module in order to prepare new indexes and load them to HDFS:

```bash
PUT https://{Training Module URL}/train_all/resources
PUT https://{Training Module URL}/train_all/users
```

- You can also train each index separately or train from HDFS using the `/train/{table_name}` endpoint

## Output

The indexes will be stored in HDFS under `/user/{settings.HDFS_USER}/nn-finder/{settings.INDEX_TAG}/{indexer_name}.pickle`.
Apart from the new indexes, two previously trained indexes will be stored by default (MAX_N_INDEXERS=3).
List of all indexers:ii
- Resources: "datasets",
  - "publications",
  - "software",
  - "other_research_product",
  - "services",
  - "trainings"
  - "data_sources"
- Users:
  - "users_aai-datasets-visited",
  - "users_aai-publications-visited",
  - "users_aai-services-visited",
  - "users_aai-software-visited",
  - "users_aai-trainings-visited",
  - "users_aai-other_research_product-visited",
  - "users_aai-data_sources-visited",
  - "users_aai-datasets-ordered",
  - "users_aai-publications-ordered",
  - "users_aai-services-ordered",
  - "users_aai-software-ordered",
  - "users_aai-trainings-ordered",
  - "users_aai-other_research_product-ordered",
  - "users_aai-data_sources-ordered",
  - "users_anon-datasets-visited",
  - "users_anon-publications-visited",
  - "users_anon-services-visited",
  - "users_anon-software-visited",
  - "users_anon-trainings-visited",
  - "users_anon-other_research_product-visited",
  - "users_anon-data_sources-visited",
  - "users_anon-datasets-ordered",
  - "users_anon-publications-ordered",
  - "users_anon-services-ordered",
  - "users_anon-software-ordered",
  - "users_anon-trainings-ordered",
  - "users_anon-other_research_product-ordered",
  - "users_anon-data_sources-ordered",
  - "users-datasets-visited",
  - "users-publications-visited",
  - "users-services-visited",
  - "users-software-visited",
  - "users-trainings-visited",
  - "users-other_research_product-visited",
  - "users-data_sources-visited",
  - "users-datasets-ordered",
  - "users-publications-ordered",
  - "users-services-ordered",
  - "users-software-ordered",
  - "users-trainings-ordered",
  - "users-other_research_product-ordered"
  - "users-data_sources-ordered",

## Loading new indexes to NNFinder
See [NN Finder instructions](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder/browse/LOAD_NEW_DATA.md)
