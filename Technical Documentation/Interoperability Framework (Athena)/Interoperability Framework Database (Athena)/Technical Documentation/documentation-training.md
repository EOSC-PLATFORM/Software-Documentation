# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

### Important note

*Interoperability Registry is inherently connected with the Service Cataloge Infrastructure, sharing common resources, installation and deployment. Hence, same policies, instructions and procedures apply for both components.* 

## Documentation and Training

Documentation for API usage is automatically generated at the build step of the software using the OpenAPI documentation procedures for Spring boot projects.

Operantional usage of the EOSC Service Catalogue and Providers Portal from a Provider's standpoint can be found here: <https://eosc-portal.eu/eosc-providers-hub>.

Collection of EPOT procedures regarding operations are here: <https://wiki.eoscfuture.eu/display/EOSCOB/EPOT+Procedures>.

## Resource Catalogue Documentation

- [Vocabularies](https://github.com/madgeek-arc/resource-catalogue-docs/tree/master/vocabularies)
- [Migration Scripts](https://github.com/madgeek-arc/resource-catalogue-docs/tree/master/scripts)

## Swagger UI Instances:

- [Production](https://providers.eosc-portal.eu/openapi)
- [Sandbox](https://beta.providers.eosc-portal.eu/openapi)
- [Beta](https://sandbox.providers.eosc-portal.eu/openapi)

## API:

- https://providers.eosc-portal.eu/api, https://api.eosc-portal.eu/
- https://sandbox.providers.eosc-portal.eu/api/
- https://beta.providers.eosc-portal.eu/api/

## Controllers:

### Obtain and Use API Token
  
You can obtain an API token for the secured methods [here](https://aai.eosc-portal.eu/providers-api/). The obtained token can be used in a bearer authorization header like this: 'Authorization: Bearer [token]'

        
### Interoperability Record:
#### Get information about Interoperability Records
  - GET
    - Get a list of all Interoperability Records in the Portal:
      ```diff
      /interoperabilityRecord/all
      Params:
        query: String (Keyword to refine the search)
        from : int (Starting index in the result set)
        quantity: int (Quantity to be fetched)
        order: String (asc/desc)
        orderField: String (eg. id)
      ```
    - Returns the Interoperability Record given its ID:
      ```diff
      /interoperabilityRecord/{id}
      Params:
        id: String (required)
      ```

### Public
  
- ### Resource Interoperability Record
  #### CRUD operations for Services
  - DELETE
    - Deletes the Resource Interoperability Record of the specific Resource:
      ```diff
      /resourceInteroperabilityRecord/{resourceId}/{resourceInteroperabilityRecordId}
      Params:
        resourceId: String (required)
        resourceInteroperabilityRecordId: String (required)
      ```
  - GET
    - Returns a list of all Resource Interoperability Records of the specific Catalogue in the Portal:
      ```diff
      /resourceInteroperabilityRecord/all
      Params:
        catalogue_id: String (required)
        query: String (Keyword to refine the search)
        from : int (Starting index in the result set)
        quantity: int (Quantity to be fetched)
        order: String (asc/desc)
        orderField: String (eg. id)
      ```
    - Returns the Resource Interoperability Record of the specific Catalogue given the Resource ID:
      ```diff
        /resourceInteroperabilityRecord/byResource/{resourceId}
        Params:
          resourceId: String (required)
          catalogue_id: String
      ```
    - Returns the Resource Interoperability Record of the specific Catalogue given its ID:
      ```diff
        /resourceInteroperabilityRecord/{id}
        Params:
          id: String (required)
      ```
  - POST
    - Creates a new Resource Interoperability Record given its resourceType (eg. service, datasource):
      ```diff
        /resourceInteroperabilityRecord
        Body:
          ResourceInteroperabilityRecord: JSON (required)
        Params:
          resourceType: String (required)
      ```
  - PUT
    - Updates a specific Resource Interoperability Record:
      ```diff
      /resourceInteroperabilityRecord
      Body:
        ResourceInteroperabilityRecord: JSON (required)
      ```
  

## Objects:
    
  ### Interoperability Record:
    {
      "id": "(auto-assigned)",
      "identifierInfo": {
        "identifier": "string",
        "identifierType": "string"
      },
      "creators": [
        {
          "creatorNameTypeInfo": {
            "creatorName": "string",
            "nameType": "string"
          },
          "givenName": "string",
          "familyName": "string",
          "nameIdentifier": "string",
          "creatorAffiliationInfo": {
            "affiliation": "string",
            "affiliationIdentifier": "string"
          }
        }
      ],
      "title": "string",
      "publicationYear": "string",
      "resourceTypesInfo": [
        {
          "resourceType": "string",
          "resourceTypeGeneral": "string"
        }
      ],
      "created": "string",
      "updated": "string",
      "eoscRelatedStandards": [
        "URL"
      ],
      "rights": [
        {
          "rightTitle": "string",
          "rightURI": "URL",
          "rightIdentifier": "string"
        }
      ],
      "description": "string",
      "status": "string",
      "domain": "string",
      "eoscGuidelineType": "string",
      "eoscIntegrationOptions": [
        "string"
      ]
    }


  ### Resource Extras:
    {
      "eoscIFGuidelines": [
        {
          "label": "string",
          "pid": "string",
          "semanticRelationship": "string",
          "url": "URL"
        }
      ],
      "horizontalService": false,
      "researchCategories": [
        "string"
      ]
    }
    
  ### Resource Interoperability Record:
    {
      "id": "(required on PUT only)",
      "resourceId": "string",
      "catalogueId": "string",
      "interoperabilityRecordIds": [
        "string"
      ]
    }

  
  ### Vocabulary:
    {
      "description": "string",
      "extras": {},
      "id": "string",
      "name": "string",
      "parentId": "string",
      "type": "string"
    }

## Vocabulary Types:
  - [ACCESS_MODE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/ACCESS_MODE.json)
  - [ACCESS_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/ACCESS_TYPE.json)
  - [CATALOGUE_STATE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/CATALOGUE_STATE.json)
  - [CATEGORY](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/CATEGORY.json)
  - [COUNTRY](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/COUNTRY.json)
  - [DS_CLASSIFICATION](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/DS_CLASSIFICATION.json)
  - [DS_COAR_ACCESS_RIGHTS_1_0](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/DS_COAR_ACCESS_RIGHTS_1_0.json)
  - [DS_JURISDICTION](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/DS_JURISDICTION.json)
  - [DS_PERSISTENT_IDENTITY_SCHEME](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/DS_PERSISTENT_IDENTITY_SCHEME.json)
  - [DS_RESEARCH_ENTITY_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/DS_RESEARCH_ENTITY_TYPE.json)
  - [FUNDING_BODY](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/FUNDING_BODY.json)
  - [FUNDING_PROGRAM](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/FUNDING_PROGRAM.json)
  - [GEOGRAPHIC_LOCATION](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/GEOGRAPHIC_LOCATION.json)
  - [IR_EOSC_GUIDELINE_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/IR_EOSC_GUIDELINE_TYPE.json)
  - [IR_IDENTIFIER_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/IR_IDENTIFIER_TYPE.json)
  - [IR_NAME_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/IR_NAME_TYPE.json)
  - [IR_RESOURCE_TYPE_GENERAL](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/IR_RESOURCE_TYPE_GENERAL.json)
  - [IR_STATUS](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/IR_STATUS.json)
  - [LANGUAGE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/LANGUAGE.json)
  - [LIFE_CYCLE_STATUS](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/LIFE_CYCLE_STATUS.json)
  - [MONITORING_MONITORED_BY](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/MONITORING_MONITORED_BY.json)
  - [ORDER_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/ORDER_TYPE.json)
  - [PROVIDER_AREA_OF_ACTIVITY](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_AREA_OF_ACTIVITY.json)
  - [PROVIDER_ESFRI_DOMAIN](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_ESFRI_DOMAIN.json)
  - [PROVIDER_ESFRI_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_ESFRI_TYPE.json)
  - [PROVIDER_HOSTING_LEGAL_ENTITY](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_HOSTING_LEGAL_ENTITY.json)
  - [PROVIDER_LEGAL_STATUS](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_LEGAL_STATUS.json)
  - [PROVIDER_LIFE_CYCLE_STATUS](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_LIFE_CYCLE_STATUS.json)
  - [PROVIDER_MERIL_SCIENTIFIC_DOMAIN](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_MERIL_SCIENTIFIC_DOMAIN.json)
  - [PROVIDER_MERIL_SCIENTIFIC_SUBDOMAIN](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_MERIL_SCIENTIFIC_SUBDOMAIN.json)
  - [PROVIDER_NETWORK](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_NETWORK.json)
  - [PROVIDER_SOCIETAL_GRAND_CHALLENGE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_SOCIETAL_GRAND_CHALLENGE.json)
  - [PROVIDER_STATE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_STATE.json)
  - [PROVIDER_STRUCTURE_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/PROVIDER_STRUCTURE_TYPE.json)
  - [REGION](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/REGION.json)
  - [RELATED_PLATFORM](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/RELATED_PLATFORM.json)
  - [RESEARCH_CATEGORY](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/RESEARCH_CATEGORY.json)
  - [RESOURCE_STATE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/RESOURCE_STATE.json)
  - [SCIENTIFIC_DOMAIN](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/SCIENTIFIC_DOMAIN.json)
  - [SCIENTIFIC_SUBDOMAIN](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/SCIENTIFIC_SUBDOMAIN.json)
  - [SEMANTIC_RELATIONSHIP](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/SEMANTIC_RELATIONSHIP.json)
  - [SUBCATEGORY](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/SUBCATEGORY.json)
  - [SUPERCATEGORY](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/SUPERCATEGORY.json)
  - [TARGET_USER](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/TARGET_USER.json)
  - [TEMPLATE_STATE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/TEMPLATE_STATE.json)
  - [TRL](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/TRL.json)
  - [TR_ACCESS_RIGHT](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/TR_ACCESS_RIGHT.json)
  - [TR_CONTENT_RESOURCE_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/TR_CONTENT_RESOURCE_TYPE.json)
  - [TR_DCMI_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/TR_DCMI_TYPE.json)
  - [TR_EXPERTISE_LEVEL](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/TR_EXPERTISE_LEVEL.json)
  - [TR_QUALIFICATION](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/TR_QUALIFICATION.json)
  - [TR_URL_TYPE](https://github.com/madgeek-arc/resource-catalogue-docs/blob/master/vocabularies/TR_URL_TYPE.json)
