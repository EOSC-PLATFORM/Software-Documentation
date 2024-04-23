# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Installation

### Connectors

Installation simply narrows down to installing the provided RPM package
from ARGO repository. Supported RPM linux distribution is CentOS 7.
`argo-connectors` requires several other Python modules that are also
provided as RPM package within aformentioned repository and that will be
pulled during the installation:

- `python-aiohttp` - asyncio library for spawning multiple concurrent
  HTTP fetch coroutines on event loop
- `python36-lxml` - fast and efficient library with pleasent API for
  parsing XML feeds
- `python36-bonsai` - asyncio library for LDAP requests

Steps:

1. configure ARGO RPM repository; in `/etc/yum.repos.d` place
    `argo.repo` with this content
```
[argo-prod]
name=ARGO Production Repository
baseurl=http://rpm-repo.argo.grnet.gr/ARGO/prod/centos7/
gpgcheck=0
enabled=1
```
2.  install the package
```
# yum install -y makecache && yum install -y argo-connectors
```

`argo-connectors` RPM package will layout connectors, modules and
configuration files across the following locations on the filesystem:

| File type              | Destination                  |
|------------------------|------------------------------|
| Configuration files    | /etc/argo-connectors         |
| Supported connectors   | /usr/libexec/argo-connectors |
| Logs                   | /var/log/argo-connectors     |
| Redundant fetched data | /var/lib/argo-connectors     |

### Monitoring box

For the monitoring box to run, you will need to have Sensu backend and agent installed. Since the open-source version of Sensu is not available as a package, it will need to be built from source (as described in building documentation).

There are three additional tools that need to be installed for monitoring box to be able to be used in ARGO monitoring service:

* argo-scg,
* AMS publisher,
* argo-poem-tools.

Each of the listed packages is developed by the ARGO monitoring team, and is available in [ARGO rpm repository](http://rpm-repo.argo.grnet.gr/ARGO/prod/centos7/). They are simply installed from .rpm packages.

### POEM

POEM web service is meant to be running with Django 3.x driven by Python 3.x on CentOS 7 and served by installation of Apache from Software Collections. Setting up Python virtual environment based on Python 3.x is prerequisite. Once the virtual environment is set up, installation of the service simply narrows down to creating and installing wheel package that will also pull and install all needed dependencies. Beside wheel dependencies, service also needs some packages to be installed from CentOS 7 repositories:

```sh
% yum -y install ca-certificates \
		git which \
		xmlsec1 xmlsec1-openssl
```

Layout of POEM web service files on the filesystem depends on the location of virtual environment. By the default, service assumes it is:

```sh
VENV = /home/pyvenv/poem/
```

| File Types                      | Destination                                                                   |
| ------------------------------- | ----------------------------------------------------------------------------- |
| Configuration - General         | `VENV/etc/poem/poem.conf`                                                     |
| Configuration - Logging         | `VENV/etc/poem/poem_logging.conf`                                             |
| Configuration - Apache          | `/opt/rh/httpd24/root/etc/httpd/conf.d/`                                      |
| Cron jobs                       | `/etc/cron.d/poem-clearsessions, poem-sync, poem-db_backup`                   |
| Logrotate                       | `/etc/logrotate.d/poem-db_backup`                                             |
| Database handler                | `VENV/bin/poem-db`                                                            |
| Sync (Service types)            | `VENV/bin/poem-syncservtype`                                                  |
| Security key generator          | `VENV/bin/poem-genseckey`                                                     |
| Token set/create                | `VENV/bin/poem-token`                                                         |
| Tenant management               | `VENV/bin/poem-tenant`                                                        |
| Import services from json file  | `VENV/bin/poem-importservices`                                                |
| Django `manage.py` wrapper      | `VENV/bin/poem-manage`                                                        |
| Static data served by Apache    | `VENV/usr/share/poem/`                                                        |
| Main application code           | `VENV/lib/python3.6/site-packages/Poem/`                                      |
| Log file                        | `VENV/var/log/poem`                                                           |
| DB backups                      | `VENV/var/db_backups/`                                                        |


If the default location of virtual environment is inappropriate and needs to be changed, change of it should be reflected by adapting `VENV` configuration variable in `etc/poem/poem.conf`, `etc/poem/poem_logging.conf`, `/etc/httpd/conf.d/poem.conf` and `site-packages/Poem/settings.py`.

#### Setting up virtual environment based on Python 3.6

CentOS 7 operating system delivers [Python 3.6 through Software Collections service](https://www.softwarecollections.org/en/scls/rhscl/rh-python36/) that is installed with the following instructions:

```sh
% yum -y install centos-release-scl
% yum -y install scl-utils
% yum -y install rh-python36 rh-python36-python-pip
```

Prebuilt `mod-wsgi` that is linked against Python 3.6 and [Apache from Software Collections service](https://wwws.oftwarecollections.org/en/scls/rhscl/httpd24/) can be installed:

```sh
% yum -y install rh-python36-mod_wsgi httpd24-httpd httpd24-mod_ssl
```

Once the Python 3.6 is installed, it needs to be used to create a new virtual environment named _poem_:

```sh
% scl enable rh-python36 'pip install -U pip'
% scl enable rh-python36 'pip3 install virtualenv virtualenvwrapper'
% scl enable rh-python36 'export VIRTUALENVWRAPPER_PYTHON=/opt/rh/rh-python36/root/bin/python3.6; source /opt/rh/rh-python36/root/usr/bin/virtualenvwrapper.sh; export WORKON_HOME=/home/pyvenv; mkdir -p $WORKON_HOME; mkvirtualenv poem'
```

> **Notice** how the location of virtual environment is controlled with `WORKON_HOME` variable. Created virtual environment directory will be `$WORKON_HOME/poem`. It needs to be aligned with `VENV` variable in service configuration.

Afterward, the context of virtual environment can be started:

```sh
% workon poem
```

As virtual environment is tied to Python 3.6 versions, it's *advisable* to put `helpers/venv_poem.sh` into `/etc/profile.d` as it will configure login shell automatically.

#### Installing the POEM service

Creation and installation of wheel package is done in the context of virtual environment which needs to be loaded prior.

```sh
% workon poem
% (poem) python setup.py sdist bdist_wheel
% (poem) pip3 install dist/*
% (poem) pip3 install -r requirements_ext.txt
```
wheel package ships cron jobs and Apache configuration and as it is installed in virtual environment, it can **not** actually layout files outside of it meaning that system-wide files should be placed manually or by configuration management system:

```sh
% (poem) cp $VIRTUAL_ENV/etc/cron.d/poem-clearsessions /etc/cron.d/
% (poem) cp $VIRTUAL_ENV/etc/cron.d/poem-syncvosf /etc/cron.d/
% (poem) ln -f -s $VIRTUAL_ENV/etc/httpd/conf.d/poem.conf /opt/rh/httpd24/root/etc/httpd/conf.d/
```

Next, the correct permission needs to be set on virtual environment directory:

```sh
% (poem) chown -R apache:apache $VIRTUAL_ENV
```

#### PostgreSQL server setup

POEM is tested and meant to be running on PostgreSQL 10 DBMS. CentOS 7 operating system delivers [PostgreSQL 10 through Software Collections service](https://www.softwarecollections.org/en/scls/rhscl/rh-postgresql10/) that is installed with the following instructions:

```sh
% yum -y install centos-release-scl
% yum -y install scl-utils
% yum -y install rh-postgresql10
```

Initalization of database:
```sh
% scl enable rh-postgresql10 'postgresql-setup --initdb'
```

In `/var/opt/rh/rh-postgresql10/lib/pgsql/data/pg_hba.conf`, change default client authentication to password authentication:
```sh
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
```
Default `ident` should be replaced by `md5`.

Start the service:
```sh
% systemctl start rh-postgresql10-postgresql
```

Set password for default DB user `postgres`:
```sh
% su - postgres -c 'scl enable rh-postgresql10 -- psql'
postgres=# \password postgres
```

### Web API

Web API has been extensively tested in RHEL environments such as Centos 7.

#### RPM packages for Centos 7

Assuming you are working on Centos 7 you can quickly install the latest production version by looking for the latest `argo-web-api-*.rpm` package in <http://rpm-repo.argo.grnet.gr/ARGO/prod/centos7/>

Alternatively you can create the following file at `/etc/yum.repos.d/argo.repo` with the following contents

```
[argo-prod]
name=ARGO Production Repository - Centos7
baseurl=http://rpm-repo.argo.grnet.gr/ARGO/prod/centos7/
gpgcheck=0
enabled=1
```

and then you can install the latest Web API through the yum package manager by issuing:

```
yum install argo-web-api
```

#### Building from source

Alternatively you can visit the source github repo and build the package by following the readme instructions here: <https://github.com/ARGOeu/argo-web-api#installation>

#### Web API Installed files
Web API is contained in a single binary file.

If you are using rpm package for installing Web API its binary is located at `/var/www/argo-web-api/argo-web-api`

The configuration file is located in `/etc/argo-web-api.conf`
To configure web api see [Configuration](#)

There is also a systemd file automatically created to handle the service
```
systemctl start argo-web-api
systemctt status argo-web-api
```
<<<<<<< HEAD
=======

### Compute/Streaming engine

Compute/Streaming engine is the heart of the analytics system. It relies on executing both batch and streaming jobs on Apache Flink that operate on streaming data coming from Messaging and on data collections stored in hdfs destinations. The results produced are stored in MongoDB. Web API is a critical component that the Compute/Streaming engine needs so as to coordinate jobs, identify tenants and gather extra information such as topologies, profiles and report requirements. 

In order to Install locally the Compute/Streaming engine you will need the following components already installed:

Component checklist:
- Wep API (See Previous Section on how to install it)
- MongoDB 4.4 server (See how to install MongoDB [here](https://www.mongodb.com/docs/v4.4/administration/install-on-linux/))
- Access to an HDFS 2.x cluster or setup a single node standalone cluster locally (See how to install HDFS [here](https://hadoop.apache.org/docs/r2.10.2/hadoop-project-dist/hadoop-common/SingleCluster.html))
- Access to Messaging Service (or see in these guides how to install a local instance of the Messaging Service)
- Access to a Flink 1.3.2 cluster or install a single node cluster locally (se how to install Apache Flink [here](https://nightlies.apache.org/flink/flink-docs-release-1.3/quickstart/setup_quickstart.html))

You will also need to have JAVA 1.8 (openjdk installed) - which is already a requirement for all java based components mentioned above

You will also need to have a Python 3.6 Virtual environment setup in order to be able to use the python utility scripts 

For both of the above see the Compute/Streaming engine section in the [Bulding guide](building.md#computestreaming-engine)

Having the python virtual environment setup and activated, check out locally the repository <https://github.com/argoeu/argo-streaming> by issuing:

```
git clone https://github.com/argoeu/argo-streaming
```

Python scripts reside in the `./bin` folder and their configuration in the `./conf` folder

The configuration `./conf` folder contains:
- `logger.conf`: For detailed logging configuration - leave it as is for most cases
- `config.schema.json`: This is used for validating the schema of your main configuration file, look for errors in values etc.
- `conf.template`: This is the template for the main configuration file. You can use it as a base and create a new configuration file for example: `./conf/argo-streaming-local.conf` (or what ever name you prefer)
- `./conf/argo-streaming.conf`: Repo includes this pre-existing file and uses it in unit tests.

See configuration guide on how to configure Compute/Streaming Engine in order for the python utility scripts to work properly [here](configuration.md) 

#### Using python utity scripts

After configured properly, the python scripts automatically contact argo-web-api for getting new configuration about tenants and update the local `./conf/argo-streaming.conf` file. 

Any script can be invoked with the `--dry-run` parameter to get info on what is going to be executed and submitted in flink cluster

You can also use the `--help` parameter to get more information about the script required parameters and how they are used. 

There scripts available at your disposal are the following:
####  1. Metric Ingestion Submit
This script submits a metric ingestion job for a specific tenant. The purpose of this job is to ingest metric data from a specific Messaging topic and store them as avro files at a specific hdfs destination. 

If your configuration is complete you can invoke the script by issuing:

```
./bin/metric_ingestion_submit.py -t <TENANT_NAME> -c <CONFIG_FILE>
```

- Replace `<TENTANT_NAME>` with the name of your tenant (Case-Sensitive).
- Replace `<CONFIG_FILE>` with the path to your configuration file (.e.g `./conf/argo-streaming-local.conf`)

More details about the metric ingestion script below:
```
usage: metric_ingestion_submit.py [-h] -t STRING [-c PATH] [-u] [--dry-run]

AMS Metric Ingestion submission script

optional arguments:
  -h, --help            show this help message and exit
  -t STRING, --tenant STRING
                        Name of the tenant
  -c PATH, --config PATH
                        Path for the config file
  -u, --sudo            Run the submition as superuser
  --dry-run             Runs in test mode without actually submitting the job
```

####  2. Multi Job Submit
This script submits a multi computation job for a specific tenant, a specific report and a specific date. The purpose of this job is to produce availability/reliability results, status results and trend results
using options, settings and profiles dictated by the specific report 

If your configuration is complete you can invoke the script by issuing:

```
./bin/multi_job_submit.py -t <TENANT_NAME> -r <REPORT_NAME> -c conf/argo-streaming.conf -d <YYYY-MM-DD>
```

- Replace `<TENTANT_NAME>` with the name of your tenant (Case-Sensitive).
- Replace `<REPORT_NAME>` with the name of your report (Case-Sensitive)
- Replace `<YYYY-MM-DD>` with the date of your choice (in YYYY-MM-DD format)
- Replace `<CONFIG_FILE>` with the path to your configuration file (.e.g `./conf/argo-streaming-local.conf`)


More details about the metric ingestion script below:
```
usage: multi_job_submit.py [-h] -t STRING -r STRING [-d DATEYYYY-MM-DD]
                           [-m KEYWORD(insert|upsert)] [-x STRING] [-c PATH]
                           [-u] [--clear-prev-results] [--dry-run] [-s STRING]
                           [-S STRING]

Batch Status Job submit script

optional arguments:
  -h, --help            show this help message and exit
  -t STRING, --tenant STRING
                        Name of the tenant
  -r STRING, --report STRING
                        Name of the report
  -d DATE(YYYY-MM-DD), --date DATE(YYYY-MM-DD)
                        Date to run the job for
  -m KEYWORD(insert|upsert), --method KEYWORD(insert|upsert)
                        Insert or Upsert data in mongoDB
  -x STRING, --calculate STRING
                        Comma separated list of what to calculate
                        (ar,status,trends)
  -c PATH, --config PATH
                        Path for the config file
  -u, --sudo            Run the submit job as superuser
  --clear-prev-results  Clear previous results from datastore
  --dry-run             Runs in test mode without actually submitting the job
  -s STRING, --source-data STRING
                        Define source of data to be used (possible values:
                        tenant, feeds, all)
  -S STRING, --source-topo STRING
                        Define source of topology to be used (possible values:
                        tenant, all)
```

####  3. Streaming job submit
This script submits a streaming job for a specific tenant and a specific report. The purpose of this job is to produce real time events based on the metric data coming of the Messaging Service. It can direct its output both at Messaging Service (topic) or at a Kafka Remote endpoint (topic)

If your configuration is complete you can invoke the script by issuing:

```
./bin/stream_status_job_submit.py -t <TENANT_NAME> -r <REPORT_NAME> -c conf/argo-streaming.conf -d <YYYY-MM-DD>
```

- Replace `<TENTANT_NAME>` with the name of your tenant (Case-Sensitive).
- Replace `<REPORT_NAME>` with the name of your report (Case-Sensitive)
- Replace `<CONFIG_FILE>` with the path to your configuration file (.e.g `./conf/argo-streaming-local.conf`)


More details about the metric ingestion script below:
```
usage: stream_status_job_submit.py [-h] -t STRING [-d DATEISO-8601] -r STRING
                                   [-c PATH] [-u] [--dry-run]
                                   [--historic-profiles] [--profile-check]
                                   [-timeout INT]

Stream Status Job submit script

optional arguments:
  -h, --help            show this help message and exit
  -t STRING, --tenant STRING
                        Name of the tenant
  -d DATE(ISO-8601), --date DATE(ISO-8601)
                        Date in ISO-8601 format
  -r STRING, --report STRING
                        Report status
  -c PATH, --config PATH
                        Path for the config file
  -u, --sudo            Run the submission as superuser
  --dry-run             Runs in test mode without actually submitting the job
  --historic-profiles   use historic profiles
  --profile-check       check if profiles are up to date before running job
  -timeout INT, --timeout INT
                        Controls default timeout for event regeneration (used
                        in notifications)
```
>>>>>>> f9ad3ff (Compute/Streaming engine)
