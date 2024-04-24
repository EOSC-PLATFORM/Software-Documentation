# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

### Monitoring box

Before any installation, you must make sure that Sensu agent can contact Sensu backend on port 8081.

Monitoring boxes are deployed on base CentOS 7 servers. In practice, we use [ARGO Puppet module](https://github.com/ARGOeu/argo-puppet) for automatic deployment and configuration.

If you don't intend to use Puppet, you must first build Sensu backend and agent services from source as is described in [building document](building.md), and then install all the necessary tools as described in [installation document](installation.md). 

After the configuration described in the [configuration document](configuration.md), you need to start `ams-publisher` service and set up the cronjobs. We usually set `scg-reload.py` tool to run at minute 15 past every 2nd hour. The cronjob for `argo-poem-tools` runs at minute 0 past every 2nd hour. That way we make sure that, if any new metrics are added to metric profiles, they are installed before monitoring box reconfiguration.

If everything was set up properly, the monitoring box should start sending the test results to ARGO Messaging service.

### Web API

Web API is a central component of the Monitoring Service. 
It plays two important roles:
1) Allows users to create and maintain configurations about new tenants, profiles, topologies and reports
2) Serves the availability/reliability and status results produced based on such configurations.

The first role make the web api a single source of truth for the other components which rely on it to sync information regarding:
- Tenants
- Topologies
- Profiles (services and checks used)
- Downtimes
etc. 

Also it provides robust calls that allow clients to get specific results - organised in different reports - that include:
- Availability/Reliability scores
- Status timelines
- Trends

Since it is used by all other Monitoring Components it is higly recommended to be one of the first components to install.

Web API is a golang rest API application. It uses MongoDB for datastore. It needs to be accessible by the other components and by external clients that want to retrieve the information. It uses service access tokens for authentication and authorization and different roles that allow read/write capabilities. It is recommended to be deployed with private/public network access. Public access will be configured for external clients to browse results. Private access should be configured for the rest of the Monitoring components to have priviledge access to specific API methods. The database and api can be in a single VM but also in a distributed fashion (different VMs for API instances and cluster for the database)

We use Ansible recipes to deploy the Web API. There is a dedicated ansible role described here: <https://github.com/ARGOeu/argo-ansible/tree/master/roles/webapi>

We also use a dedicated ansible role for installing mongo described here: <https://github.com/ARGOeu/argo-ansible/tree/master/roles/mongodb>

### Compute / Streaming Engine

Compute / Streaming engine is the core component that analyses the monitoring data and calculates:
- Availability/Reliability scores each monitored item
- Timelines with status results for each monitored item
- Trends on various subjects by analysing and observing patterns on monitoring data

The compute engine is a set of analytics jobs expressed and executed on Apache Flink Platform along with some utility cli python scripts that accompany them. 

You need an endpoint (Current versions have been extensively tested and operated on Centos 7 VMs) that has access to an Apache Flink cluster in order to be able to submit the available jobs

This endpoint should have an Apache Flink 1.3.2 local client (see: <https://nightlies.apache.org/flink/flink-docs-release-1.3/setup/config.html>) for both deploying a Flink Cluster and a client node.

The endpoint should also have access to an HDFS cluster (that is also ofcourse accessible by flink) (for more information see: <https://hadoop.apache.org/docs/r2.10.2/hadoop-project-dist/hadoop-common/SingleCluster.html>)

The endpoint should also have access (even through an HTTP PROXY) to the Messaging service and the Web API.

The endpoint will also need to have JAVA 1.8 (openjdk installed) as well as a Python 3.6 Virtual environment setup in order to be able to use the python utility scripts.

You can see the bulding guide for building instructions on how to compile the JAR artifacts and how to install the python scripts along with the required configuration [link](building.md#computestreaming-engine)