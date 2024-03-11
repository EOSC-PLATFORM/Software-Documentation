# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

This guide outlines the deployment process for EOSC Accounting for Services using Ansible. We will describe each role used in the deployment process.
EOSC Accounting for Services is deployed on base CentOS 7 servers.

## Ansible Roles

In our deployment, we use the following Ansible roles to orchestrate the installation and configuration of EOSC Accounting for Services components:

1. **Apache Role: Securing EOSC Accounting for Services with Apache HTTP Server**

This role is responsible for securing EOSC Accounting for Services using the Apache HTTP Server and described [here](https://github.com/ARGOeu/argo-ansible/tree/master/roles/apache).

2. **Mongo Role: Installing MongoDB Database**

This role is responsible for installing a MongoDB database to store EOSC Accounting for Services information and described [here](https://github.com/ARGOeu/argo-ansible/tree/master/roles/mongodb).

3. **Quarkus API Role: Deploying Quarkus API**

EOSC Accounting for Services built with the Quarkus framework.So, we have created a dedicated [role](https://github.com/ARGOeu/argo-ansible/tree/master/roles/quarkus-api)
for deploying such applications.

4. **HAProxy Role: Installing and Configuring Load Balancer**

This role is responsible for installing and configuring the [HAProxy load balancer](https://github.com/ARGOeu/argo-ansible/tree/master/roles/haproxy).

5. **Deploying OIDC Client**

There is a [task](https://github.com/ARGOeu/argo-ansible/tree/master/roles/accounting/tasks/oidc_client.yml) which is responsible for deploying an OIDC client to obtain a token from the OIDC Provider.


## Conclusion

Combining all the roles into a playbook file makes it convenient to perform a complete deployment. Below is an example playbook that includes all the roles mentioned in the deployment guide:

```yaml
- hosts: mongo
  become: yes
  roles:
    - { role: mongodb,       task: main,    tags: mongodb       }

- hosts: apache
  become: yes
  roles:
    - { role: commons,    task: cert,    tags: apache_certs      }
    - { role: apache,     task: main,    tags: apache_install    }

- hosts: quarkus_api
  become: yes
  roles:
    - { role: quarkus-api,  task: quarkus-api, tags: quarkus-api }

- hosts: accounting_oidc_client
  become: yes
  roles:
    - { role: accounting, task: oidc_client, tags: accounting-oidc-client   }

- hosts: haproxy
  become: yes
  roles:
    - { role: haproxy, task: haproxy , tags: haproxy_install }
```
