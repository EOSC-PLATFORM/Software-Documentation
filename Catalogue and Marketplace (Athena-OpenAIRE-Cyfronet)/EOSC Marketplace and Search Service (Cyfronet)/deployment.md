# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

Steps:

##1. Install dependencies required by applications:

An example dependency configuration was prepared together with the applications and saved in the docker-compose configuration. We recommend running dependencies, mainly databases, on separate servers using configurations adapted to your servers.

### Marketplace:
 * PostgreSQL
 * ElasticSearch
 * Redis

### Search Service
 * Solr
 * PostgreSQL


##2. Verify configuration with external components:
 * EOSC Portal common
 * AAI - authentication and authorization
 * JIRA/Sombo - onboarding
 * Argo -  monitoring 
 * Provider Component/OpenAIRE - data source 
 * JMS - data bus
 * Recommender System

##3. Build, configuration and deploy
 * Create docker images , see Building section 
 * Set environment variables, see Configuration section
 * Deploy docker images 
   ``` docker-compose up -d ```

##4. Check application status, logs . 
 

###Deploy components diagram

![](https://technopolisltd223.sharepoint.com/:i:/r/sites/INFRAEOSC-03Proposal/Shared%20Documents/Software%20documentation/Catalogue%20and%20Marketplace%20(Athena-OpenAIRE-Cyfronet)/EOSC%20Marketplace%20and%20Search%20Service%20(Cyfronet)/img/Diag1.png?csf=1&web=1&e=MifSTx)