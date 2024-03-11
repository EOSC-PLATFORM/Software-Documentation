# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

Steps:

##1. Install dependencies required by applications:

An example dependency configuration was prepared together with the applications and saved in the docker-compose configuration. We recommend running dependencies, mainly databases, on separate servers using configurations adapted to your servers.

### Database
 * PostgreSQL


##2. Verify configuration with external components:
 * EOSC Portal common
 * AAI - authentication and authorization
 * JMS - data bus
 * Recommender System

##3. Build, configuration and deploy
 * Create docker images , see Building section 
 * Set environment variables, see Configuration section
 * Deploy docker images 
   ``` docker-compose up -d ```

##4. Check application status, logs . 
