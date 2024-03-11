# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

- Purpose of the document and intended audience.
- Importance of proper configuration for the software/application.

## Configuration Overview

- Brief overview of the configuration process.
- Explanation of how configuration affects the behaviour of the software.

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

- Common configuration issues and potential solutions.
- How to diagnose misconfigurations.

## References

- Links to external resources, documentation, articles related to configuration.


---

--- 

---


## Introduction

### Purpose of the document and intended audience.
This document contains information on how to set up correctly the application. TODO

### Importance of proper configuration for the software/application.

## Configuration Overview
TODO
### Brief overview of the configuration process.
This section contains important information about the configuration process needed for the smooth operation of the 
application. Various key-features, are described below:
- **Resource Types:**

  A Resource Type is a specific entity needed by the dependency library "registry" used by the EOSC Service Resource 
  Catalogue Project.

  There is a unique Resource Type describing each one of the Project's *public* resources, like the Provider and the 
  Service.

  It holds important information about those resources, like schema urls and index fields used by the Elasticsearch.
  
  This information is saved as a JSON file and is necessary for the smooth functionality of both the Database and the 
  Elasticsearch.

  For more information about how to upload the resource types, please refer to 
  [deployment](deployment.md#add-resourcetypes-(only-the-first-time-you-eploy-the-project))
- **Vocabularies**

  A Vocabulary, one of the resources used by the EOSC Service Resource Catalogue Project, consists of predefined String 
  values used on various fields of a specific resource.

  For example, Provider's 'lifeCycleStatus' field, indicating the current status of the Provider's life-cycle, can take
  as a value only a handful of predefined 

### Explanation of how configuration affects the behaviour of the software.

## Configuration Files

### List of configuration files used by the software.
### Description of each file's purpose and contents.

## Configuration Parameters

### Detailed explanation of individual configuration parameters.
### Default values and allowed ranges or formats.
### Impact of changing specific parameters on the software.

## Environmental Variables

### Description of environment variables used for configuration.
### Explanation of how these variables influence the software.

## Configuration Sources

### Explanation of where configuration values are sourced from (e.g., files, environment).
### Order of precedence if configuration values conflict.

## Configuration Management

### Best practices for managing configuration files and values.
### Recommendations for versioning and documenting changes.

## Security Considerations

### Guidelines for handling sensitive information in configuration.
### Encryption, masking, or protection of critical configuration values.

## Examples

### Practical examples of common configuration scenarios.
### Step-by-step instructions for configuring the software.

## Troubleshooting

### Common configuration issues and potential solutions.
### How to diagnose misconfigurations.

## References

### Links to external resources, documentation, articles related to configuration.