# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >


# Installation

- Detailed instructions for installing the software/application.
- Prerequisites, dependencies, and installation scripts.


## Frontend


### Prerequisites
- [Nginx](https://www.nginx.com/) (or another Web Server like [Apache HTTP Server](https://httpd.apache.org/))
 
### Dependencies
- [Stats Tool]()
- [Autocompletion Suggestion Generation for EOSCF](https://github.com/athenarc/EOSCF-Autocompletion)
- [Provider RS Insights for EOSCF](https://github.com/athenarc/EOSCF-Provider-Insights)


### Installation


#### Nginx Configuration
You have to create a [Server Block configuration](https://www.nginx.com/resources/wiki/start/topics/examples/server_blocks/) that will point to the directory "dist/**resource-catalogue-ui**" created by [building manually](./building.md#manual-build) the webapp.
It must also be configured as a reverse proxy for the Backend Application (to serve it under the path '/api') and for the list of [Dependencies](#dependencies) of the project.

See the example below:
```nginx
server {
    server_name                 ...
    access_log                  ...
    root                        /path/to/resource-catalogue-ui;  # the directory of the frontend application

    location / {
        try_files $uri$args $uri$args/ /index.html /index.php;
    }

    location ~* \.(eot|ttf|woff)$ {
        add_header Access-Control-Allow-Origin *;
    }

    # reverse proxy configuration for the backend application
    location /api {
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_pass              http://backend-app:8080/eic-registry;
        proxy_read_timeout      3600;
        proxy_send_timeout      3600;
    }

    # reverse proxy configuration for the backend application
    location /stats-api {
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_pass              http://stats-tool-api;
        proxy_read_timeout      90;
        proxy_send_timeout      90;
    }

    # reverse proxy configuration for the 'Autocompletion Suggestion Generation for EOSCF'
    location ^~ /v1/auto_completion {
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_pass              http://auto_completion-api;
        proxy_read_timeout      200;
    }

    # reverse proxy configuration for the 'Provider RS Insights for EOSCF'
    location ^~ /provider_insights_api/v1 {
        proxy_set_header        Accept-Encoding "";
        proxy_set_header        x-access-token "29yv1E2gD2j83W2x";
        proxy_pass              https://provider-insights-api;
        proxy_read_timeout      200;
    }
}
```

Lastly, we would advice to validate the configuration of the Nginx to make sure it does not contain errors.
<br>Execute `nginx -t` with elevated permissions to perform a validation. If the test is successful you can move on to [deploying](./deployment.md#frontend) the application.  


---

## Backend


### Prerequisites
* [Apache Tomcat 8.5](https://tomcat.apache.org/download-80.cgi)
* [ActiveMQ 5.x.x](https://activemq.apache.org/)
* [Elasticsearch 7.x.x](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/elasticsearch-intro.html)
* [PostgreSQL 9.5+](https://www.postgresql.org/)


### Infrastructure Installation and Configuration
Install all software found in the list of [Prerequisites](#Prerequisites) using the official documentation.


#### PostgreSQL - Configuration
Before using PostgreSQL to run the __backend application__ you must create a User and a Database.

In the following script, replace [user], [password] and [db] with the desired values. 
```sql
CREATE USER [user] WITH PASSWORD '[password]'; -- or use an existing user

CREATE DATABASE [db] WITH OWNER [user];

\c [db]; -- connect to db

CREATE EXTENSION tablefunc;
```

### Installation
To install the __backend application__ in Apache Tomcat:

1. Move the "./target/**eic-registry.war**" file -created by [building manually](./building.md#manual-build-instructions) the app- inside the Tomcat directory, under the folder "tomcat-base-dir/**webapps**/".
2. Create a file named "registry.properties" under "tomcat-base-dir/**lib**" and fill in the following properties.
```properties
##########################
## Mandatory Properties ##
##########################
fqdn=localhost
registry.host=http://${fqdn}:8080/eic-registry/

## DB Properties ##
jdbc.url=jdbc:postgresql://${fqdn}:5432/db
jdbc.username=<user>
jdbc.password=<your-password>

## Elasticsearch Properties ##
elasticsearch.url=${fqdn}
elasticsearch.port=9300
elasticsearch.cluster=<clusterName>

## JMS Properties ##
jms.host=tcp://${fqdn}:61616
jms.prefix=<local>

## Login Properties ##
webapp.homepage=http://localhost:3000
webapp.oidc.login.redirectUris=http://localhost:8080/eic-registry/openid_connect_login

## Openid Connect Properties ##
oidc.issuer=
oidc.authorization=
oidc.token=
oidc.userinfo=
oidc.revocation=
oidc.jwk=
oidc.clientId=
oidc.clientSecret=
oidc.scopes=openid, profile, email

#########################
## Optional Properties ##
#########################

## Project Properties ##
project.admins=test@email.com, test2@email.com
project.admins.epot=
project.debug=false
project.name=My Catalogue
project.registration.email=no-reply@my-catalogue.org
project.helpdesk.email=
project.monitoring.email=
project.catalogue.name=

## sync ##
sync.host=
sync.enable=false
sync.token.filepath=

## Mail Properties ##
mail.smtp.auth=
mail.smtp.host=
mail.smtp.user=
mail.smtp.password=
mail.smtp.port=
mail.smtp.protocol=
mail.smtp.ssl.enable=
mail.smtp.from=

## Enable/Disable Emails ##
emails.send=false
emails.send.admin.notifications=false
emails.send.provider.notifications=false

## Matomo Properties ##
matomoHost=
matomoToken=
matomoSiteId=
matomoAuthorizationHeader=
apitracking.matomo.site=
apitracking.matomo.host=

## Auditing interval (in months) ##
auditing.interval=

## Openaire Datasources Manager ##
openaire.dsm.api=
openaire.ds.metrics=
openaire.ds.metrics.validated=

## Argo GRNET Monitoring Status ##
argo.grnet.monitoring.service.types=
argo.grnet.monitoring.availability=
argo.grnet.monitoring.status=
argo.grnet.monitoring.token=

## Resource Consistency ##
resource.consistency.enable=false
resource.consistency.email=
resource.consistency.cc=

## PIDS ##
pid.username=
pid.key=
pid.auth=
pid.prefix=
pid.api=
```
