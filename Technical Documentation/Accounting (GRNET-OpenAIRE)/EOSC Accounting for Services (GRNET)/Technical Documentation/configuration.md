# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

This document serves as a guide to configuring the various components of our software stack. It covers the configuration settings for the Apache HTTP Server, the HAProxy load balancer, the MongoDB database, 
and the specific configurations related to our software.

## Apache HTTP Server Configuration

### Overview
The Apache HTTP Server is a critical component of our infrastructure, responsible for handling HTTP requests. 
The configuration settings ensure optimal performance, security, and compatibility with our EOSC Accounting for Services.

#### Configuration File: [path/to/apache/conf/httpd.conf]

Sample Configuration:
```editorconfig

<VirtualHost *:80>
  ServerName host_name
  Redirect permanent / https://host_name
</VirtualHost>

<VirtualHost *:443>
  ServerName host_name

  SSLEngine on
  SSLCertificateFile /etc/grid-security/hostcert.pem
  SSLCertificateKeyFile /etc/grid-security/hostkey.pem
  SSLCertificateChainFile /etc/pki/tls/certs/chain.pem
                                                                    

  ProxyPass / http://127.0.0.1:8080/
  ProxyPassReverse / http://127.0.0.1:8080/

```
For automating the Apache HTTP Server configuration, we utilize Ansible. Below is a reference to the Ansible role and configuration:

- [apache role](https://github.com/ARGOeu/argo-ansible/tree/master/roles/apache)
- [ansible apache configuration](https://github.com/grnet/argo-ansible-deploy/blob/devel/host_vars/api-1.accounting.argo.grnet.gr/apache.yml)


## HAProxy Load Balancer Configuration

### Overview 

HAProxy serves as our load balancer, distributing incoming traffic across multiple servers. This section outlines the configuration settings 
to ensure load balancing efficiency and high availability.

#### Configuration

For automating the HAProxy Load Balancer configuration, we utilize Ansible. Below is a reference to the Ansible role and configuration:

- [haproxy role](https://github.com/ARGOeu/argo-ansible/tree/master/roles/haproxy)
- [haproxy configuration](https://github.com/grnet/argo-ansible-deploy/blob/devel/host_vars/api.accounting.argo.grnet.gr/haproxy.yml)

## EOSC Accounting for Services Configuration

### Overview

Our software has specific configurations that interact with the OIDC Provider and MongoDB. 
This section provides details on how to configure the software to ensure seamless integration with the rest of the stack.

### Configuration

Our software configuration relies on environment variables for specific settings. These variables must be exported before running the software. Below are the environment variables required:

```properties

QUARKUS_MONGODB_CONNECTION_STRING=The URL to access to MongoDB
QUARKUS_OIDC_AUTH_SERVER_URL=The base URL of the OpenID Connect (OIDC) server
QUARKUS_OIDC_CREDENTIALS_SECRET=Client secret which is used for a client_secret_basic authentication method
QUARKUS_OIDC_CLIENT_ID=The client-id of the application. Each application has a client-id that is used to identify the application
AAI_PROXY_CLIENT_URL=The URL to access the OIDC client to obtain a token from the OIDC Provider
```

Also, our software configuration relies on environment variables and properties to define admin users. Certainly, the voperson_id obtained from the AAI (Authentication and Authorization Infrastructure) Proxy serves as the unique identifier for user authentication in our system. 
The AAI Proxy is responsible for managing the authentication process, and the voperson_id is a key attribute associated with each authenticated user. This identifier is used in our software configuration to designate admin users and track user-related activities within the system.

```properties

SYSTEM_ADMIN_VOPERSONID="voperson_id_1, voperson_id_2, voperson_id_3"
SYSTEM_ADMIN_EMAIL="email_1, email_2, email_3"
SYSTEM_ADMIN_NAME="name_1, name_2, name_3"
```

For automating the EOSC Accounting for Services Configuration, we utilize Ansible. Below is a reference to the Ansible configuration:

- [EOSC Accounting for Services configuration](https://github.com/ARGOeu/argo-ansible/tree/master/roles/accounting/templates/accounting.service.j2)
