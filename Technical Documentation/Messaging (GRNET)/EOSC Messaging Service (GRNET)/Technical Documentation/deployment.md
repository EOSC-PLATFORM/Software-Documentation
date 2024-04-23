# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0 -- >

## Deployment

This guide outlines the deployment process for EOSC Messaging Service using Ansible. We will describe each role
used in the deployment process.
EOSC Messaging Service is deployed on base CentOS 7 servers.

## Ansible Roles

In our deployment, we use the following Ansible roles to orchestrate the installation and configuration of EOSC
Messaging Service components:

### Mongo Role: Installing a MongoDB replica set

This role is responsible for installing a MongoDB replica set in order to store the needed metadata for the EOSC
Messaging Service.
The role is described [here.](https://github.com/ARGOeu/argo-ansible/tree/master/roles/mongodb)

### Zookeeper Role: Installing a Zookeeper Cluster

This role is responsible for installing a Zookeeper cluster which is the needed component for the message que, Kafka.
The role is described [here.](https://github.com/ARGOeu/argo-ansible/tree/master/roles/zookeeper)

### Kafka Role: Installing a Kafka Cluster

This role is responsible for installing a Kafka cluster which is the backbone of the EOSC Messaging System, the
messaging que itself.
The role is described [here.](https://github.com/ARGOeu/argo-ansible/tree/master/roles/kafka)

### Messaging Service: Installing a high availability set up of N messaging services

This role is responsible for installing a number of messaging APIs and connecting each one of them with the
other components.
The role is described [here.](https://github.com/ARGOeu/argo-ansible/tree/master/roles/ams)

### Haproxy: Installing a single haproxy instance

This role is responsible for installing a HAproxy instance, acting as the entry point to the EOSC messaging service.
It serves as the load balancer for the installed messaging apis.
The role is described [here.](https://github.com/ARGOeu/argo-ansible/tree/master/roles/haproxy)

### (Optional) Authentication Service: Installing a single instance of the authentication service

This role is response for installing the complementary authentication component in case we want to support
other authentication mechanisms besides x-api-key header tokens to access the messaging apis.
The role is described [here.](https://github.com/ARGOeu/argo-ansible/tree/master/roles/argo-api-authn)

### (Optional) Push server: Installing a single instance of the push server

This role is responsible for installing the complementary push server component in case we want to support
push enabled subscriptions.
The role is described [here.](https://github.com/ARGOeu/argo-ansible/tree/master/roles/ams-push-server)

# Conclusion

Combining all the roles into a playbook file makes it convenient to perform a complete deployment. Below is an example
playbook that includes all the roles mentioned in the deployment guide:

```yaml
- hosts: mongo_private_cluster
  become: yes
  roles:
    - { role: mongodb,    task: main,     tags: mongodb }


- hosts: ams
  become: yes
  roles:
    - { role: zookeeper,     task: main,             tags: zookeeper_install }
    - { role: kafka,         task: main,             tags: kafka_install }
    - { role: ams,           task: deploy,           tags: ams_install }
    - { role: ams,           task: deploy_metrics,   tags: ams_install }
    - { role: ams,           task: init_db,          tags: init_ams_db }


- hosts: ams_push_server
  become: yes
  roles:
    - { role: push-server,   task: push-server-setup,    tags: push_install }


- hosts: haproxy
  become: yes
  roles:
    - { role: haproxy,    task: haproxy,  tags: haproxy_install }


- hosts: authn
  become: yes
  roles:
    - { role: argo-api-authn,    task: authn-setup }
    - { role: argo-api-authn,    task: authn-init, tags: init_checks }
```
