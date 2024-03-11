# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

The description of the Deployment process provides in this sections, considers that Deployment is the process in which the helpdesk is put into production, while the installation of the helpdesk which is described in another section focuses on the technical setup of the machine and helpdesk application. The goal of the Deployment process is to reach the Production Readiness status for the application, in this way the installation can be considered as one single action in the Deployment process.  

The Deployment of the EOSC helpdesk consists of several main steps, which should be performed first in staging environment and after thorough testing implemented in production. The steps are: 

* Installation and Configuration:
 * Install helpdesk server in secure environment (Installation Section)
 * Configure DNS 
 * Apply main configuration ( Configuration Section )

* Integration with Email 
 * Integrate with Emailbox as described in Configuration Section. 
 * Add multiple mailboxes depending on requirements of the communities. 

* Integration with AAI (Authentication and Authorization Infrastructure) Service:
 * Integrate the Helpdesk with your organization's AAI service for centralized user authentication.
 * Test the integration first in testing environment 

* User Groups and Roles Definition:
 * Define user groups based on the organizational structure or support tiers.
 * Establish roles such as administrators, agents, and end-users with appropriate permissions.
    
* Assignment of Agents to Groups:
 * Assign agents to specific groups, be sure that agents are commited to manage the tickets. 
 * Ensure a balanced distribution of workload among different support teams.
 * Implement mechanisms for efficient ticket routing and escalation according to the procedures defined by ISRM process. 

* Helpdesk buiding 
 * Apply all custom modifications to the helpdesk as described in the Building section. 
 * Test all functions in the testing environment for each custom package. 

* Integration of the Helpdesk with Web portals 
 * Provide the helpdesk webform code snippets to submit the tickets via web portals. 
 * Test the submission and proper function of the webforms. 

* Knowledge Base setup 
 * Establish a Knowledge Base 
 * Allow agents to modify the Knowledge Base. 

* Setup of backup and disaster recovery
 * Implement regular backup procedures for helpdesk database, configurations and if possible whole Helpdesk VM. 
 * Develop a disaster recovery plan. 
 * Test the backup and recovery processes. 

* Monitoring and logging 
 * Set up monitoring tools, check that internal helpdesk monitoring is working 
 * Connect Helpdesk to local monitoring (if available) and external EOSC monitoring systems
 * Configure logging to capture relevant events for debugging

* Privacy and security 
 * Implement security measures as described in the Security section. 
 * Consider to establish Data Processing Agreements (DPA) and Joinst Controller Agreements (JCA) with all organizations which have access to the Helpdesk and user data or integrate their helpdesks with EOSC Helpdesk. 
