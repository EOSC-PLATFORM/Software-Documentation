# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Backup and Recovery

This application is stateless and does not store any information in local storage. Therefore, there is no need for backing up data in this application.

All configuration is stored as environment variables or, in the case of a local deployment, in an .env file. If you use the .env file, you should backup this file to restore the configuration when recovering from a failure.

The disaster recovery procedure consists of restarting the docker container.
