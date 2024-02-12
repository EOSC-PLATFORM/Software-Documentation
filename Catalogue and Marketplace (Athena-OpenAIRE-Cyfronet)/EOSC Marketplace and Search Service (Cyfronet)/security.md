# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Security

- Security measures in place and best practices.

Storing data on servers should be accompanied by a high level of security. Access to this data should be restricted to authorized personnel, and developers should not have access to production data. Additionally, physical access to the server rooms should be impossible for external individuals, and a multi-step authentication process should be in place to ensure data integrity and confidentiality.


- How to manage access, authentication, and data protection.

Access to the application should be limited only to ports that provide data via https, remember to ensure that everything is covered by SSL encryption. Access to other components, including the database, should be limited to internal networks and only authorized persons should have access to them. Additionally, authorization mechanisms should be activated.