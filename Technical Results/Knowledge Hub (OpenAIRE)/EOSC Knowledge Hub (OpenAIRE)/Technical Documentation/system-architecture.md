# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## System Architecture

- Description of the software/application architecture.
- Components, modules, and their interactions.

### OpenPlato

The following are required for the software to function correctly:

-   An installed Linux system (Ubuntu/Debian) on which the entire solution runs and Moodle files are stored.
-   Installed PHP, which is responsible for running Moodle.
-   Installed web server (Apache) used to display Moodle content.
-   Installed MySQL server, where data is stored.

The solution consists of two servers:

-   moodle.openaire.eu: The server exposing Moodle to the world.
-   moodle-db: The database server.

![Architecture](./Architecture.png)<img src="./Architecture">

The moodle.openaire.eu server communicates with the database and is gateway for moodle-db.

The required components are described in the [installation.md] section.
