# EOSC Nearline ML AI engine

This is repository with user embedding processing and for resource processing
on Spark, for resource processing on Slurm/HPC cluster go to branch
[feature/slurm](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse?at=refs%2Fheads%2Ffeature%2Fslurm)

## How to prepare python environment for spark
Detail instruction may be found in [README](nearline_app/spark/README.md)

## Dependencies
* [Preprocessor](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse)
* Postgresql
* Hbase
* Kafka
* Spark
* HDFS:
   * jars: `{SPARK_JARS_FOLDER}/*`
   * lang. models: `{SPARK_BERT_PATH}/*`
   * file with mapping: `/{SPARK_MAPPING_PATH}`

To run resource embedding processing, you need to make following rest api call:

|            URL            | HTTP Method |                   Description                    |
|:-------------------------:|------------:|:------------------------------------------------:|
|           /diag           |         GET |   Endpoint to check if the service is running    |
| /generate_embeddings_diff |        POST | Endpoint to generate embeddings on spark cluster |
