# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

#Required environment variables:

##EOSC User Dashboard : 

```
###global settings 
DATABASE_URI=postgresql+psycopg2://user:pass@db:5432/user-dashboard
SOLR_URL=http://host:8983/solr/
OIDC_CLIENT_ID=client_id
OIDC_CLIENT_SECRET=client_secret
OIDC_HOST=https://aai.eosc-portal.eu
SECRET_KEY=secret
BACKEND_BASE_URL="https://my.eosc-portal.eu"
UI_BASE_URL=https://my.eosc-portal.eu
DEBUG_LEVEL=INFO
RECOMMENDER_ENDPOINT=http://host:port/recommendations
STOMP_HOST=marketplace.eosc-portal.eu
STOMP_PORT=61613
STOMP_LOGIN=login
STOMP_PASS=pass
STOMP_USER_ACTIONS_TOPIC=/topic/user_actions
STOMP_CLIENT_NAME=client_name
ESS_STOMP_SSL=1
SHOW_FIXED_RECOMMENDATIONS=1
OIDC_AAI_NEW_API="true"
```
