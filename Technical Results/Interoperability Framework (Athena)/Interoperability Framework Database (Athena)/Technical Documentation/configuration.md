# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

### Important note

*Interoperability Registry is inherently connected with the Service Cataloge Infrastructure, sharing common resources, installation and deployment. Hence, same policies, instructions and procedures apply for both components.* 


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
  [deployment](./deployment.md#add-resourcetypes-(only-the-first-time-you-eploy-the-project))
- **Vocabularies**

  A Vocabulary, one of the resources used by the EOSC Service Resource Catalogue Project, consists of predefined String 
  values used on various fields of a specific resource.

  For example, Provider's 'lifeCycleStatus' field, indicating the current status of the Provider's life-cycle, can take
  as a value only a handful of predefined 

