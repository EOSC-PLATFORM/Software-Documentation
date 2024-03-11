# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Installation

## Table of Contents
1. Prerequisites
2. Downloading EOSC Accounting for Services
3. Building and Running EOSC Accounting for Services
4. Securing EOSC Accounting for Services with Apache HTTP Server
5. Deploying Multiple Instances for High Availability


## Prerequisites
Before installing EOSC Accounting for Services, ensure you have the following:

- Java 11 or higher installed on your system.
- Apache Maven 3.8.4 or higher.
- MongoDB installed and configured.
- OIDC Provider for user authentication. Ensure it is properly configured.

Please ensure that these dependencies are properly installed and configured before proceeding with the installation process.

## Downloading EOSC Accounting for Services

Download the latest version of EOSC Accounting for Services from [github repository](https://github.com/ARGOeu/argo-accounting/releases).

## Building and Running EOSC Accounting for Services

- Open a command prompt or terminal.
- Navigate to the directory containing the downloaded EOSC Accounting for Services source code.
- Run the following command to build the JAR file:
```console
mvn clean package -Dquarkus.package.type=uber-jar 
```
This will generate an _über-jar_ file in the target directory. 
- To run the software, execute the following command:
```console
java -jar target/*-runner.jar 
```
## Securing EOSC Accounting for Services with Apache HTTP Server

To enhance the security of EOSC Accounting for Services, you can set up an Apache HTTP Server as a reverse proxy in front of it. This will provide an additional layer of protection and allow for finer control over access.

Follow these steps to secure EOSC Accounting for Services with Apache HTTP Server:

- Install Apache HTTP Server.
- Configure Apache as a Reverse Proxy.
 
## Deploying Multiple Instances for High Availability

To ensure high availability of EOSC Accounting for Services, you can deploy multiple instances of the software and use a load balancer to distribute incoming requests evenly among them. This setup helps distribute the load and provides redundancy in case one instance fails.
Follow these steps to deploy multiple instances of EOSC Accounting for Services with a load balancer:

### Set Up Multiple Instances

Install and configure multiple instances of EOSC Accounting for Services on separate servers or virtual machines. Make sure each instance is accessible over the network.

### Install and Configure Load Balancer

- Choose a suitable load balancer software or hardware appliance. For our setup, we use HAProxy.
- Install and configure the load balancer to distribute requests among the instances. Follow the specific documentation for the chosen load balancer.

### Update DNS or Networking

Adjust your DNS settings or network configuration to point to the load balancer's IP address or hostname. This way, all incoming requests will be directed to the load balancer.



    
