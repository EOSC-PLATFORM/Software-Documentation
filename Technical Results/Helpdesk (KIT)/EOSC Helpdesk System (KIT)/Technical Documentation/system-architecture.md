# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## System Architecture

he Helpdesk main portal provides the UI for both users and helpdesk agents, search functionality, reporting and statistics dashboards. It also provides self-service functions like a knowledge base and a search engine for common and resolved known issues and problems. The main helpdesk components relevant for consideration in top level helpdesk system architecture are: 

* Submission modules 
* Helpdesk dashboard 
* Helpdesk backoffice 
* Knowledge based
* Community portals 

The picture below illustrates the top level helpdesk component architecture.  

![alt text](https://technopolisltd223.sharepoint.com/:i:/r/sites/INFRAEOSC-03Proposal/Shared%20Documents/Software%20documentation/Helpdesk%20(KIT)/EOSC%20Helpdesk%20System%20(KIT)/helpdesk_component_architecture.png?csf=1&web=1&e=grkxbN)

The picture below illustrates the top level helpdesk architecture.  The architecture illustrates the modular design of the helpdesk system with components with different functionalities, it also points to integrations with external helpdesks, which are not part of the EOSC Helpdesk, but connected to it based on different scenarios, which are defined by integration options: 



* Submission Modules represent various channels through which users can submit tickets, such as email channel, helpdesk main portal, webform placed on different web portals, helpdesk chat ( currently not activated), messengers . 
* Helpdesk Back-Office is a major component responsible for ticket management, workflow automation, and serving as a communication hub for handling submitted tickets by the agents. 
* Community Helpdesks are external standalone helpdesks integrated with EOSC Helpdesk via REST API. 
* Community Helpdesk Portals which are parts of the EOSC Helpdesk are components shown in blue which implement multiple branded and customized portals for different EOSC communities, enabling the delivery of the helpdesk as a service.
* The "Knowledge Base Component" is tightly integrated with the Helpdesk system, providing self-service capabilities for both customers and agents. It includes features such as knowledge management, a self-service interface, and content search and retrieval.
