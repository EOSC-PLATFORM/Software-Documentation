# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Backup and Recovery

Configuration of all service components is fully managed through ansible to allow redeploying service components on new hosts. The configuration history is maintained on a private GitHub repository, utilising ansible-vault for sensitive data. The database backend used by the EOSC Core Infrastructure Proxy is operated in clustered mode geographically distributed across data centres, supporting streaming replication and Point-in-Time Recovery for a period of six months (minimum). Backups are stored in a separate system and can be restored at once, losing up to 24 hours of data.
