# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Connectors

Configuration of all connectors is centered around two configuration
files: `global.conf` and `customer.conf`. Those file contains some
shared config options and sections that are taken into account by every
connector.

| Configuration file | Description                                                                                                                                                                                                                      |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| global.conf        | Config file consists of global options common to all connectors like the FQDN of ARGO-WEB-API service, the path of host certificate to authenticate to a server and some connection settings like timeout and number of retries. |
| customer.conf      | This configuration file is specific for each customer and it consists of listed jobs and their attributes                                                                                                                        |

All configuration files reside in `/etc/argo-connectors/` after the
installation of the package. That's the default location that each
connector will try to read configuration from. Location can be
overridden since every connectors takes `-c` and `-g` arguments to
explicitly define the paths to `customer.conf` and `global.conf`,
respectively. Example:

    topology-gocdb-connector.py -c /path/to/customer-foo.conf -g /path/to/global-foo.conf

### global.conf

Config file is read by *every* component because every component needs
to, at least, path of host certificate to authenticate to know the FQDN
of ARGO-WEB-API service and have connection parameter properly
configured. Config options are case insensitive and whole config file is
splitted into a few sections:

    [General]
    WriteJson = True
    PublishWebAPI = True
    PassExtensions = True
    CompressJson = True

These are common options for all connectors:

- `PublishWebApi` - toggle that tells each connectors to reformat and
  deliver fetched data to ARGO-WEB-API service
- `WriteJson` - reformat fetched data and place it as set of redudant
  JSON files for each tenant (mainly for backup purposes)
- `PassExtensions` - parse extra definitions in GOCDB topology
- `CompressJson` - gzip written JSON files

<!-- -->

    [Authentication]
    VerifyServerCert = True
    CAFile = /etc/pki/tls/certs/ca-bundle.crt
    CAPath = /etc/grid-security/certificates
    HostKey = /etc/grid-security/hostkey.pem
    HostCert = /etc/grid-security/hostcert.pem
    UsePlainHttpAuth = False
    HttpUser = xxxx
    HttpPass = xxxx

Options are related to client X509 authentication wherever server
requires it as well as verifying server certificate if turned on via
`CAFile` and `CAPath` certification authorities.

    [WebAPI]
    Host = api.argo.grnet.gr

FQDN on ARGO-WEB-API service that fetched data will be reformatted and
pushed to.

    [Connection]
    Timeout = 360
    Retry = 60
    SleepRetry = 60
    RetryRandom = False
    SleepRandomRetryMax = 60

Every connector will timeout connection after `360` seconds specified in
`Timeout` if peer doesn't respond properly in a given time frame.
Connection will try to be established `60` more times (specified in
`Retry`) sleeping for `SleepRetry` before each next try. If all tries
are exhausted, connector considers peer unavailable. If `RetryRandom` is
turned on, connector will sleep some random number of seconds in
interval `[1, SleepRandomRetryMax]` before each next try.

    [InputState]
    SaveDir = /var/lib/argo-connectors/states/
    Days = 3

State files refers to simple `True/False` plaintext file that each
connector will write in `SaveDir` and refers to whether connectors
succesfully fetched the data from the server or not. Files are named as
datestamp and are kept for last number of days specified in `Days`.

    [Output]
    Downtimes = downtimes_DATE.json
    MetricProfile = poem_sync_DATE.json
    TopologyGroupOfEndpoints = group_endpoints_DATE.json
    TopologyGroupOfGroups = group_groups_DATE.json
    Weights = weights_DATE.json

These are the option that state what will be the names of the
backup/redundancy files that corresponding connector will write on the
filesystem.

### customer.conf

`customer.conf` refers to the configuration of particular
tenant/e-infrastructure that connectors will query for for the latest
additions of services and endpoints that need to be monitored. It's
formatted of two types of sections: `[CUSTOMER_<NAME>]` and
`[<JOB_NAME>]`:

    [CUSTOMER_<NAME>]
    ...
    Jobs = <JOB_NAME>

    [<JOB_NAME>]
    ...

So for the tenant with the `<NAME>` one job/report of name `<JOB_NAME>`
will be created.

Following is the example of EOSC tenant configuration:

    [CUSTOMER_EOSC]
    Name = EOSC
    OutputDir = /var/lib/argo-connectors/EOSC/
    WebAPIToken = <WEB-API-TOKEN>
    Jobs = Default
    DowntimesEmpty = True
    WeightsEmpty = True
    OIDCRefreshToken = <TOKEN>
    OIDCClientId = <CLIENT>
    OIDCTokenEndpoint = https://aai.eosc-portal.eu/auth/realms/core/protocol/openid-connect/token
    TopoFeed = https://api.eosc-portal.eu/
    TopoFeedServiceGroups = https://api.eosc-portal.eu/provider/bundle/all?catalogue_id=eoscc
    TopoFeedServiceEndpoints = https://api.eosc-portal.eu/service/adminPage/all
    TopoFeedServiceEndpointsExtensions = https://api.eosc-portal.eu/service-extensions/monitoring/all?catalogue_id=eosc
    TopoType = EOSCPROVIDER
    TopoFetchType = ServiceGroups
    TopoUIDServiceEndpoints = True
    TopoFeedPaging = True

    [Default]
    Dirname = Default
    Profiles = EOSC

`TopoFeed*` are API methods of EOSC Providers portal from where the
providers and services/resources will be fetched. Those will be
transformed to service endpoints and service groups entities of ARGO
monitoring framework. `TopoFeedPaging` means that API methods are
paginated so complete data will be fetched in multiple requests untill
all pages are visited.

EOSC Providers portal methods requires authentication of the client via
`OIDCClientId`, `OIDCRefreshToken` and `OIDCTokenEndpoint` from which
access token will created.

`WEBAPIToken` is provided by the ARGO team.

`DowntimesEmpty` and `WeightsEmpty` are set to `True` meaning that
weights and downtimes are not provided for particular
tenant/e-infrastructure.

For the job configuration of name `Default`, `Profiles` option refers to
the POEM metric profile that report will be based on.

### cron job

Connectors are scheduled via cron jobs so cron definition needs to be
placed at `/etc/cron.d/eosc`:

    # eosc connectors
    7 0 * * * root /usr/libexec/argo-connectors/topology-provider-connector.py -c /etc/argo-connectors/eosc-customer.conf; \
    /usr/libexec/argo-connectors/weights-vapor-connector.py -c /etc/argo-connectors/eosc-customer.conf; \
    /usr/libexec/argo-connectors/metricprofile-webapi-connector.py -c /etc/argo-connectors/eosc-customer.conf
    58 21 * * * root /usr/libexec/argo-connectors/downtimes-gocdb-connector.py -c /etc/argo-connectors/eosc-customer.conf -d $(date --date "+1 days" "+\%Y-\%m-\%d")

## Monitoring box

### Introduction

There are four components that need to be configured so that the monitoring box can be properly set up to fetch the information from the sources of truth (ARGO Web-API and POEM), and send the results through ARGO Messaging:

* Sensu backend and agent,
* argo-scg,
* AMS Publisher, and
* argo-poem-tools.

### Configuration Overview

Each of the components has its configuration file(s). Should any of them be misconfigured, the monitoring box will not work properly.

### Configuration Files

Configuration files of each of the four necessary components are:

* Sensu
   * `/etc/sensu/backend.yml` - configuration of Sensu backend, or
   * `/etc/sensu/agent.yml` - configuration of Sensu agent
* argo-scg
  * `/etc/argo-scg/scg.conf` - configuring sources of truth (per-tenant)
* AMS Publisher
  * `/etc/ams-publisher/ams-publisher-sensu.conf` - configuring ARGO AMS service (per-tenant)
* argo-poem-tools
  * `/etc/argo-poem-tools/argo-poem-tools.conf` - information on tenant's POEM needed for the installation of necessary probes

### Configuration Parameters

In Sensu official documentation all the configuration options are described in detail for [Sensu backend](https://docs.sensu.io/sensu-go/latest/observability-pipeline/observe-schedule/backend/#backend-configuration-options) and [Sensu agent](https://docs.sensu.io/sensu-go/latest/observability-pipeline/observe-schedule/agent/#agent-configuration-options).

In ARGO Monitoring service, we use secure Sensu agent-to-server communication, for which configuration is described in the [official documentation](https://docs.sensu.io/sensu-go/latest/operations/deploy-sensu/secure-sensu/#secure-sensu-agent-to-server-communication).

Sensu API token (which is used by argo-scg) needs to be created manually on Sensu backend server, as is described [here](https://docs.sensu.io/sensu-go/latest/operations/control-access/use-apikeys/#sensuctl-management-commands).

As far as the ARGO proprietary tools go, their configurations are described in detail in their respective documentation pages:

* argo-scg - [configuration file description](https://github.com/ARGOeu/argo-scg/tree/devel#configuration)
* AMS Publisher - [configuration file description](https://github.com/ARGOeu/ams-publisher#configuration)
* argo-poem-tools - [configuration file description](https://github.com/ARGOeu/argo-poem-tools#argo-poem-tools)

The parameters need to be set up properly, otherwise the tools will not be able to fetch or send data.


### Configuration Management

All the configuration management is done with the help of the [ARGO Puppet module](https://github.com/ARGOeu/argo-puppet/tree/master).

### Security Considerations

Most of the information stored in the configuration files is sensitive (tokens, passwords). Those files should then have properly set permissions, to avoid that unauthorised users can access them.

It should also take care of it that such information is not stored in any public repositories.

### Examples

Example of Sensu backend configuration file as used in ARGO monitoring service:

```yaml
state-dir: "/var/lib/sensu/sensu-backend"
api-url: https://sensu.example.com:8080
cert-file: "/etc/sensu/ssl/cert.pem"
key-file: "/etc/sensu/ssl/key.pem"
trusted-ca-file: "/etc/sensu/ssl/ca.crt"
log-level: info
```

`state-dir` is the path to Sensu state storage. `api-url` is the URL for the Sensu API. The `cert-file` and `key-file` are host certificate and key file respectively, and `trusted-ca-file` is the location of CA file, which are necessary for secure connection of Sensu agent with backend. `log-level` simply sets what will be logged.

Example of Sensu agent configuration file as used in ARGO monitoring service:

```yaml
backend-url:
- wss://sensu.example.com:8081
name: tenant.sensu.example.com
agent-managed-entity: false
namespace: TENANT
trusted-ca-file: "/etc/sensu/ssl/ca.crt"
log-level: info
```

Sensu agent configuration needs to have configured Sensu backend URL. `name` is agent's hostname, we mark that we do not want agent to manage entities. As in backend, you need to define `trusted-ca-file` (on backend) and `log-level`. In ARGO monitoring service, we keep separate tenants in separate namespaces, so it needs to be defined in configuration file as well.

Configuration files' examples for the other three tools are provided in the same documents provided in the [Configuration Parameters](#configuration-parameters) section.

### References

- [AMS Publisher configuration](https://github.com/ARGOeu/ams-publisher#configuration)
- [ARGO Puppet module README](https://github.com/ARGOeu/argo-puppet#argo-puppet-module)
- [argo-poem-tools README](https://github.com/ARGOeu/argo-poem-tools#argo-poem-tools)
- [argo-scg configuration](https://github.com/ARGOeu/argo-scg#configuration)
- [Sensu backend configuration](https://docs.sensu.io/sensu-go/latest/observability-pipeline/observe-schedule/backend/#backend-configuration-options)
- [Sensu agent configuration](https://docs.sensu.io/sensu-go/latest/observability-pipeline/observe-schedule/agent/#agent-configuration-options)

## POEM

Configuration is centered around one file `VENV/etc/poem/poem.conf` that is split into several sections: `[DEFAULT]`, `[GENERAL]`, `[DATABASE]` and `[SECURITY]`, which are common to all tenants, and tenant-specific sections which have tenant name in the title: `[GENERAL_<tenant_name>]`, `[SUPERUSER_<tenant_name>]`, and `[SYNC_<tenant_name>]` (`<tenant_name>` marks the name of the tenant - those section should exist for every tenant).

### poem.conf

#### DEFAULT

	[DEFAULT]
	VENV = /home/pyvenv/poem/

* `VENV` defines the location of virtual environment directory. Value will be interpolated into the other options.

#### GENERAL

	[GENERAL]
	Debug = False
	TimeZone = Europe/Zagreb

* `Debug` serves for the debugging purposes and tells Django to be verbosive and list the stack calls in case of errors
* `Timezone` timezone

#### DATABASE

	[DATABASE]
	Name = postgres
	User = postgres
	Password = postgres
	Host = localhost
	Port = 5432

* `Name` is the name of database to use for tables
* `User`, `Password` are credentials that will be used to authenticate to PostgreSQL server
* `Host` is hostname of the PostgreSQL server
* `Port` where PostgreSQL server is listening for connections

#### SECURITY

	[SECURITY]
	AllowedHosts = FQDN1, FQDN2
	CAFile = /etc/pki/tls/certs/DigiCertCA.crt
	CAPath = /etc/grid-security/certificates/
	HostCert = /etc/grid-security/hostcert.pem
	HostKey = /etc/grid-security/hostkey.pem
	SecretKeyPath = %(VENV)s/etc/poem/secret_key

* `AllowedHosts` should have FQDN name of hosts that will be running POEM service. It can be provided as comma separated list of valid FQDNs and it is used as prevention of HTTP Host Header attacks. FQDNs listed here will be matched against request's Host header exactly.
* `CAFile`, `CAPath` are used by sync scripts to authenticate the server certificate
* `HostCert`, `HostKey` are public and private part of client certificate
* `SecretKeyPath` is the location of file containing Django SECRET_KEY that is used for cryptographic signing
	* `poem-genseckey` provided tool can generate unique and unpredictable value and write it into the file
```sh
% workon poem
% poem-genseckey -f $VIRTUAL_ENV/etc/poem/secret_key
```

Part of the REST API is protected by token so for tenants that consume those API methods, token needs to be generated and distributed. Tokens can be generated by the superuser from the Admin UI page or with the provided `poem-token` tool. Example is creation a token for the client/tenant EOSC:
```sh
% workon poem
% poem-token -t EOSC -s eosc
```

#### WEBAPI

    [WEBAPI]
    MetricProfile = https://api.argo.grnet.gr/api/v2/metric_profiles
    AggregationProfile = https://api.argo.grnet.gr/api/v2/aggregation_profiles
    ThresholdsProfile = https://api.argo.grnet.gr/api/v2/thresholds_profiles
    OperationsProfile = https://api.argo.grnet.gr/api/v2/operations_profiles
    Reports = https://api.argo.grnet.gr/api/v2/reports
    ReportsTopologyTags = https://api.argo.grnet.gr/api/v2/topology/tags
    ReportsTopologyGroups = https://api.argo.grnet.gr/api/v2/topology/groups
    ReportsTopologyEndpoints = https://api.argo.grnet.gr/api/v2/topology/endpoints
    ServiceTypes = https://api.argo.grnet.gr/api/v2/topology/service-types
    Metrics = https://api.argo.grnet.gr/api/v4/admin/metrics


This section lists WEB-API methods for the resources that are not stored in
POEM's PostgreSQL DB, but instead are consumed from ARGO WEB-API services. POEM
actively polls the PI methods and is doing the full round of CRUD operations on
them.

#### GENERAL_<tenant_name>

    [GENERAL_EOSC]
    Namespace = hr.cro-ngi.TEST
    SamlLoginString = Log in using EOSC AAI
    SamlServiceName = ARGO POEM EOSC-AAI
    TermsOfUse = https://ui.argo.grnet.gr/eosc/termsofUse
    PrivacyPolicies = https://argo.eosc-portal.eu/eosc/policies


* `Namespace` defines the identifier that will be prepended to every Profile
* `SamlLoginString` defines the text presented on the SAML2 button of login page
* `SamlServiceName` defines service name in SAML2 configuration
* `TermsOfUse` represents tenant URL reference to Terms of Use on ARGO UI service
* `PrivacyPolicies` represents tenant URL reference to Privacy policies on ARGO UI service

#### SUPERUSER_<tenant_name>

Initial superuser credentials that can be used to sign in to POEM with username and password.

    [SUPERUSER_EOSC]
    Name = test
    Password = test
    Email = test@foo.baar

> It is **important** to note that these options should be specified with correct values **before** trying to create a superuser in database for the given tenant.

### Creating database and starting the service

Prerequisites for creating the empty database are:
1) PostgreSQL DB server running on `Host`, listening on `Port` and accepting `User` and `Password`
2) `[SUPERUSER_<tenant_name>]` section is set with desired credentials
3) `SECRET_KEY` is generated and placed in `$VIRTUAL_ENV/etc/poem/secret_key`
4) `$VIRTUAL_ENV` has permissions set to `apache:apache`
5) `poem.conf` Apache configuration is presented in `/opt/rh/httpd24/root/etc/httpd/conf.d/`

Once all is set, database can be created with provided tool `poem-db`.

```sh
% workon poem
% poem-db -c
[standard:public] === Running migrate for schema public
[standard:public] Operations to perform:
[standard:public]   Apply all migrations: admin, auth, contenttypes, poem, rest_framework_api_key, reversion, sessions, tenants
[standard:public] Running migrations:
....
```

### Tenant handling

#### SuperPOEM

TODO: Tenant handling will be done within SuperPOEM that will spawn TenantPOEM and will have a register all of them with needed tenant metadata. Until then, TenantPOEM is created with a set of Django backend tools that set and create needed tenant metadata.

Prerequisite for spawning of new TenantPOEM is to have SuperPOEM operational with its data (metric templates, probes, packages and repo) loaded in `public` database schema. SuperPOEM is residing on its own FQDN, supporting only username/password login that should be defined in `poem.conf`:
```
[SECURITY]
AllowedHosts = poem.argo.grnet.gr

[GENERAL_ALL]
PublicPage = poem.argo.grnet.gr
TermsOfUse = https://argo.eosc-portal.eu/eosc/termsofUse
PrivacyPolicies = https://argo.eosc-portal.eu/eosc/policies

[SUPERUSER_ALL]
Name = <username>
Password = <password>
Email = <email>
```

`public` schema is automatically created once the database is created. It just needs to be populated with SuperPOEM data:
```
poem-db -d -n public -f public.json
```

#### TenantPOEM

Tenant metadata is:
* tenant FQDN
* superuser TenantPOEM credentials
* topology sources for GOCDB-like feed
* WEB-API read-only and CRUD tokens

##### Metadata configuration

Tenant metadata should be listed in `poem.conf` with corresponding sections:
```
[SECURITY]
AllowedHosts = poem.argo.grnet.gr, eosc.poem.argo.grnet.gr

[GENERAL_EOSC]
SamlLoginString = Login using EOSC AAI
SamlServiceName = ARGO POEM EOSC AAI

[SUPERUSER_EOSC]
Name = <username>
Password = <password>
Email = <email>
```

##### DB schema creation

For DB schema handling, `poem-tenant` tool is introduced. It takes two mandatory arguments, tenant name and FQDN. Tool will create DB schema for the given tenant and the Django migrations will be run effectively recreating all needed database tables needed for storing tenant data.Superuser is created by tool `poem-db`:
```sh
% poem-tenant -t EOSC -d eosc.poem.argo.grnet.gr
[standard:eosc] === Running migrate for schema eosc
[standard:eosc] Operations to perform:
[standard:eosc]   Apply all migrations: admin, auth, contenttypes, poem, rest_framework_api_key, reversion, sessions, tenants
[standard:eosc] Running migrations:
...
% poem-db -u -n eosc
Superuser created successfully.
```

> DB schema name internally is always lower-cased name given to `poem-tenant` tool and in such form is provided to `poem-db` tool.

Afterward, Apache server needs to be started:
```sh
% systemctl start httpd24-httpd.service
```

Tenant POEM web application should be now served at `https://<tenant_domain_url>/`

##### Tokens

For seamless interaction with ARGO WEB-API, tokens with predefined names and values should be set. Therefore, `poem-token` tool is introduced. Naming of tokens should follow exactly this schema:
* `WEB-API-RO` - read-only ARGO-WEB-API token
* `WEB-API` - CRUD ARGO-WEB-API token
* `TENANT-NAME` - REST API consumed by monitoring boxes

Example:
```
poem-token -t WEB-API-RO -s eosc -o xxxx
poem-token -t WEB-API -s eosc -o xxxx
```

`poem-token` tools takes two or three arguments. In three-arguments-mode, it's setting token name provided after `-t` within schema provided after `-s` to a predefined value provided after `-o`. If `-o` is omitted, than value will be automatically created.

In two-argument-mode it is used to generate a token for its REST API that will be consumed by monitoring boxes:
```
poem-token -t EOSC -s eosc
```

## Web API Configuration

Web API is configured in `/etc/argo-web-api.conf` ini file (automatically created during installation)

You can see a default configuration file here: <https://github.com/ARGOeu/argo-web-api/blob/master/default.conf>


The following properties are supported:

### Section `[server]`
|property|type|description|
|-|-|-|
|bindip|string|ip address where the Web API should listen|
|port|number|port number where the Web API should listen|
|maxprocs|number|max threads that the Web API should create|
|lrucache|number|size of the lrucache to be used|
|gzip|boolean|gzip compression in responses|
|cert|string|path to the certificate used|
|privkey|string|path to the private key used
|reqsizeLimit|number|max size of the allowed request in bytes|
|enablecors|boolean|enable/disable cors|

### Section `[mongodb]`
|property|type|description|
|-|-|-|
|host|string|remote db host to connect to|
|port|number|remote db port to connect to|
|db|string|remote database name to connect to|

<<<<<<< HEAD
=======

## Compute / Streaming engine configuration

The parameters of configuration file are explained below in detail:

### Section `[HDFS]`
This section configures all the required parameters so that the engine can target the remote hdfs endpoints

|Parameter|Type|Description|
|-|-|-|
|`namenode`|uri|endpoint host of namenode|
|`path_metric`|template_uri|template for constructing the hdfs path to tenants metric data location <br/> ```default value: hdfs://{{namenode}}/user/{{hdfs_user}}/argo/tenants/{{tenant}}/mdata```|
|`path_sync` (deprecated)|template_uri|template for constructing the hdfs path to tenants sync data location <br/> ```default value: hdfs://{{namenode}}/user/{{hdfs_user}}/argo/tenants/{{tenant}}/sync```|
|`path_tenants`|template_uri|template for constructing the hdfs root path to where all tenants reside <br/> ```default value: hdfs://{{namenode}}/user/{{hdfs_user}}/argo/tenants```|
|`user`|string|name of the hdfs user to be used|
|`rollback_days` (deprecated)|integer|how many days to roll back a sync file if it is missing <br/> ```default value: 3```|
|`writer_bin` (deprecated)|path to hdfs binary used for uploading files in hdfs|

### Section `[STREAMING]`
This section configures all the required parameters so that the engine can target the remote kafka cluster

|Parameter|Type|Description|
|-|-|-|
|`kafka_servers` (optional)|list|comma-separated list of endpoints <br/> ```default value: localhost:9092```|

### Section `[MONGO]`
This section configures all the required parameters so that the engine can target the remote mongo database

|Parameter|Type|Description|
|-|-|-|
|`endpoint` (optional)|uri| mongodb endpoint|

### Section `[AMS]`
This section configures all the required parameters so that the engine can connect to the Messaging Service

|Parameter|Type|Description|
|-|-|-|
|`endpoint`|uri| argo messaging endpoint|
|`access_token`|string| argo messaging access token|
|`proxy` (optional)|uri| proxy to be used to connect to Messaging Service <br/> ```default value: http://localhost:3128```|
|`verify` (optional)|boolean| ssl verify Messaging endpoint| 

### Section `[API]`
This section configures all the required parameters so that the engine can communicate with the remote Web API endpoint

|parameter|type|description|
|-|-|-|
|`endpoint`|uri|argo-web-api endpoint|
|`access_token`|string|token for argo-web-api access|
|`tenants`|list|list of tenants|
|`proxy` (optional)|uri|ams proxy to be used <br/> ```default value: http://localhost:3128```|
|`verify` (optional)|bool|ssl verify ams endpoint <br/> ```default value: true```|
|`~_key`|string|tenants key|

### Section `[FLINK]`
This section configures all the required parameters so that the engine can locate the flink executable to submit jobs and the remote job manager url to retrieve information about the cluster

|parameter|type|description|
|-|-|-|
|`path`|path|path to flink executable|
|`job_manager`|uri|url of flink's job manager|

### Section `[JOB-NAMESPACE]`
This section configures all the required parameters so that the engine can identify jobs that are already running in the flink cluster.

|parameter|type|description|
|-|-|-|
|`ingest-metric-namespace`|template|template for naming ingest metric jobs in flink <br/> ```default value: Ingesting  metric data from {{ams_endpoint}}:{{ams_port}}/v1/projects/{{project}}/subscriptions/{{ams_sub}}```|
|`ingest-sync-namespace`|template|template for naming ingest sync jobs in flink <br/> ```default value: Ingesting sync data from {{ams_endpoint}}:{{ams_port}}/v1/projects/{{project}}/subscriptions/{{ams_sub}}```|
|`stream-status-namespace`|template|template for naming stream status jobs in flink <br/> ```default value: Streaming status using data {{ams_endpoint}}:{{ams_port}}/v1/projects/{{project}}/subscriptions/[{{ams_sub_metric}}, {{ams_sub_sync}}]```|

### Section `[CLASSES]`
This section configures all the required parameters so that the engine can identify which Java class should use as entry point in every job.

|parameter|type|description|
|-|-|-|
|`ams-ingest-metric`|string|class name for entry point in ingest metric flink job jar <br/> ```default value: argo.streaming.AmsIngestMetric```|
|`ams-ingest-sync`|string|class name for entry point in ingest sync flink job jar <br/> ```default value: argo.streaming.AmsIngestSync```|
|`batch-ar`|string|class name for entry point in batch ar flink job jar <br/> ```default value: argo.batch.ArgoArBatch```|
|`batch-status`|string|class name for entry point in batch status flink job jar <br/> ```default value: argo.batch.ArgoArBatch```|
|`stream-status`|string|class name for entry point in stream status flink job jar <br/> ```default value: argo.batch.ArgoStatusBatch```|
|`batch-multi`|path|class name for entry point in batch multi flink job jar|

### Section `[JARS]`
This section configures per job type where the corresponding JAR file is located.

|parameter|type|description|
|-|-|-|
|`ams-ingest-metric`|path|jar path for ingest metric flink job jar|
|`ams-ingest-sync`|path|jar path for ingest sync flink job jar|
|`batch-ar`|path|jar path for batch ar flink job jar|
|`batch-status`|path|jar path for batch status flink job jar|
|`stream-status`|path|jar path for stream status flink job jar|
|`batch-multi`|path|jar path for batch multi flink job jar|

### Section `[TENANTS:<TENANT-NAME>]`
This is the general configuration of a tenant. Where <TENANT-NAME> replace with the name of the tenant.

|parameter|type|description|
|-|-|-|
|`reports`|list|available reports for tenant (comma separated list)|
|`report_<report-name>`|string|The value hold the report uuid. In the key replace <report-name> with the name of the actual report|
|`ams_project`|string|ams project used for this tenant|
|`ams_token`|string|ams token used for this tenant|
|`mongo_uri`|template,uri|mongo uri including host port and database <br/> ```default value: {{mongo_endpoint}}/argo_{{tenant}}```|
|`mongo_method`|string|default method used in mongodb operations <br/> ```default value: insert```|

### Section `[TENANTS:<TENANT-NAME>:ingest-metric]`
This configuration is per tenant and holds specific parameters used by the ingestion job. Where <TENANT-NAME> replace with the name of the tenant.

|parameter|type|description|
|-|-|-|
|`ams_sub`|string|subscription for ingesting metric data|
|`ams_interval`|long|interval for polling ams for metric data <br/> ```default value: 300```|
|`ams_batch`|long|number of messages to retrieve at once from ams <br/> ```default value: 100```|
|`checkpoint_path`|template,uri|hdfs checkpoint path <br/> ```default value: hdfs://{{namenode}}/user/{{hdfs_user}}/argo/tenants/{{tenant}}/checkp```|
|`checkpoint_interval`|long|interval between hdfs checkpoints <br/> ```default value: 30000```|

### Section `[TENANTS:~:ingest-sync]` (deprecated)
This configuration is per tenant and holds specific parameters used by the ingest sync job (deprecated). Where <TENANT-NAME> replace with the name of the tenant.

|parameter|type|description|
|-|-|-|
|`ams_sub`|string|subscription for ingesting sync data|
|`ams_interval`|long|interval for polling ams for sync data <br/> ```default value: 3000```|
|`ams_batch`|long|number of messages to retrieve at once from ams <br/> ```default value: 10```|

### Section `[TENANTS:~:stream-status]`
This configuration is per tenant and holds specific parameters used by the streaming job. Where <TENANT-NAME> replace with the name of the tenant.

|parameter|type|description|
|-|-|-|
|`ams_sub_metric`|string|subscription for ingesting metric data <br/> ```default value: status_metric```|
|`ams_sub_sync`|string|subscription for ingesting sync data <br/> ```default value: status_sync```|
|`ams_interval`|long|interval for polling ams for sync data <br/> ```default value: 300```|
|`ams_batch`|long|number of messages to retrieve at once from ams <br/> ```default value: 100```|
|`hbase_master` (deprecated)|uri|hbase master node uri hbase://localhost:9090|
|`hbase_zk_quorum` (deprecated)|list|comma-separated list of kafka servers|
|`hbase_zk_port` (deprecated)|long|hbase zookeeper port|
|`hbase_table` (deprecated)|string|hbase table used|
|`hbase_namespace` (deprecated)|string|hbase namespace used |
|`kafka_servers` (optional)|list|comma-separated list of kafka servers to send messages to|
|`kafka_topic` (optional)|string|kafka topic to directly write to|
|`mongo_method` (optional)|string|method on how to insert data in mongo (insert|upsert)|
|`flink_parallelism` (optional)|int|number of parallelism to be used in flink|
|`outputs` (optional)|list|list of output destinations|
>>>>>>> f9ad3ff (Compute/Streaming engine)
