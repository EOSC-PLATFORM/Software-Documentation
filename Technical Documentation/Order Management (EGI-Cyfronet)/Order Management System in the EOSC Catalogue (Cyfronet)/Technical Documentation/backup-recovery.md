# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Backup and Recovery

Information relating to backup and recovery may be found in the Service Availability and Continuity Management plan for this service,  within the EOSC Service Management System (SMS):

<link to the SACM plan, currently under: <https://wiki.eoscfuture.eu/display/EOSCSMS/Capacity+plans+database> >



The Ordering Management System is a component of the EOSC Catalogue & Marketplace, built on the PostgreSQL database. As a result, some sections of this documentation will overlap with the documentation for the Marketplace, as they share common elements.
nformation relating to disaster recovery may be found in the Service Availability and Continuity Management plan for this service, within the EOSC Service Management System (SMS):

https://wiki.eoscfuture.eu/display/EOSCSMS/EOSC+Catalogue+and+Marketplace+Capacity+plan

The backup restoration procedure should include restoring the PostgreSQL database of all components:

To backup/recovery we recommend pg_dump utility for backing up a PostgreSQL database https://www.postgresql.org/docs/current/app-pgdump.html 

## Create backup: 
###
pg_dump mp_production > mp_production.sql

## Restore backup:
### create database

echo "CREATE DATABASE mp_production" | psql -U postgres

### restore database from dump

cat mp_production.sql |  psql -U postgres mp_production


Additionally, the Marketplace Ordering System is tightly integrated with a ticketing system of a choice (in EOSC Future it’s JIRA) and the information regarding their backup and recovery procedures should be available in the documentation dedicated to these tools.

