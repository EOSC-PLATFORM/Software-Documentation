# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

### Important note

*Interoperability Registry is inherently connected with the Service Cataloge Infrastructure, sharing common resources, installation and deployment. Hence, same policies, instructions and procedures apply for both components.* 

### Intended audience

- Admins that are responsible for maintaining the EOSC Service Catalogue component
- Security admins for providing access to EOSC Service Catalogue proprietary features
- EOSC Core Component tech leads/integrators
- Anyone  else that  needs  to  configure, build, install and maintain an instance of the EOSC Service Catalogue software and services

## Maintenance Overview

- Real user monitoring and maintainance for EOSC Service Catalogue involves collecting data directly from end-users for real-time insights. It, therefore, provides a comprehensive understanding of how Service Registry and Providers Portal are performing and identifies any issues that may be impacting users.
- High-level view of the maintenance tasks described.

## Regular Maintenance Tasks

Regular real-time maintainance tasks are Availability Monitoring, Performance Monitoring, Error Monitoring and Resource Monitoring.

- Availability Monitoring: This type of monitoring ensures that applications are accessible and operational for Providers.
- Performance Monitoring: Performance monitoring measures the response time and throughput of endpoints to maintain optimal performance levels.
- Error Monitoring: Log tracking for exceptions and errors in back-end console
- Resource Monitoring: Resource monitoring tracks resource usage, such as CPU, memory, and disk space, to ensure that Service Cataloge and Providers Portal have the necessary resources to run effectively.

## Upgrades and Updates

- Major upgrades come after agreement among all affected EOSC Core components. A downtime is agreed and communicated, prior to the new codebase release. Steps to rollback to prior version in case of issues are pre-agreed.
- Minor upgrades are released frequently, during non-business hours, for minimal effect on users and downtime.

## Patch Management

- Security patches and software updates are applied when necessary, after backup of system and data have taken place. Latest versions of software libraries are applied when necessary. Security patches are applied more frequently, based on severity and impact of identified issue.

## Backup and Restore

- Instructions on backup and recovery can be found in the [Backup and Recovery section](backup-recovery.md)

## Data Management

- All data are stored in a Relational Database, which is backed up at regular intervals. Data migration occurs when critical changes in Profile definitions affect stored data. In that case, data migration is handled on a per-case basis, using custom scripts. No need for data retention has been identified. 

## Performance Tuning

- Performance monitoring is done using classic dev ops tools slowly migrating to the use of tools like Sentry.

## Troubleshooting

- Common maintenance issues are mostly related to interoperation issues to other EOSC Core components and their availability.
- Problems are diagnosed using health check probes, and are resolved using log information.

## Health Checks

- Health checks are provided by automatic probes gathering resources from API endpoints, actuators and static html content at regular intervals. In case error codes are returned, email messages to admins are sent.

## Disaster Recovery

- Information relating to disaster recovery may be found in the Service Availability and Continuity Management plan for this service,  within the EOSC Service Management System (SMS): <https://wiki.eoscfuture.eu/display/EOSCSMS/EOSC+Service+Catalogue+Capacity+plan>

## Documentation and Training

- Instructions on how to keep maintenance documentation up to date can be found in [documentation and training section](documentation-training.md)
- Maintenance personnel can use [Configuration](configuration.md), [Installation](installation.md), and [Deployment](deployment.md) sections for up-to date instructions.

## References

- Links to external resources, documentation, articles related to maintenance practices.
