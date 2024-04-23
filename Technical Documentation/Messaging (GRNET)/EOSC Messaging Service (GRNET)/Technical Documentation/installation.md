# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0 -- >

# Installation

- Detailed instructions for installing the software/application.
- Prerequisites, dependencies, and installation scripts.

The current installation of the EOSC Messaging Service is comprised by
the following components:

- Haproxy as Load balancer
- 3 instances of the Messaging service itself
- 3 instances of Kafka brokers
- 3 instances of Zookeeper servers
- 3 instances of mongo servers, an active replica set with one primary one secondary and an arbiter
- 1 instance of the authentication service
- 1 instance of the push server

## Installing Haproxy

1) Install the haproxy package through the respective package manager of the host distribution
2) Issue a valid x509 certificate
3) Bundle the certificate with the private key into a single **pem** file
4) Configure haproxy

[The official haproxy documentation.](http://docs.haproxy.org/)

## Installing Kafka

Install the vanilla kafka version or any other community edition.

[The official Kafka QuickStart Guide.](https://kafka.apache.org/quickstart)

## Installing Zookeeper

Install the official zookeeper version.

[The official zookeeper documentation.](https://zookeeper.apache.org/)

## Install MongoDB

Install the community edition for the required target platform.
[The official MongoDB installation guide.](https://www.mongodb.com/docs/manual/installation/)

## Managing Golang Services

The installation of the messaging cluster is completed with the
existence of the three following services:

1) Messaging Service
2) Authentication Service (optional)
3) Push server (optional)

Each of the listed packages is available
in [ARGO rpm repository](http://rpm-repo.argo.grnet.gr/ARGO/prod/centos7/). They are simply installed from .rpm
packages.

All the above services have been extensively tested in RHEL environments such as Centos 7.

#### RPM packages for Centos 7

Assuming you are working on Centos 7 you can quickly install the latest production version by looking for the
latest package in <http://rpm-repo.argo.grnet.gr/ARGO/prod/centos7/>

Alternatively you can create the following file at `/etc/yum.repos.d/argo.repo` with the following contents

```
[argo-prod]
name=ARGO Production Repository - Centos7
baseurl=http://rpm-repo.argo.grnet.gr/ARGO/prod/centos7/
gpgcheck=0
enabled=1
```

and then you can install the latest package through the yum package manager by issuing:

```
yum install argo-messaging
yum install argo-api-authn
yum install ams-push-server
```

#### Building from source

Alternatively you can visit the source github repo of each package
and build it by following the readme instructions as referenced in the [Building section.](building.md)

#### Installed files

All the services are represented by a single binary file respectively.

If you are using rpm package for installing the services, their respective binary is located
at `/var/www/<package-name>/<package-name>`

There is also a systemd file automatically created to handle the service

```
systemctl start argo-messaging
systemctt status argo-messaging

systemctl start argo-api-authn
systemctt status argo-api-authn

systemctl start ams-push-server
systemctt status ams-push-server

```
