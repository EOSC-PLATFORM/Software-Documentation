# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

This document is intended to provide an overview of the maintenance of an instance of the GOCDB software.

## Maintenance Overview

If certificate authentication is used, then intermediate, root certificates and certificate revocation lists should be regularly updated.

Underlying infrastructure should be maintained following organisational and community best practices.

## Upgrades and Updates

Details around upgrading the database structure used by GOCDB can be found here: https://github.com/GOCDB/gocdb/blob/dev/INSTALL.md#updateddl

## Backup and Restore

Information relating to backup and recovery may be found in the Service Availability and Continuity Management plan for this service, within the EOSC Service Management System (SMS): https://wiki.eoscfuture.eu/display/EOSCSMS/SACM%3A+EOSC+Topology+Availability+and+Continuity+plan

Scripts and documentation to enable a read-only failover can be found here: https://github.com/GOCDB/gocdb-failover-scripts 

## Troubleshooting

Typical User issues are documented here: https://docs.egi.eu/internal/configuration-database/faq/

## Health Checks

GOCDB status page is helpful in diagnosing operational problems, it can be found under /portal/GOCDB_monitor/

## Disaster Recovery

Information relating to backup and recovery may be found in the Service Availability and Continuity Management plan for this service, within the EOSC Service Management System (SMS): https://wiki.eoscfuture.eu/display/EOSCSMS/SACM%3A+EOSC+Topology+Availability+and+Continuity+plan
