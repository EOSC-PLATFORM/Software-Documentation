# Guide for loading new data

## Loading resources: PySpark version

To run this version, you need to prepare python environment on Spark as in the
[instruction](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse/app/user_entity/spark/README.md)
.
Also, you need to have deployed nearline engine.

To run processing, you have to just make request to nearline engine with the following
data:

 **Endpoint**: /generate_embeddings_diff

 **Description**: Run differential processing of embeddings

 **Method**: POST

 **URL**: [http://www.example.com/generate_embeddings_diff](http://www.example.com/generate_embeddings_diff)

 **Parameters**:

| Name           | Type   | Required | Example                          | Description                     |
|----------------|--------|----------|----------------------------------|---------------------------------|
| path_from      | string | Yes      | /path/to/your/folder/publication | Path to the folder with data    |
| postgres_table | string | Yes      | publication_embeddings           | Name of the table in PostgreSQL |
| resource_type  | string | Yes      | publications                     | Type of resource                |

 **Responses**:

| Code | Description                                         |
|------|-----------------------------------------------------|
| 200  | Success                                             |
| 400  | Missing parameter                                   |
| 401  | Wrong resource type                                 |
| 402  | Wrong path or table name                            |
| 403  | Some environmental variable is not set              |
| 404  | No environmental variable can contains spaces       |
| 405  | Path to environmental variable has to start with /  |

## Loading resources:  Slurm version

If you installed the environment as in the instruction (on slurm branch), you need only run
several commands. For example, for publications this commands was used:

```bash
python3 coordinator.py -f /path/to/your/folder/publication/data \
      --save_postgres \
      --save_hdfs \
      --save_hbase \
      --savemeta
```

More about this version can be found
in [README](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse/README.md?at=refs%2Fheads%2Ffeature%2Fslurm)

## User Embeddings

For creating user embeddings, we need 2 types of databases: with resource embeddings and with user embeddings(at the
begging they might be empty).

For creating empty user embeddings database, we need to go
to [Nearline ML AI engine](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse) and
from `app/user_entity` folder run:

```bash
python initialize.py
```

Scripts in default will create tables in HBase and in PostgreSQL with default names given
in `app/user_entity/settings.py` (ANON_USERS_TABLE, LOGGED_USERS_TABLE, LOGGED_USERS_AAI_TABLE for PostgreSQL and
HBASE_LOGGED_USERS, HBASE_ANON_USERS, HBASE_LOGGED_USERS_AAI for HBase). However, you can change them by adding to the
.env file the environmental variables you want to change.
