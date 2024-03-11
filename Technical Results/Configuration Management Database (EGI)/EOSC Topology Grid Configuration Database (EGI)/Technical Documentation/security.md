# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Security

Access to GOCDB is restricted to user with either:
- An X.509 certificate
- A EOSC AAI Account

Supporting new authentication mechanisms is documented here: https://github.com/GOCDB/gocdb/tree/dev/lib/Authentication

Access to personal information is restricted be enabling `restrict_personal_data` in `config/local_info.xml`. Once this is enabled, access is granted via the API credential mechanism as described here: https://gocdb.github.io/api/#api-credential-mechanism

Organisational and community best practices should be followed to secure the underlying infrastructure.
