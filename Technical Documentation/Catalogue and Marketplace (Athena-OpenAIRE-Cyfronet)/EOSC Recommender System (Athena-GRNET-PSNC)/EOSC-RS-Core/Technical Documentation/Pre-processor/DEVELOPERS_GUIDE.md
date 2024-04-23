# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

# Guide for developers

This document explains coding conventions, typical tasks such as compilation, building and testing.


## How to run

1. Move to the *application* subdirectory `cd application`.
2. Fill in the necessary environment variables in the `settings.sh`.
3. Type `./start.sh` to run the application.

Type `./stop.sh` to stop the application.

## How to run using *docker compose*

Required version for `docker compose`: `>1.28`.

1. Copy Hadoop configuration files to `hadoop-config` directory.
2. Rename `.env.template` file to `.env` and **assign values** to needed variables.
3. Type `./docker-run.sh`

To check final configuration type `docker compose --profile dev --profile debug config`

Unexpected behavior was observed for `docker-compose`, use `docker compose` instead.


## System Design

For architectural assumptions and implementated concepts please refer to [SYSTEM_DESIGN.md](doc/SYSTEM_DESIGN.md).

## Software Quality Assurance

### Quality scans with SQAaaS

The [SQAaaS] is an on-line service for assessing multiple quality aspects. 
As a result quality "badges" are assigned.

SQAaaS acts as an umbrella service for specific validators. Some of them are 
described in next sections, below.

[SQAaaS]: https://sqaaas.eosc-synergy.eu

### Java code style checks

Done with use of Checkstyle. See [suppressions file](checkstyle-suppressions.
xml).

### Markdown linting

See [markdownlint] configuration documentation.

[markdownlint]: https://github.com/markdownlint/markdownlint/blob/main/docs/configuration.md

### JSON linting

Done with `jsonlint-cli`. See its [config file](.jsonlintrc).

### Dockerfile linting

Command: `./hadolint.sh Dockerfile --failure-threshold error`

See also:
 * configuration file `.hadolint.yaml.disabled`
 * [hadolint homepage](https://github.com/hadolint/hadolint)

### Software Bill of Materials

Automatic generation of an SBOM file is done with Maven plugin, by calling:

    mvn spdx:createSPDX

## Dump Preprocessing
Important: the file structure on hdfs and s3 is crucial for processing new dumps.
* `/user/hadoop/preproc/input/` - copied dump files
* `/user/hadoop/preproc/output/` - results of preprocessing
* `/user/hadoop/preproc/jars/` - jar files used by jobs
* `/user/hadoop/preproc/models/` - language prediction model 

The data processing is automated. 
First, dump data is fetched, then processing is started for each resource separately.
Finally, the changes are also reflected in the database. Each job can also be started manually.

### Alternative run method

Alternative run method for [Operations.md](operations/Operations.md)

#### Initial processing
If no dump has been performed before, we initiate differential processing without filling in the `previousDumpDir` parameter:
> ```
>  /transfer-and-process-all-resources?sourceDir=2023-07-15&destDir=2023-07-15-diff
> ```

### Each subsequent processing
It is necessary to indicate the folder with the result of the last processing - `previousDumpDir`.
> ```
>  /transfer-and-process-all-resources?sourceDir=2023-07-15&destDir=2023-07-15-diff-v2&previousDumpDir=2023-06-11-diff-v2
> ```

### Endpoints

#### Automated data preprocessing
<details>
 <summary><code>POST</code> <code><b>/</b></code> <code>transfer-and-process-all-resources</code></summary>

##### Parameters

> | name      |  type     | data type | description                                   |
> |-----------|-----------|-----------------------------------------------|-----------|
> | sourceDir |  required | String    | source directory (`preproc/input/`)           |
> | destDir |  required | String    | destination directory (`preproc/output/`)     |
> | previousDumpDir |  required | String    | dump name to make diff from `preproc/output/` |

##### Example cURL

> ```javascript
>  curl -X POST -H "Content-Type: application/json" --data @post.json http://localhost/transfer-and-process-all-resources?sourceDir=2023-07-15&destDir=2023-07-15-diff-v2&previousDumpDir=2023-06-11-diff-v2
> ```

</details>

------------------------------------------------------------------------------------------
#### Transferring data from S3 to HDFS
<details>
 <summary><code>POST</code> <code><b>/</b></code> <code>run-s3-to-hdfs-job</code></summary>

##### Parameters

> | name      | type         | data type | description |
> |--------------|-----------|-------------|-----------|
> | sourceDir | not required | String    | N/A         |
> | sourceFiles | not required | String    | N/A         |
> | destDir | not required | String    | N/A         |

</details>

------------------------------------------------------------------------------------------
#### Processing data
<details>
 <summary><code>POST</code> <code><b>/</b></code> <code>run-oag-preproc-job</code></summary>

##### Parameters

> | name      | type         | data type | description |
> |--------------|-----------|-------------|-----------|
> | inputFiles | required | String    | N/A         |
> | outputDir | required | String    | N/A         |
> | previousDumpDir | not required | String    | N/A         |
> | resourceType | required | String    | N/A         |

</details>

<details>
 <summary><code>POST</code> <code><b>/</b></code> <code>run-trainings-preproc-job</code></summary>

##### Parameters

> | name      | type         | data type | description |
> |--------------|-----------|-------------|-----------|
> | inputFiles | required | String    | N/A         |
> | outputDir | required | String    | N/A         |
> | previousDumpDir | not required | String    | N/A         |

</details>

<details>
 <summary><code>POST</code> <code><b>/</b></code> <code>run-marketplace-preproc-job</code></summary>

##### Parameters

> | name      | type         | data type | description |
> |--------------|-----------|-------------|-----------|
> | inputFiles | required | String    | N/A         |
> | outputDir | required | String    | N/A         |
> | previousDumpDir | not required | String    | N/A         |
> | resourceType | required | String    | N/A         |

</details>

------------------------------------------------------------------------------------------
#### Updating DB
<details>
 <summary><code>POST</code> <code><b>/</b></code> <code>run-db-updater-job</code></summary>

##### Parameters

> | name      | type        | data type | description |
> |-------------|-----------|-------------|-----------|
> | dumpDir | required | String    | N/A         |
> | resourceType | required | String    | N/A         |

</details>

------------------------------------------------------------------------------------------

