# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

The purpose of the document is to provide a set of guidelines and best practices for maintaining the software.

It covers:

* Regular maintenance tasks
* Upgrades and updates
* Data management
* Troubleshooting
* Health checks

## Regular Maintenance Tasks

Regular maintenance tasks include:

* Checking that the service is running properly (covered in [Health Checks](#health-checks))
* Starting dump processing in the cluster when a new one is available - [processing dump files](../operations/Operations.md#processing-dump-files)

## Upgrades and Updates

Versioning of this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

At the end of each version iteration, major or minor, the following should be done:
- Update [README.md](../README.md) and [CHANGELOG.md](../CHANGELOG.md)
- Tag the commit with version

### Major Releases

Major releases describe a significant change in the software (i.e. a completely new feature). A breaking change (i.e. a change in the API) is also considered a major release.

In the case of a breaking change it must be explicitly written in the:

* release notes [CHANGELOG.md](../CHANGELOG.md)
* the [README.md](../README.md) file

and also communicated to the users of the software.

### Minor Releases

Minor releases describe a change in the software that does not break the API. These releases can include:

* New features
* Bug fixes
* Performance improvements
* Security patches
* Documentation updates

### Patches

Patches are small changes that fix bugs or security issues that is important to be quickly resolved. They do not include any new features or breaking changes.

Patches should be modular meaning that they cover a specific issue and do not include any other changes.


## Troubleshooting

Basic troubleshooting is done by using the `GET /actuator/health` endpoint and acting accordingly to the output.

The most common issues can stem from:
- bad connection to other modules and dependencies
- problems with configuration and deployment


## Health Checks

The health checks are performed by the `GET /actuator/health` API call. The call checks the following:

* the application is up and running
* version of the application
* status of connection to PSQL, JMS and Kafka

Concerning monitoring check [MONITORING-LOGGING.md](MONITORING-LOGGING.md).