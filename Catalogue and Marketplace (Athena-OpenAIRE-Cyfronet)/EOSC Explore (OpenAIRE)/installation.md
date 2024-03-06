# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Installation

The application can be deployed in a machine with installed Node.js and NPM (Node Package Manager) by simply running the commands of the Building and Deployment sections. 
Current versions of the production deployment are version 16.18.0 for Node.js and version 7.19.1 for NPM. 

The production deployment is managed with PM2 (Process Manager 2), version 5.1.0, which is a popular and widely used process manager for Node.js applications.
PM2 supports zero-downtime application reloads by gracefully switching to the new version without interrupting user requests and runs the application in the background. The start, stop, restart and managing processes of the application are simplified by the following commands:

- "pm2 list": view all the currently running applications managed with PM2 and their statuses.
- "pm2 log <app_name>": view the logs of the application <app_name>.
- "pm2 start/ stop/ restart <app_name>": start/ stop/ restart the application <app_name>.

More details about the production deployment can be found here.
The source code of the project can be found in this repository.

