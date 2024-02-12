# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

#Required environment variables:

##Marketplace: 

```
##Global settings
ROOT_URL=https://marketplace.eosc-portal.eu
SEARCH_SERVICE_BASE_URL=https://search.marketplace.eosc-portal.eu
USER_DASHBOARD_URL=https://my.eosc-portal.eu
EOSC_EXPLORE_BASE_URL=https://search.marketplace.eosc-portal.eu/
MP_HOST=https://marketplace.eosc-portal.eu
RACK_ENV=production
RAILS_ENV=production
DATABASE_URL=postgres://mp@hostname
MP_DATABASE_USERNAME=mp
MP_DATABASE_PASSWORD=passwd
ELASTICSEARCH_URL=hostname
RAILS_SERVE_STATIC_FILES=1
STORAGE_DIR=/marketplace/media
REDIS_URL=redis://149.156.9.50:6379/0/session
RATE_AFTER_PERIOD=30
EXTERNAL_LANDING_PAGE=true
MP_ENABLE_EXTERNAL_SEARCH=1
MP_IMPORT_EOSC_REGISTRY_URL=https://api.eosc-portal.eu
PROVIDERS_DASHBOARD_URL=https://providers.eosc-portal.eu
EOSC_COMMONS_ENV=production
EOSC_COMMONS_BASE_URL=https://s3.cloud.cyfronet.pl/eosc-portal-common/
RECOMMENDATION_ENGINE=NCF
USER_ACTIONS_TARGET=all
OFFERS_API_DISABLED=true
ESS_UPDATE_ENABLED=true
PROFILE_4_ENABLED=true
EOSC_EXPLORE_TAGS="EOSC::RO-crate,EOSC::Jupyter Notebook,EOSC::Galaxy Workflow,EOSC::Twitter Data,EOSC::Data Cube"

###AAI
CHECKIN_HOST=aai.eosc-portal.eu
CHECKIN_IDENTIFIER=identifier
CHECKIN_SECRET=secret
OIDC_AAI_NEW_API=true
CHECKIN_SCOPE=openid,profile,email,aarc,offline_access
IMPORTER_AAI_REFRESH_TOKEN=token
IMPORTER_AAI_BASE_URL=aai.eosc-portal.eu
IMPORTER_AAI_CLIENT_ID=client_id

###Jira (onboarding)
MP_JIRA_PASSWORD=password
MP_JIRA_PROJECT=EOSCSO
MP_JIRA_URL=https://jira.eosc-hub.eu
MP_JIRA_USERNAME=marketplace
MP_JIRA_WEBHOOK_SECRET=secret
MP_JIRA_CONTEXT_PATH=''
MP_JIRA_FIELD_CI_Department=customfield_10244
MP_JIRA_FIELD_CI_DepartmentalWebPage=customfield_10245
MP_JIRA_FIELD_CI_DisplayName=customfield_10228
MP_JIRA_FIELD_CI_EOSC_UniqueID=customfield_10229
MP_JIRA_FIELD_CI_Email=customfield_10227
MP_JIRA_FIELD_CI_Institution=customfield_10243
MP_JIRA_FIELD_CI_Name=customfield_10225
MP_JIRA_FIELD_CI_SupervisorName=customfield_10248
MP_JIRA_FIELD_CI_SupervisorProfile=customfield_10249
MP_JIRA_FIELD_CI_Surname=customfield_10226
MP_JIRA_FIELD_CP_CustomerTypology=customfield_10250
MP_JIRA_FIELD_CP_ReasonForAccess=customfield_10251
MP_JIRA_FIELD_Order_reference=customfield_10254
MP_JIRA_FIELD_SELECT_VALUES_CP_CustomerTypology_private_company=10189
MP_JIRA_FIELD_SELECT_VALUES_CP_CustomerTypology_research=10188
MP_JIRA_FIELD_SELECT_VALUES_CP_CustomerTypology_single_user=10187
#MP_JIRA_FIELD_SO_1=customfield_10400
MP_JIRA_FIELD_SO_1=customfield_10711
MP_JIRA_FIELD_CP_ScientificDiscipline=customfield_10706
MP_JIRA_FIELD_SO_ProjectName=customfield_10705
MP_JIRA_FIELD_CP_UserGroupName=customfield_10252
MP_JIRA_FIELD_CP_ProjectInformation=customfield_10253
MP_JIRA_FIELD_CP_INeedAVoucher=customfield_10716
MP_JIRA_FIELD_SELECT_VALUES_CP_INeedAVoucher_true=10705
MP_JIRA_FIELD_SELECT_VALUES_CP_INeedAVoucher_false=10706
MP_JIRA_FIELD_CP_VoucherID=customfield_10710
MP_JIRA_FIELD_CP_Platforms=customfield_10708
MP_JIRA_ISSUE_TYPE_ID=10204
MP_JIRA_WF_DONE=10311
MP_JIRA_WF_IN_PROGRESS=3
MP_JIRA_WF_REJECTED=10103
MP_JIRA_WF_TODO=10309
MP_JIRA_WF_WAITING_FOR_RESPONSE=10310

###External tools
MP_XGUS_USERNAME=eoscmarket
MP_XGUS_PASSWORD=password
MP_XGUS_WSDL=https://prod-ars.ggus.eu/arsys/WSDL/public/prod-ars/XGUS_EOSCHub
GOOGLE_ANALYTICS=
HOTJAR_TRACKINGCODE=
RECAPTCHA_SITE_KEY=
RECAPTCHA_SECRET_KEY=
JIRA_COLLECTOR_SCRIPTS=
SENTRY_DSN=
SIMILAR_SERVICES_HOST=
MONITORING_DATA_URL=https://api.argo.grnet.gr/api
MONITORING_DATA_TOKEN=token
RECOMMENDER_HOST=

###JMS
MP_STOMP_CLIENT_NAME=
MP_STOMP_DESTINATION=eosc-portal
MP_STOMP_HOST=
MP_STOMP_SSL=true
MP_STOMP_PASS=
MP_STOMP_LOGIN=
MP_STOMP_PUBLISHER_ENABLED=true
MP_STOMP_PUBLISHER_TOPIC=mp.eosc-portal
MP_STOMP_PUBLISHER_DATABUS_TOPIC=user_actions

###SMPT
FROM_EMAIL=marketplace@eosc-portal.eu
SMPT_ADDRESS=hostname
SMPT_USERNAME=user
SMPT_PASSWORD=pass
```

##Search Service

```
###global settings 
DATABASE_URI=postgresql+psycopg2://user:pass@db:5432/ess
SOLR_URL=http://host:8983/solr/
OIDC_CLIENT_ID=client_id
OIDC_CLIENT_SECRET=client_secret
OIDC_HOST=https://aai.eosc-portal.eu
SECRET_KEY=secret
BACKEND_BASE_URL="https://search.marketplace.eosc-portal.eu"
UI_BASE_URL=https://search.marketplace.eosc-portal.eu
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
MARKETPLACE_BASE_URL: https://marketplace.eosc-portal.eu
RELATED_SERVICES_ENDPOINT=https://providers.eosc-portal.eu/api/public/interoperabilityRecord/relatedResources
NG_COLLECTIONS_PREFIX=""
```