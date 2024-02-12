# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Disaster Recovery

Information relating to disaster recovery may be found in the Service Availability and Continuity Management plan for this service,  within the EOSC Service Management System (SMS):

<link to the SACM plan, currently under: <https://wiki.eoscfuture.eu/display/EOSCSMS/Capacity+plans+database> >


Disaster recovery planning for an application like Marketplace & Search Service is crucial to ensure the resilience and continuity of operations in the face of unexpected events. 
A comprehensive disaster recovery strategy would involve steps such as data backups, redundancy, and failover mechanisms.
It's essential to identify potential disasters, whether they are natural, like earthquakes or floods, or technological, such as server failures or cyberattacks, and prepare accordingly.


One key aspect of disaster recovery for the Marketplace & Search Service application is the regular backup of critical data. 
This should include both the application's codebase and the data it processes. 
Backups can be stored offsite, preferably in a secure and geographically distant location, to safeguard against localized disasters.


When restoring the system from a backup, we must be prepared to recreate the entire procedure we performed deploying the application. 
From creating virtual machines, through running applications in docker containers and restoring the state of databases.
