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
* Checking if any package vulnerabilities have been reported and doing the necessary updates (covered in [Upgrades and Updates](#upgrades-and-updates))


The frequency of these tasks depends on the criticality of the issue.

## Upgrades and Updates

Upgrading and updating the software is done through **GitHub releases**.

Releases can be separated into 3 categories:

* Major releases (i.e. 1.4.2 -> 2.0.0)
* Minor releases (i.e. 1.4.2 -> 1.5.0)
* Patch releases (i.e. 1.4.2 -> 1.4.3)

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

Most issues concerning the service will be a consequence of:

* no access to one of the related modules: Online engine, Marketplace RS, Content-based engine or Provider-Insights.


## Health Checks

The health checks are performed by the `diag` API call. The call checks the following:

* the application is up and running
* version of the application
* status of connection to modules: Online engine, Marketplace RS,  Content-based engine, Preprocessor, Nearline engine, Nearest neighbor finder, Nearest neighbor finder training module, Provider insights

Concerning monitoring check [MONITORING-LOGGING.md](MONITORING-LOGGING.md).