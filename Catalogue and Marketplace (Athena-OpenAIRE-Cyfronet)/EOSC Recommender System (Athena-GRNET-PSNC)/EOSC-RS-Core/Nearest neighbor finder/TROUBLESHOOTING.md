# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Troubleshooting

### Diagnosing problems

Basic troubleshooting is done using `/diag` endpoint.
- When the status is `UP`, the app is working properly.
- When no response is returned, or status is `DOWN`, a crucial part of the app is missing.
- When the status is `INCOMPLETE_DATA` the app is working properly, but some data or dependencies were not loaded properly.

In case of `DOWN` or `INCOMPLETE_DATA` status, repeat the `/diag` request with `details` parameter set to `True`. This will return a more detailed response, with the list of missing data.

Additionally, set the variable `LOGGING_LEVEL` to `DEBUG` in `.env` file and restart the app. This will enable more descriptive logs.

If the logs return errors, see the [Error codes](#error-codes) section for more details.

### How to act when NN Finder fails
In all cases, additional information can be found in logs. To enable more descriptive logs, set `LOGGING_LEVEL` to `DEBUG` in `.env` file and restart the app.

#### When NN Finder fails
1. Restart NN Finder
2. Check dependencies using `/diag` endpoint
3. If it fails again, repeat the steps from [deployment section](DEPLOYMENT.md)

#### When NN Finder Downloader fails
1. Restart NN Finder Downloader
2. If it fails again, and maintenance is expected to last a long time, you can temporarily set the NN Finder API to not use the downloader service and download indexes directly from HDFS. To do so:
    - `.env`: set `USE_DOWNLOADER` to `False`
    - `.env`: set `DYNAMIC_TABLES` to `[]`
    - restart NN Finder API

### How to act when dependencies fail

#### When shared volume "/app/indexers" fails
1. Bring back the shared volume
2. Restart NN Finder Downloader
3. Restart NN Finder
4. Check `/diag` endpoint to see if the indexes were loaded properly

#### When HDFS is down
1. Bring back HDFS - see [Backup recovery](BACKUP-RECOVERY.md).
2. Restart NN Finder Downloader
4. Check `/diag` endpoint to see if the indexes and files for relations graph search ("graph dicts") were loaded properly

See [Backup recovery](backup_recovery.md) for more details on how to restore HDFS data.

#### Temporary solution for when HDFS does not contain the Indexes and Training Module or its dependencies are down
1. Run **another instance** of NN Finder with the variable  and PostgreSQL variables filled with database credentials, and `ALLOW_TRAINING` set to `True`.
2. Train all indexes using `/train` endpoint - it does not communicate with Celery, but performs the operations locally.
3. When Training Module is back online, stop the newly created instance of NN Finder, as it is no longer needed.

### Error codes

|Error code|Title|Description|
|---|---|---|
|API errors|
| 701| Table not found | There is no table present in the database with the name provided. |
| 702| Invalid query type | The provided qtype keyword is not a viable query type. |
| 703| ID data parsing error | ID context data should be a list of strings. |
| 704| EMB data parsing error | EMB context data should be a string containing a list of embeddings, formatted as lists of floating point numbers. |
| 705| Invalid K value | K value should be an integer between 1 and 128. |
| 706 |Invalid user parameters |When operating on a users index, user_resource and user_action parameters must be specified. See README for possible values. |
|707 |Invalid data source for an users table |User indexes are trained exclusively with data from postgresql - change data_source parameter value to "pg" |
||
|Index errors|
| 721| Index could not be created | The KNN index creation failed. |
| 722| Index could not be trained | The KNN index training failed. |
| 723| Index not present | The KNN index you are trying to use is not present in the database. |
| 724| Index not trained | The KNN index you are trying to use has not been trained yet. |
| 725| Recommendation unsuccessful | The KNN index has failed to retrieve recommendation results. |
| 726| Not enough valid resources | Too many rows in source table were tagged as invalid, so the index cannot be created. |
| 727| Graph not present| Graph was not loaded to memory. |
| 728| Graph search failed| None of the requested IDs could be found in the graph.|
| |
|Mapping errors|
| 731| ID mapping creation failed | ID mapping creation failed |
| 732| IID-SID mapping failed | Index IDs could not be mapped to Source IDs with the currently saved mapping file. |
| 733| SID-IID mapping failed | Source IDs could not be mapped to Index IDs with the currently saved mapping file. |
| |
|Connection errors|
| 741| Database connection error | An error occured while fetching a database result. |
| |
