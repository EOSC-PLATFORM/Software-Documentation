# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

- Purpose of the document and intended audience.
- Importance of proper configuration for the software/application.

Configuration process of OpenPlato for administrators.

## Configuration Overview

- Brief overview of the configuration process.
- Explanation of how configuration affects the behaviour of the software.

Install module SAML2

Set:

- IdP metadata xml OR public xml URL: [https://aai.eosc-portal.eu/auth/realms/core/protocol/saml/descriptor](https://aai.eosc-portal.eu/auth/realms/core/protocol/saml/descriptor)
- IdP label override: Login via EOSC AAI
- Allowed any auth type: Yes
- Mapping IdP: mail
- Mapping Moodle: email address
- Auto create users: no

After configuration it should generate the SP Metadata and send the SP Metadata to EOSC Admin

Data mapping:

- Username: voPersonID
- First name: givenName
- Last name: sn
- Email address: mail


## Configuration Files

- List of configuration files used by the software.
- Description of each file's purpose and contents.

## Configuration Parameters

- Detailed explanation of individual configuration parameters.
- Default values and allowed ranges or formats.
- Impact of changing specific parameters on the software.

## Environmental Variables

- Description of environment variables used for configuration.
- Explanation of how these variables influence the software.

## Configuration Sources

- Explanation of where configuration values are sourced from (e.g., files, environment).
- Order of precedence if configuration values conflict.

## Configuration Management

- Best practices for managing configuration files and values.
- Recommendations for versioning and documenting changes.

## Security Considerations

- Guidelines for handling sensitive information in configuration.
- Encryption, masking, or protection of critical configuration values.

## Examples

- Practical examples of common configuration scenarios.
- Step-by-step instructions for configuring the software.

## Troubleshooting

- The important check of proper configuration and function of the EOSC Helpdesk is the health check available at: https://eosc-helpdesk.eosc-portal.eu/#system/monitoring
- Other source of troubleshooting is Moodle community portal: https://docs.moodle.org/403/en/Main_page


## References

- More info at https://docs.moodle.org/403/en/Main_page
