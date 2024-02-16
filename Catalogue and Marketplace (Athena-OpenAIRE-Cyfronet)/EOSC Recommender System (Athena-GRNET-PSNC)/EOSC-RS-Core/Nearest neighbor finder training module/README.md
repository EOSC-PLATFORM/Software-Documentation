# Nearest Neighbor Finder Training Module (1.4.2) for EOSC Online ML Engine

> The objective of this module is to provide a training endpoint for the nearest neighbor index. The app utilizes distributed task queue systems RabbitMQ and Celery for concurrent training of indexes. This module is compatible with nearest-neighbor-finder version `1.4.2`. Version of indexes: `1.4.2`.

## Development utils
- **[pre-commit](https://pre-commit.com/)**
- **[black](https://github.com/psf/black)**
- **[flake8](https://github.com/pycqa/flake8)**
- **[pylint](https://github.com/PyCQA/pylint)**
- **[google docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)**

## Requirements and dependencies

- **Docker**
  - [docker-compose](https://docs.docker.com/compose/install/)
- **Python 3.8**
  - Packages listed out in [requirements.txt](requirements.txt) will be installed when building docker image
- **Celery** (obraz worker w repozytorium) na osobnej maszynie
  - **Redis/RabbitMQ** as Broker app for sending tasks to celery workers (CELERY_BROKER_URL)
  - **Redis** as Backend app for storing results (CELERY_BACKEND_URL) - if Redis is used as Broker, the same instance can be used
  - Optional: **Celery Flower** monitor service (gregsi/latest-celery-flower-docker image) for monitoring of training tasks
- **PostgreSQL** containing the following tables of embeddings:
  - in `"resources"` schema: `"datasets", "publications", "software", "services", "other_research_product", "trainings", "data_srouces"`
  - in `"users"` schema: `"users", "users_aai", "users_anon"` with columns for each configuration of user actions (ordered, visited) x resources (datasets, publications, services, software, trainings, other_research_product, data_sources)
- **HDFS** containing the following data:
  - directory `user/{HDFS_USER}/nn-finder/{INDEX_TAG}/` with folders for index storage of each table type: `"datasets", "publications", "software", "services", "other_research_product", "trainings", "data_srouces", "users", "users_aai", "users_anon"`

## Run example

### Install dependencies

The dependencies are installed automatically with the `docker-compose build` command. You can add dependencies by modifying the `requirements.txt` file, or use `poetry` and export the file automatically:

1. poetry add `package_name`
2. Execute the following command: `poetry install --dev`
3. Export the new set of packages to requirements.txt by executing `poetry export --without-hashes -f requirements.txt --output requirements.txt`

### Run app
1. Run command ```docker-compose build```, then ```docker-compose up``` to start up the fastapi and celery_worker instances locally. In order to deploy the API and (one or more) worker services on separate machines, you can deploy the docker images separately on each device, by cloning the whole repository and commenting out the unnecessary image in `docker-compose.yml`. The services will communicate by RabbitMQ or Redis, which coordinates the jobs started by API and assigns them to workers.
2. Navigate to the [http://localhost:8001/docs](http://localhost:8001/docs) and execute test `/diag` API call.
3. Use the `/train/{table_name}` endpoint to train a specific index, specifying the data source: `/train/services?data_source=pg`. You can check the Celery Flower dashboard to see if the task has been sent to the worker successfully.
4. You can also use the `/train_all/{table_type}` endpoint to train all available indexes. `table_type` value can be `users` or `resources`.

## Train endpoint parameters

|Parameter|Possible values|
|---|---|
| table_name | 'publications', 'datasets', 'software', 'other_research_product', 'services', 'trainings', 'data_sources', 'users', 'users_anon', 'users_aai' |
| data_source | 'pg', 'hdfs' |
|---|---|
| Required only when training a user index |
| user_resource | 'datasets', 'publications', 'services', 'software', 'trainings', 'other_research_product', 'data_sources' |
| user_action | 'visited', 'ordered' |
||

## Enviroment variables

|Variable name|Description|
|---|---|
| PROJECT_NAME | "Nearest Neighbor Finder Training Module" |
| LOGGING_LEVEL | Level of how descriptive the logs are, default value is "WARNING" |
| DYNAMIC_TABLES | List of dynamically trained users indexes, default is ["users_aai", "users_anon", "users"] |
| DYNAMIC_TRAINING_INTERVAL | Time between dynamic training runs in minutes, 30 by default. |
| MAX_N_INDEXERS | Maximum number of versions of a single indexer stored in HDFS |
| INDEX_TAG | Specifies the subdirectory in which the trained indexes are stored , default corresponds to the training module version |
| TABLES_CONFIG_PATH | Specifies the directory of locally stored JSON file with tables data needed for proper functioning of the module |
| POSTGRES_HOST | URL to the PostgreSQL connection |
| POSTGRES_DATABASE | Database name for the PostgreSQL connection |
| POSTGRES_USER | Username for the PostgreSQL connection |
| POSTGRES_PASSWORD | Password for the PostgreSQL connection |
| HDFS_URL | URL for the HDFS connection |
| HDFS_USER | Username for the HDFS connection, `hadoop` by default |
| HDFS_TIMEOUT | Integer indicating the time for hdfs connection timeout in seconds, default is 60 |
| POSTGRES_TIMEOUT | Integer indicating the time for PostgreSQL connection timeout in seconds |
| CELERY_BROKER_URL | URL to RabbitMQ or Redis broker instance for sending tasks to celery worker|
| CELERY_BACKEND_URL | URL to Redis backend instance for storing celery worker results |
| REMOVE_ZEROED_USERS | Flag indicating whether the users should be removed from indexes when their embeddings are zeroed out. Default is True |
| REMOVE_ZEROED_RESOURCES | Flag indicating whether the resources should be removed from indexes when their embeddings are zeroed out. Default is False |
| REMOVE_INVALID_RESOURCES | Flag indicating whether the resources should be removed from indexes when their 'is_valid' column is False. Default is True |
| REMOVE_FOREIGN_RESOURCES | Flag indicating whether the resources should be removed from indexes when their language is not in RESOURCE_LANGUAGES. Default is True |
| RESOURCE_LANGUAGES | List of languages of the resources that should be kept in the index. Default is ["en"].|
||

## Error status codes

|Error code|Title|Description|
|---|---|---|
| API errors |
| 700| Something went wrong | General exceptions, see logs for more details. |
| 701| Table not found | There is no table present in the database with the name provided. |
| 702| Invalid query type | The provided qtype keyword is not a viable query type. |
| 703| ID data parsing error | ID context data should be a non-empty list of strings. |
| 704| EMB data parsing error | EMB context data should be a non-empty string containing a list of embeddings formatted as lists of floating point numbers. |
| 705| Invalid K value | K value should be an integer between 1 and 128. |
| 706 |Invalid user parameters |When operating on a users index, user_resource and user_action parameters must be specified. See README for possible values. |
|707 |Context data missing | Context data provided for the selected query type is missing in the request body. |
| |
| Index errors |
| 721| Index could not be created | The KNN index creation failed. |
| 722| Index could not be trained | The KNN index training failed. |
| 723| Index not present | The KNN index you are trying to use is not present in the database. |
| 724| Index not trained | The KNN index you are trying to use has not been trained yet. |
| 725| Recommendation unsuccessful | The KNN index has failed to retrieve recommendation results. |
| 726| Not enough valid resources | Too many rows in source table were tagged as invalid, so the index cannot be created. |
| 727| Graph not present | Graph was not loaded to memory. |
| 728| Graph search failed | None of the requested IDs could be found in the graph. |
| |
| Mapping errors |
| 731| ID mapping creation failed | ID mapping creation failed |
| 732| IID-SID mapping failed | Index IDs could not be mapped to Source IDs with the currently saved mapping file. |
| 733| SID-IID mapping failed | Source IDs could not be mapped to Index IDs with the currently saved mapping file. |
| |
| Connection errors |
| 741| Database connection error | An error occured while fetching a database result. |
| |

### Running Tests

To run tests:

Prerequisites: Python 3.8
1. create a virtual environment: `virtualenv --python=/usr/bin/python3.8 venv` (or provide other location of your python installation)
2. in `venv/lib/python3.8/site-packages/` add file `path.pth` containing full paths to folders `/app` and `/test`
3. run the virtual environment: `source venv/bin/activate`
4. move to the folder containing tests: `cd test`
5. install all required packages: `pip install -r test_requirements.txt`
6. create an `.env` file (in `/test`) with all necessary variables (described in documentation) and add the following:

```bash
TABLES_CONFIG_PATH=./app/test_tables_config.json
INDEX_TAG=1.4.2
```

7. run `coverage run -m pytest test_main.py --log-cli-level=INFO`
8. run `coverage report -m`
