# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

##Introduction

Regular maintenance of OpenPlato is crucial to ensure the stability, high availability and performance of the service. Key maintenance tasks include software updates, security patches, hardware and software optimisation, and routine monitoring tasks.

##Regular Maintenance Tasks

Perform monitoring checks for internal and external monitoring systems. Check the health of hardware, CPU load, RAM Load and availability of disk space if these metrics are not included in the local monitoring probes. Deploy new releases according to the schedule agreed with EOSC governance. Announce any important events which affect OpenPlato's function, like downtimes at least 24 hours in advance. Announce any emergency situations immidiatelly using the helpdesk broadcast feature.

##Upgrades and Updates

Any new release should be first deployed to staging environement and thoroughly tested. Especially all custom functions should be checked before deploying the release into production environment. The release schedule for OpenPlato follows the Moodle release schedule but might be delayed in order to wait for the most stable version.

##Patch Management

In case of security releases, apply patches immediately on staging system and after on production system, as these changes are considered as emergency changes. If possible send a short broadcast to all logged learners about short interuption of the service.

##Backup and Restore

See Backup and Restore section

##Data Management

Use the HA databases if possible, keep the backups no more than 3 months on the backup storage.

##Performance Tuning

Apply hardware and software performance tuning measures as described in Installation and Configuration sections.

##Troubleshooting

Check logging and monitoring information. Consult with Moodle troubleshooting pages in the documetation.

##Health Checks

Perform regular health checks and monitoring history to identify any faulty periods. For faulty periods analyse logging information to understand what was the cause of the problem. 

##Disaster Recovery

See Disaster Recovery section.

##Documentation and Training

See Documentation and Training section.

##References

See References section. 