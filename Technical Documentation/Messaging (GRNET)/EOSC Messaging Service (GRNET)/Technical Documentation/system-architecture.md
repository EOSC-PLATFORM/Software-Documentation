# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0 -- >

## System Architecture

The EOSC Messaging Service gives its users the ability to implement real time event based work flows through a
simplistic
http rest api without the need for sophisticated libraries that take care of custom messaging protocols.

Apart from its ease of integration, the service also promises some strong reliability and availability semantics
through:

- Durability: provide very high durability, and at-least-once delivery, by storing copies of the same message on
  multiple servers.
- Scalability: It can handle increases in load without noticeable degradation of latency or availability
- Latency: A high performance service that can serve more than 1 billion messages per year
- Availability: it deals with different types of issues, gracefully failing over in a way that is unnoticeable to end
  users.
- Failures can occur in hardware, in software, and due to load.

In order to achieve the above characteristics it depends on the following core components:

- Zookeeper Cluster: is a centralised service for maintaining configuration information, naming, providing distributed
  synchronisation.
- Kafka Cluster: is a distributed publish-subscribe messaging system that is designed to be fast, scalable, and durable.
- MetaData store Cluster:  a distributed metadata store based on mongoDB

Despite the fact that The EOSC Messaging API has been designed to rely on a generic Message Back-end Interface
and use specific implementation of that interface for supporting different systems.
Right now the first implementation for the messaging back-end relies on Apache Kafka as a distributed messaging system.

A big advantage of the EOSC Messaging API is that provides a mechanism to easily support namespacing and different
tenants on a Kafka Back-end (Apache Kafka doesn’t support natively namespacing yet). THe EOSC Messaging
API uses the notion of ‘projects’ for each tenant and can support multiple projects each one containing multiple
topics/subscriptions and users on the same Kafka back-end.

Most of the time you will find an AMS cluster behind an HAproxy that acts as a load balancer.

Two additional components that enhance the functionality of an Argo Messaging Cluster are the following:

1) The authentication service , which provides the ability for different services to use alternative authentication
   mechanisms without having to store additional user info or implement new functionalities. The AUTH service holds
   various information about a service’s users, hosts, API urls, etc, and leverages them to provide its functionality.
   The auth service is a complementary component to AMS.

2) The push server(s), which are an optional set of worker-machines that are needed when the AMS wants
   to support push enabled subscriptions. It allows to decouple the push functionality from AMS api nodes.
   They perform the push functionality for the messages of a push enabled subscription (consume->deliver→ack). They
   provide a gRPC interface in order to communicate with their api and provide subscription runtime status.