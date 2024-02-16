# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.4.2] = 2023-11-29
### Added
- Documentation files in /docs
- RESOURCE_LANGUAGES variable for resource filtering now can contain multple entries, defined as a list
- Added details flag to /diag endpoint
### Fixed
- Updated Python version to 3.8

## [1.4.1] = 2023-09-06
### Added
- Resource language filtering in training

## [1.4.0] = 2023-08-29
### Added
- Checks if the worker is on before sending the train task
- Added celery worker check to diag
- Tables rename (index tag 1.4.0)
- Data_sources table
- Index tag in README
- Resource language filtering
### Fixed
- Dependencies description in README
- More extensive logging on DEBUG level
- Exceptions refactor, one line logs for unhandled exceptions
### Removed
- HDFS data source in training
- /test-celery-task endpoint

## [1.3.2] = 2023-07-27
### Added
- new /diag status: INCOMPLETE DATA together with fields for missing data
- utils file for general functions (/app/core/functions/utils.py)
- new HDFS folders for index segregation
- moved index configuration from tables_config.py to tables_config.json loaded by app/settings.py
### Fixed
- Indexer class: added table properties and exact stamped name
- general indexer file naming functions for consistency and clear code
- refactor in index deletion
- HDFS training validates for only .parquet source files
- logging in worker and on startup of main api

## [1.3.1] = 2023-07-07
### Added
- Filtering of invalid resources
- HDFS training on parquet files instead of csv
### Fixed
- Dynamic interval env variable unit changed to minutes

## [1.3.0] = 2023-06-05
### Added
- New indexer version with faster bidirectional mapping and embedding reconstruction
### Fixed
- separate env vars for removing zeroed vectors in users & resources
- HDFS training binary format decoding
- celery worker error logging
- requirements.txt - removed version constraints
- test_setup.txt changes
- added tree to STRUCTURE.md
- pylint style fixes

## [1.2.3] = 2023-04-28
### Added
- SQAaaS files: CONTRIBUTING, DEVELOPERS_GUIDE, STRUCTUE (mock), TODO (mock)
- Added version tag to diag
### Fixed
- Unnecessary slash in diag endpoint
- Logging format
- Users indexes not deleting properly
- Markdownlint style improvements

## [1.2.2] = 2023-03-10
### Added
- train_all/ endpoint
- Devutils flake8, pylint, black, pre-commit
- LICENSE, CITATION, CODE_OF_CONDUCT
- Updated README
- Version tag is now logged on startup
### Fixed
- Minor style and implementation refactors
- Missing docstrings

## [1.2.1] = 2023-01-25
### Added
- When training an index, the zeroed out vectors are removed from the training data, but only if it doesn't leave less than 8 vectors in the dataset.

## [1.2.0] = 2022-12-14
### Added
- Dynamic training of users indexes
- Exceptions for training of users indexes
### Fixed
- Moved metadata table for HDFS index training from MySQL to PostgreSQL
- Dependencies mismatch
- Training new users indexes now deletes the old ones (apart from the amount specified in enviroment variable MAX_N_INDEXERS)
- Updated description in fastapi docs

## [1.1.0] = 2022-12-01
### Added
- Users training from PostgreSQL
- 2 new optional parameters that are required for users training
### Fixed
- Table naming

## [1.0.0] = 2022-11-30
### Added
- Resources training from PostgreSQL
### Fixed
- Logging levels
- Moved table properties to a separate file tables_config

## [0.1.2] = 2022-10-28
### Fixed
- Mysql training
- Indexer

## [0.1.1] = 2022-10-17
### Added
- Expanded diagnostics endpoint
- Set connection timeouts

## [0.1.0] = 2022-09-15
### Added
- API endpoint for training, with data source specification - MySQL or HDFS
- Nearest Neighbor Finder search for datasets, publications, software, otherresearchproduct, services, trainings
- Saving up to 3 latests indexes of selected dataset in HDFS
