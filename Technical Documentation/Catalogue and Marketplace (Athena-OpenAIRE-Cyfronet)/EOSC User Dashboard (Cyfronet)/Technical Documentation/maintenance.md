# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

- Purpose of the document and intended audience.
- Overview of the maintenance procedures covered in the documentation.

## Maintenance Overview

- Regular maintenance EOSC User Dashboard of the is crucial tasks to ensure the stability and performance of the service.

## Regular Maintenance Tasks
- Tracking a system that monitors emerging errors, e.g. Sentry. 
- Monitoring all application components and dependencies using monitoring system, e.g. Zabbix
- On the server side: updating system packages, load checking hardware resources, increasing resources if necessary, e.g. adding RAM, CPU, storage

## Upgrades and Updates

- New release should be first deployed to a staging environment and tested. Before updating the software, we recommend making a copy of the databases; in case of unexpected problems, restore the database copies and the previous version of the software.

## Patch Management

- Process for applying security patches and updates.
- Steps to ensure the software is up-to-date.

## Backup and Restore

- See Backup and Recovery 

## Troubleshooting

- See Troubleshooting

## Health Checks

- Regular health checks and monitoring procedures.
- How to identify potential issues before they become critical.

## Disaster Recovery

- See Disaster Recovery 

## Documentation and Training

- See Documentation and Training

## References

- https://github.com/cyfronet-fid/eosc-user-dashboard/blob/master/README.md
