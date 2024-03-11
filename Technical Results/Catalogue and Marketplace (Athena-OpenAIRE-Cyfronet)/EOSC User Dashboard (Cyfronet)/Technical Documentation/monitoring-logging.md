# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Monitoring and Logging

Monitoring servers are a basic element of IT infrastructure management, for this purpose we use the Zabbix https://www.zabbix.com/ system in our infrastructure. Zabbix is a comprehensive monitoring system that enables organizations to track server performance metrics, network activity, and other critical data in real time. It offers features such as customizable alerts, dashboards, and historical data analysis to ensure optimal server health and prevent potential problems before they disrupt performance.

Additionally, collecting application logs plays a key role in understanding software performance and detecting errors. In our infrastructure, we use the Graylog https://graylog.org/ system for this purpose, which effectively centralizes logs from various sources, making it easier to identify and solve problems. Its advanced search and visualization capabilities help developers gain insight into log data and proactively troubleshoot issues. For example, to implement the system, we can directly use docker mechanisms and indicate the server collecting logs in the container configuration in the docker-compose.yml file. For example: 

services:

 ...
	
	logging:
  	
	  driver: syslog
  	
	  options:
    
		syslog-address: "udp://graylog.hostname:port_nr"
    	
		syslog-format: "rfc3164"
    	
		tag: "app_name"

To complete the IT monitoring and management ecosystem, it is crucial to set up alerting mechanisms. We decided to use Sentry https://sentry.io/ . Sentry specializes in error tracking and alerting, enabling development and operations teams to quickly respond to issues in their applications. It not only detects errors, but also provides detailed context and information about the issue, enabling teams to quickly resolve the issue and minimize user impact. We configure the Sentry server through an environment variable called: SENTRY_DSN 

The combination of these tools - server monitoring with Zabbix, log aggregation with Graylog and error notification with Sentry - creates a robust and proactive approach to ensuring the reliability, performance and security of User Dashboard operations.