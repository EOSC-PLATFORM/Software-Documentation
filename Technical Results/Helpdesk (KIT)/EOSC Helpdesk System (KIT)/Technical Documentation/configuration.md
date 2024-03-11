# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

This configuration process of the EOSC Helpdesk involves several key components, including the selection of appropriate execution environment e.g. HA cluster, defining user roles and permissions, establishing communication channels and implementing automated workflows where it's applicable. Each element and its proper configuration contributes to the overall functionality and effectiveness of the helpdesk. 

## Configuration Overview

The major components of the heldpesk which require proper configuration are: 

* Email Channel:
    Setup mailbox outside of the helpdesk to capture and send the mails to and from helpdesk.
    Configuration of the email integration to capture and convert incoming emails into tickets.
    The could be multipe mailboxes connected to different groups 

* Web Forms:
    Customization and deployment of the web forms for users to submit tickets through different web portals of the user communities. 
    Connection of the webforms to different groups 

* User Interface:
    Branding and different weblinks on the login page and user dashboard. 
    Customization of the dashboards and views to display relevant information for users and support agents. Two main cases are considered here: ticket creation and ticket edit masks. 

* Telegram Bot:
    Integration of a Telegram bot for users to submit and receive updates on their tickets.
    Configuration of the bot responses and actions to align with the helpdesk workflow.

* Knowledge Database:
    Organization of the knowledge base with relevant articles and solutions.
    Defition of the rules and responsibilities to fill the Knowledge Database. 

* Nginx Webserver:
    Set up and configuration of the Nginx web server to handle secure connections to the helpdesk.
    Implementation of the  SSL/TLS certificates to ensure encrypted data transmission.

* Group List:
    Definition and configuration of the groups within the helpdesk for efficient ticket assignment.
    Assignment of group-specific roles and permissions according to the Incident and Request Management policies (ISRM). 

* Roles:
    Define user roles and permissions to control access levels within the helpdesk.
    Assign roles based on responsibilities in the group, definition of the group leader and group crew. 

* User Authentication and Authorization SAML Interface:
    Configuration of SAML interface for user authentication based on the requirements of the EOSC AAI team.
    Integration of the helpdesk with EOSC AAI by following the integration procedure of EOSC AAI team. 

* Notification Configuration:
    Customization of the notification settings for email alerts, in-app notifications according to ISRM defintions. 
    Define triggers for notifications based on ticket status changes or specific events.

* Escalation Configuration Procedure:
    Setup of escalation procedures for unresolved or delayed tickets. 
    Define escalation triggers, time frames, and notifications for each escalation level.


## Configuration Files

The main configuration files for EOSC Helpdesk are stored on the machine which hosts the Helpdesk: 

* Standard NGINX webserver configuration file: /opt/zammad/contrib/nginx/zammad-ssl.conf 
* Backup configuration for cron job: /etc/cron.d/zammad-backup 
* Group configuration: [https://wiki.eoscfuture.eu/display/EOSCF/Support+Groups+Overview](https://wiki.eoscfuture.eu/display/EOSCF/Support+Groups+Overview)

## Configuration Parameters and Environmental Variables

The detailed description of some configuration paramenters and environmental variables is given at: 

[https://docs.zammad.org/en/latest/admin/console.html#working-on-the-console](https://docs.zammad.org/en/latest/admin/console.html#working-on-the-console)

The EOSC Helpdesk implements mostly default values of main configuration paramenters, which are listed on the provided page above. 

## Security Considerations

The description of the security configuration and procedures is provided at https://admin-docs.zammad.org/en/latest/settings/security.html. 

## Configuration Management

After the installation of the Zammad software is accomplished the instance should be configured. The main configuration steps include: 

* **Web Server Configuration:**
* Configure NGINX web server according [https://docs.zammad.org/en/latest/getting-started/configure-webserver.html](https://docs.zammad.org/en/latest/getting-started/configure-webserver.html) 
* Setup SSL/TLS to secure Zammad: [https://docs.zammad.org/en/latest/getting-started/configure-webserver.html#get-a-ssl-certificate-recommended](https://docs.zammad.org/en/latest/getting-started/configure-webserver.html#get-a-ssl-certificate-recommended) 
* **Zammad Configuration File:**
    * Modify the Zammad configuration file to customize settings. The configuration file is typically located  at <code><em>/etc/zammad/zammad.conf.</em></code>
    * Configure settings such as time zone, default language, and other application-specific parameters.
    * Apply further customization as described: [https://docs.zammad.org/en/latest/admin/console/hidden-settings.html](https://docs.zammad.org/en/latest/admin/console/hidden-settings.html) 
* <strong>Email Configuration:</strong>
    * Configure the email settings to enable Zammad to send and receive emails. This includes specifying the SMTP server details and authentication credentials.
    * Set up email channels for handling incoming emails.
    * The prerequisite for this configuration is available mailbox 
* <strong>User Authentication and Authorization:</strong>
    * Configure authentication sources such as EOSC AAI. To start with authentication prepare Privacy Policy and Acceptable Usage Policy 
    * Create ticket to request registration of the Helpdesk instance in AAI Proxy and further  integration steps. 
    * Set up user roles and permissions to control access for newly logged users 
* <strong>Monitoring and Backups:</strong>
    * Implement monitoring to track the performance and health of your Zammad instance.
    * Set up regular backups to prevent data loss.


## Troubleshooting

* The important check of proper configuration and function of the EOSC Helpdesk is the health check available at: [https://eosc-helpdesk.eosc-portal.eu/#system/monitoring](https://eosc-helpdesk.eosc-portal.eu/#system/monitoring)
* Other source of troubleshooting is Zammad community portal: https://community.zammad.org/

## References

The main information about configuration is provided by the Zammad documentation: https://docs.zammad.org/en/latest/index.html




