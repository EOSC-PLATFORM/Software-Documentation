# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

An Angular application has several configuration files that help define and manage various aspects of the application. These files are important for project setup, development, and deployment.

- *package.json*: Specifies the dependencies required for the Angular application and contains scripts that define various tasks, such as commands for starting a development server and building the application.The port used when running the application in client side rendering mode is defined here.
- *angular.json*: The angular.json file is the primary configuration file for the application. It defines build and project configuration, including build options, assets, and development server settings. 
- *tsconfig.json*: The tsconfig.json file is the TypeScript configuration file for the Angular application.
- *environment.ts, environment.beta.ts, environment.prod.ts*: These TypeScript files are used to define environment-specific variables and configuration settings. environment.ts is for development, while environment.prod.ts is for production.
- *.gitignore*: The .gitignore file specifies files and directories that should be ignored by version control systems like Git. It helps prevent unnecessary or sensitive files from being committed to the repository.
- *.gitmodules*: This file includes a reference to other libraries which are used as submodues. The source code of this application consists of the local source code files and assets, as well as of three submodules (libraries).
- *server.ts*: This is a file used for server-side rendering (SSR) to render the Angular components and templates on the server. The port used when running the application in server side rendering mode is defined here.

The colors and styling of the user interface are customized in the eosc-custom.less file.

