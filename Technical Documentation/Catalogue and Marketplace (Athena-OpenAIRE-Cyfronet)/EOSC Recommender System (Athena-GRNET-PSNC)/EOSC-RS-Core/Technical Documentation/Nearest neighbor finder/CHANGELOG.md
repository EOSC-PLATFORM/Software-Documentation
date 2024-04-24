# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.4.2] = 2023-11-29
### Added
- Documentation files in /docs
- RESOURCE_LANGUAGES variable for resource filtering now can contain multple entries, defined as a list
- If startup indexes were not loaded properly, try again every 10 minutes.
- Added details flag to /diag endpoint
### Fixed
- Updated Python version to 3.8

## [1.4.1] = 2023-09-06
### Added
- Resource language filtering in training

## [1.4.0] = 2023-08-29
### Added
- Naming of resources (for now only in graphs)
- /diag endpoint in downloader which is passed to fastapi's diag
- HDFS and graph dicts availability is checked regardless of USE_DOWNLOADER
- Tables rename (index tag 1.4.0)
- Data_sources table
- Index tag in README
- Resource language filtering
### Fixed
- Changed failed graph search message from exception to warning in status
- Missing tables in pg now don't cause INCOMPLETE DATA diag status in this module
- Removed unnecessary cyclic download in downloader
- Downloader's /download_index/ passes downloaded indexes to fastapi even if some failed
- Added exception in /train
- Corrupted indexers list in diag
- Empty assertion error when checking for none indexer
- Dependencies description in README
- More extensive logging on DEBUG level
- Exceptions refactor, one line logs for unhandled exceptions
### Removed
- HDFS data source in training

## [1.3.2] = 2023-07-27
### Added
- new /diag status: INCOMPLETE DATA together with fields for missing data
- utils file for general functions (/app/core/functions/utils.py)
- new HDFS folders for index segregation
- moved index configuration from tables_config.py to tables_config.json loaded by app/settings.py
- added force_direct_update parameter to update_index
- on startup: index tag, indexes available in HDFS
- diag now shows stamped Indexer names
- INIT_TABLES now require the inclusion of users tables
### Fixed
- Indexer class: added table properties and exact stamped name
- general indexer file naming functions for consistency and clear code
- refactor in index deletion
- HDFS training validates for only .parquet source files
- resource naming in graph dicts
- fixed index update without downloader
- startup loading now works without relying on clocks, but on api-downloader communication
- diag checks for missing indexes, postgres tables and graph dicts
- downloader's logged module name
- Some error exception codes

## [1.3.1] = 2023-07-07
### Added
- Graph neighbor search on zenodo resources
- Filtering of invalid resources
- HDFS training on parquet files instead of csv
- LOAD_NEW_DATA.md
### Fixed
- Validation on searching by non-existent IDs
- When non-existent IDs appear in the context, the results for valid ones are still returned. ID search result now also returns context IDs.
- Documentation, style, typing
- Search graph exceptions

## [1.3.0] = 2023-06-05
### Added
- Downloader service, downloading indexes to local files in parallel to API
- New indexer version with faster bidirectional mapping and embedding reconstruction
- Full context data validation
- Training permission controlled by env variable
### Fixed
- separate env vars for removing zeroed vectors in users & resources
- HDFS training binary format decoding
- requirements.txt - removed version constraints
- added tree to STRUCTURE.md
- pylint style fixes

## [1.2.4] = 2023-04-28
### Added
- SQAaaS files: CONTRIBUTING, DEVELOPERS_GUIDE, STRUCTUE (mock), TODO (mock)
- Raised max K neighbors from 64 to 128
- Added version tag to diag
### Fixed
- Unnecessary slash in diag endpoint
- Markdownlint style improvements

## [1.2.3] = 2023-03-10
### Added
- Moved context data in /search endpoint from param to body
- CITATION, CODE_OF_CONDUCT
### Fixed
- Minor style and implementation refactors
- Missing docstrings

## [1.2.2] = 2023-02-17
### Added
- Unit tests
- LICENSE
- Version tag logging on startup
### Fixed
- Code style refactoring (pylint, flake8)
- Removed MySQL support

## [1.2.1] = 2023-01-25
### Added
- When training an index, the zeroed out vectors are removed from the training data, but only if it doesn't leave less than 8 vectors in the dataset.

## [1.2.0] = 2022-12-14
### Added
- Added usage of users indexes parametrized by user action and resource
- Added postgresql
- Added dynamic loading of users (which are also trained dynamically by training module)
- Cleaned up logging

## [1.1.0] = 2022-10-20
### Added
- Added AAI users index
- Expanded diagnostics endpoint
- Set connection timeouts

## [1.0.0] = 2022-09-15
### Added
- API endpoints for search, index update, diagnostics and training of EOSC portal resources and users+
- Nearest Neighbor Finder search for datasets, publications, software, otherresearchproduct, services, trainings
- Nearest Neighbor Finder search for users and anonymous users
- Search returns IDs or Embeddings of result items
- Saving up to 3 latests indexes of selected dataset in HDFS
- Training indexes with data from MySQL and HDFS
