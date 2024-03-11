# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

This document concerns the guidelines and best practices for maintaining the NN Finder Training Module. It describes the basic procedures for regular maintenance tasks, upgrades, and TROUBLESHOOTING. More details about each of the topics can be found in the referenced documents.

## Regular Maintenance Tasks

To make sure that proper functioning of the system is kept, the following tasks should be performed regularly:
- Periodically chechk the status of the system using the `/diag` endpoint.
- Check the endpoints using example queries to make sure they are working properly.
- Check the logs for any errors or warnings.
- Monitor the system (memory, CPU usage) for any unexpected behavior.

## Upgrades and Updates

Versioning of this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

At the end of each version iteration, major or minor, the following should be done:
- Update README and CHANGELOG.
- Update the default variables, as well as the `.env` file. Especially keep in mind the following variables in `settings.py`:
  - `VERSION_TAG` - defines the version of application and must be the same as last tag in the repository.
  - `INDEX_TAG` - defines the version of the index and the directory of index storage in HDFS. Every time it is changed, a new directory in HDFS index storage must be created, named after the tag, and new indexes trained under it using the Training Module also deployed under the new tag.

### Specifying the Index Tag
  For the sake of clarity, it is best practice to keep `INDEX_TAG` the same as `VERSION_TAG`, which means re-training indexes and placing them in a new directory on every update. This is not always necessary, as not all application updates change the index structure, and some may be backwards-compatible to the previous index version. In such cases, no data in HDFS would need to change and the `INDEX_TAG` would be kept as the old tag. However, this is not recommended, as it may lead to confusion and errors.

## Patch Management

All minor fixes and patches should be done in a separate branch, and then merged into the `master` branch. The `master` branch should be tagged with the new version number, and the version should be updated accordingly to [Upgrades and Updates](#upgrades-and-updates).

## Backup and Restore

All data for the functioning of NN Finder Training Module is stored in a PostgreSQL database. As long as the data in the database is not removed, this module can be restarted at any time with no data loss. More details can be found in [Backup recovery](backup_recovery.md).

## Data Management

In any instances of data migration or data retention, the environment variables should be updated accordingly. The variables necessary for deployment can be found in [Configuration](CONFIGURATION.md).

## Troubleshooting

Basic troubleshooting is done by using `/diag` endpoint and acting accordingly to the output.

The most common issues can stem from:
- missing or corrupted data in remote storage
- bad connection to other modules and dependencies
- problems with configuration and deployment

More deails can be found in [Troubleshooting](TROUBLESHOOTING.md).

## Health Checks

Health checks are done by using `/diag`. For additional information about the state of the module, use the `/diag` endpoint with the `details` parameter set to True.

More deails can be found in [Troubleshooting](TROUBLESHOOTING.md).

## Disaster Recovery

In case of a distaster failure of all systems, data in PostgreSQL and HDFS should be restored from backups, and then the NN Finder applications can be redeployed or restarted.

Procedures for recovering from system failures can be found in [Troubleshooting](TROUBLESHOOTING.md).

## Documentation and Training

See [Documentation and Training](DOCUMENTATION-TRAINING.md) for details on how to maintain the documentation and train new developers.

## References

All references to other documents can be found in [References](REFERENCES.md).
