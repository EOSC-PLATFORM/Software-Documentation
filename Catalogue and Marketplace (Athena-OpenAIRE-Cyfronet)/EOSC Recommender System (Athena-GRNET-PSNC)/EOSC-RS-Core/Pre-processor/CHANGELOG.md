# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [Unreleased version]

### Added

### Changed

### Fixed

### Removed


## [2.1.2]

### Added

- training resource synchronization and backup
- updating popularity counters based on dump
- operation for training re-initialization


## [2.1.1]

### Changed

- Logging level for session remover


## [2.1.0]

### Added

- Differential processing - Spark Job
- Job reflecting changes between dumps in the database
- Language prediction for resources - Spark Job

### Changed

- Spark Job for resource processing - the way of language detection

### Fixed

- removed stack trace logging when receiving an unsupported resource type


## [2.0.0]

### Added

- Differential processing - Spark Job
- Job reflecting changes between dumps in the database
- Language prediction for resources - Spark Job

### Changed

- Resources preprocessing (in terms of the processed columns and the method of processing)


## [1.5.1]

### Changed
- Type of message (JMS) for recommendation evaluation 


## [1.5.0] M25

### Added
- Integration with JMS - BETA
- Backup of recommendation event
- Preprocessing recommendation evaluation event
- Creating Kafka topic on startup

### Changed
- [hadoop.sh](operations/hadoop.sh) now supports multiple Hadoop
  configurations, more in [README](hadoop-config/README.md)
- Synchronization of services extended by storing a description
- The diagnostic endpoint extended to return:
  - Kafka status with available topics
  - Application version
- Adapting jobs to new format of data

### Fixed

### Removed


## [1.4.0] M23.5

### Added

- Documentation:
  - CODE_OF_CONDUCT.md
  - CONTRIBUTING.md
  - Monitoring.md that covers checking health at run-time
  - LICENSE.txt
  - STRUCTURE.md
  - LoadTesting.md
  - Diagnostics.md
- Implementation of load tests: for processing user actions and for processing dumps.
- Logging summary for Spark Jobs
- Database reinitialization operation when processing a new dump
- Basic statistics generator for new dump samples
- Preprocess Marketplace resources - Spark Job
- Persist commands regarding Spark Jobs
- Endpoint for semi-automatic preprocessing of new dump
- Job tests unification
- Configuration files for linters and validators: hadolint, jsonlint-cli, 
  checkstyle
- Script hadolint.sh that enables easy run of hadolint

### Changed

- README.md split into smaller files: DEVELOPERS_GUIDE.m, TODO.md, USAGE.md
- DEVELOPERS_GUIDE.md extended with section 'Software Quality Assurance'
- Preprocessing Trainings - fields added
- Preprocessing OAG resources - fields added
- Rename database columns (\[week/month\]_orders -> orders i \[week/month\]_visits -> visits)


## [1.3.0] - 2023-01-25 - M22

### Added
- Support for new resource type - "data source" (User Actions)
- Publishing changes about User data
- Publishing changes about Service data
- Extract additional data from trainings dump (Spark Job)


## [1.2.0] - 2022-12-14

### Added

- CHANGELOG file
- Service data synchronization (mp_db_events)
- Support for Other Research Product
- Set of utility script to facilitate Ops Team daily routines
- Documentation for the Ops Team: [Operations.md](operations/Operations.md)

### Changed

- User Session format
- Muted unnecessary logs related to JMS publishing
- Format of resources (OAG and trainings) for Spark Jobs

### Fixed

- Infinite re-delivery of JMS events in case of error


## [1.1.0] - 2022-10-20

### Added

- Backup of raw Resource Events (mp_db_events)
- User data synchronization (mp_db_events)
- User's id correlation from different sources

### Changed

- User Session format - fields added


## [1.0.0] - 2022-10-10

### Added

- Preprocessing User Actions
- User Sessions composer
- User Sessions publisher
- Artificial User Action generator
- Separate flow for Artificial User Actions
- Support for different versions of User Action
- Backup of raw User Actions
- Health check endpoint
- Preparing Spark launcher
- Preprocessing Trainings - Spark Job
- Preprocessing OAG resources - Spark Job
- Transferring files from S3 to HDFS - Spark Job
- Kafka integration
- JMS integration (via STOMP)
- PostgreSQL integration
- Docker integration


[Unreleased version]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/compare/diff?targetBranch=refs%2Ftags%2F2.1.2&sourceBranch=refs%2Fheads%2Fmaster&targetRepoId=2988
[2.1.2]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F2.1.2
[2.1.1]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F2.1.1
[2.1.0]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F2.1.0
[2.0.0]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F2.0.0
[1.5.1]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F1.5.1
[1.5.0]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F1.5.0
[1.4.0]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F1.4.0
[1.3.0]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F1.3.0
[1.2.0]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F1.2.0
[1.1.0]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F1.1.0
[1.0.0]: https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse?at=refs%2Ftags%2F1.0.0
