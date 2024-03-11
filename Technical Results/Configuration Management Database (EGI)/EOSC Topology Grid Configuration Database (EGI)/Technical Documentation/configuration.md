# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

This document is intended to provide an overview of the configuration of an instance of the GOCDB software.

## Configuration Overview

Documentation to install and deploy GOCDB can be found here: https://github.com/GOCDB/gocdb/blob/dev/INSTALL.md

## Configuration Management

Organisational and community best practices should be followed to manage the configuration of GOCDB and the underlying infrastructure.

## Security Considerations

Access to personal information is restricted be enabling restrict_personal_data in config/local_info.xml. Once this is enabled, access is granted via the API credential mechanism as described here: https://gocdb.github.io/api/#api-credential-mechanism

Organisational and community best practices should be followed to secure the underlying infrastructure.

## Troubleshooting

Typical User issues are documented here: https://docs.egi.eu/internal/configuration-database/faq/

The GOCDB status page is helpful in diagnosing operational problems, it can be found under /portal/GOCDB_monitor/
