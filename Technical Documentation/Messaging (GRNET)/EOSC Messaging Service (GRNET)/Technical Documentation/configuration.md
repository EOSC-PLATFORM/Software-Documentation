# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0 -- >

# Introduction

The are four essential components that need to be configured in order for the EOSC messaging service
to deliver its functionality and another optional three that support additional features.

* Zookeeper
* Kafka
* MongoDB
* Messaging Service
* Authentication Service (optional)
* Push server (optional)
* Haproxy (Optional)

# Configuration Overview

Each of the components has its configuration file(s). Should any of them be misconfigured,
the behavior of the system might be unexpected.

# Security Considerations

Most of the information stored in the configuration files is sensitive (tokens, passwords). Those files should then have
properly set permissions, to avoid that unauthorised users can access them.

It should also take care of it that such information is not stored in any public repositories.

## Zookeeper

### Configuration Files

The main configuration:

- `/etc/zookeeper/conf/zoo.cfg` which contains the main configuration
- `/etc/zookeeper/conf/myid` which contains the unique ID of the respective node.

### Configuration Parameters

In Zookeeper official [Administrator Guide](https://zookeeper.apache.org/doc/r3.9.1/zookeeperAdmin.html)
you can find all the necessary details on how to set up and operate
a Zookeeper cluster.

### Configuration Management

All the configuration management is done with the help
of the [Argo Ansible Module](https://github.com/ARGOeu/argo-ansible/tree/master/roles/zookeeper)

### Examples

#### zoo.cfg

```text
maxClientCnxns=60
# The number of milliseconds of each tick
tickTime=2000
# The number of ticks that the initial
# synchronization phase can take
initLimit=10
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
syncLimit=5
# the directory where the snapshot is stored.
dataDir=/var/lib/zookeeper
# the port at which the clients will connect
clientPort=2181
# the directory where the transaction logs are stored.
dataLogDir=/var/lib/zookeeper


server.0=192.168.0.2:2888:3888
server.1=192.168.0.3:2888:3888
server.2=192.168.0.4:2888:3888
```

#### myid

```text
1
```

## Kafka

### Configuration Files

The main configuration:

- `/etc/kafka/conf/server.properties which contains the main configuration`

### Configuration Parameters

In Kafka official [Configuration Guide](https://kafka.apache.org/documentation/#config)
you can find all the necessary details on how to set up and operate
a Kafka cluster.

### Configuration Management

All the configuration management is done with the help
of the [Argo Ansible Module](https://github.com/ARGOeu/argo-ansible/tree/master/roles/kafka)

### Examples

#### server.properties

```text
# The id of the broker. This must be set to a unique integer for each broker.
broker.id=1

# Default replication factors for automatically created topics
default.replication.factor=2


############################# Socket Server Settings #############################

# The address the socket server listens on. It will get the value returned from
# java.net.InetAddress.getCanonicalHostName() if not configured.
#   FORMAT:
#     listeners = listener_name://host_name:port
#   EXAMPLE:
#     listeners = PLAINTEXT://your.host.name:9092
#listeners=PLAINTEXT://:9092

# Hostname and port the broker will advertise to producers and consumers. If not set,
# it uses the value for "listeners" if configured.  Otherwise, it will use the value
# returned from java.net.InetAddress.getCanonicalHostName().
#advertised.listeners=PLAINTEXT://your.host.name:9092

# Maps listener names to security protocols, the default is for them to be the same. See the config documentation for more details
#listener.security.protocol.map=PLAINTEXT:PLAINTEXT,SSL:SSL,SASL_PLAINTEXT:SASL_PLAINTEXT,SASL_SSL:SASL_SSL

# The port the socket server listens on
port=9092

# Hostname the broker will bind to. If not set, the server will bind to all interfaces
host.name=ams01.priv

# Hostname the broker will advertise to producers and consumers. If not set, it uses the
# value for "host.name" if configured.  Otherwise, it will use the value returned from
# java.net.InetAddress.getCanonicalHostName().
#advertised.host.name=<hostname routable by clients>

# The port to publish to ZooKeeper for clients to use. If this is not set,
# it will publish the same port that the broker binds to.
#advertised.port=<port accessible by clients>

# The number of threads handling network requests
# The number of threads that the server uses for receiving requests from the network and sending responses to the network
num.network.threads=3

# The number of threads that the server uses for processing requests, which may include disk I/O
num.io.threads=8

# The send buffer (SO_SNDBUF) used by the socket server
socket.send.buffer.bytes=102400

# The receive buffer (SO_RCVBUF) used by the socket server
socket.receive.buffer.bytes=102400

# The maximum size of a request that the socket server will accept (protection against OOM)
socket.request.max.bytes=104857600


############################# Log Basics #############################

# A comma separated list of directories under which to store log files
log.dirs=/var/lib/kafka

# The default number of log partitions per topic. More partitions allow greater
# parallelism for consumption, but this will also result in more files across
# the brokers.
num.partitions=1

# The number of threads per data directory to be used for log recovery at startup and flushing at shutdown.
# This value is recommended to be increased for installations with data dirs located in RAID array.
num.recovery.threads.per.data.dir=1

# Migrate any partitions the server is the leader for to other replicas prior to shutting down.
# This will make the leadership transfer faster and minimize the time each partition is unavailable to a few milliseconds.
controlled.shutdown.enable=true


############################# Internal Topic Settings  #############################
# The replication factor for the group metadata internal topics "__consumer_offsets" and "__transaction_state"
# For anything other than development testing, a value greater than 1 is recommended for to ensure availability such as 3.
offsets.topic.replication.factor=1
transaction.state.log.replication.factor=1
transaction.state.log.min.isr=1


############################# Log Flush Policy #############################

# Messages are immediately written to the filesystem but by default we only fsync() to sync
# the OS cache lazily. The following configurations control the flush of data to disk.
# There are a few important trade-offs here:
#    1. Durability: Unflushed data may be lost if you are not using replication.
#    2. Latency: Very large flush intervals may lead to latency spikes when the flush does occur as there will be a lot of data to flush.
#    3. Throughput: The flush is generally the most expensive operation, and a small flush interval may lead to excessive seeks.
# The settings below allow one to configure the flush policy to flush data after a period of time or
# every N messages (or both). This can be done globally and overridden on a per-topic basis.

# The number of messages to accept before forcing a flush of data to disk
#log.flush.interval.messages=10000

# The maximum amount of time a message can sit in a log before we force a flush
#log.flush.interval.ms=1000

############################# Log Retention Policy #############################

# The following configurations control the disposal of log segments. The policy can
# be set to delete segments after a period of time, or after a given size has accumulated.
# A segment will be deleted whenever *either* of these criteria are met. Deletion always happens
# from the end of the log.

# The minimum age of a log file to be eligible for deletion due to age
log.retention.hours=168

# A size-based retention policy for logs. Segments are pruned from the log unless the remaining
# segments drop below log.retention.bytes. Functions independently of log.retention.hours.
#log.retention.bytes=1073741824

# The maximum size of a log segment file. When this size is reached a new log segment will be created.
log.segment.bytes=1073741824

# The interval at which log segments are checked to see if they can be deleted according
# to the retention policies
log.retention.check.interval.ms=300000

# By default the log cleaner is disabled and the log retention policy will default to just delete segments after their retention expires.
# If log.cleaner.enable=true is set the cleaner will be enabled and individual logs can then be marked for log compaction.
log.cleaner.enable=false

############################# Zookeeper #############################

# Zookeeper connection string (see zookeeper docs for details).
# This is a comma separated host:port pairs, each corresponding to a zk
# server. e.g. "127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002".
# You can also append an optional chroot string to the urls to specify the
# root directory for all kafka znodes.
zookeeper.connect=ams01.priv:2181,ams02.priv:2181,ams03.priv:2181,ams04.priv:2181

# Enable auto creation of topic on the server
auto.create.topics.enable=true

# Timeout in ms for connecting to zookeeper
zookeeper.connection.timeout.ms=6000


############################# Group Coordinator Settings #############################

# The following configuration specifies the time, in milliseconds, that the GroupCoordinator will delay the initial consumer rebalance.
# The rebalance will be further delayed by the value of group.initial.rebalance.delay.ms as new members join the group, up to a maximum of max.poll.interval.ms.
# The default value for this is 3 seconds.
# We override this to 0 here as it makes for a better out-of-the-box experience for development and testing.
# However, in production environments the default value of 3 seconds is more suitable as this will help to avoid unnecessary, and potentially expensive, rebalances during application startup.
group.initial.rebalance.delay.ms=0
```

## MongoDB

### Configuration Files

The main configuration:

- `/etc/mongod.conf which contains the main configuration`

### Configuration Parameters

In MongoDB official [Configuration Manual](http://docs.mongodb.org/manual/reference/configuration-options/)
you can find all the necessary details on how to set up and operate
a MongoDB replica set.

### Configuration Management

All the configuration management is done with the help
of the [Argo Ansible Module](https://github.com/ARGOeu/argo-ansible/tree/master/roles/mongodb)

### Examples

##### mongod.conf

```text
# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# Where and how to store data.
storage:
  dbPath: /var/lib/mongo_repl
  journal:
    enabled: true
#  engine:
#  mmapv1:
#  wiredTiger:

# how the process runs
processManagement:
  fork: true  # fork and run in background
  pidFilePath: /var/run/mongodb/mongod.pid

# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1,mongo01.priv

#security:

#operationProfiling:

replication:
   replSetName: rs0

#sharding:

## Enterprise-Only Options

#auditLog:

#snmp:
```

## Messaging Service

### Configuration Files

The main configuration:

- `/etc/argo-messaging/config.json which contains the main configuration`

### Configuration Parameters

All the parameters are explained within the service's readme file
[configuration section.](https://github.com/ARGOeu/argo-messaging#configuration)

### Configuration Management

All the configuration management is done with the help
of the [Argo Ansible Module](https://github.com/ARGOeu/argo-ansible/tree/master/roles/ams)

### Examples

#### config.json

```json
{
  "bind_ip": "",
  "port": 443,
  "zookeeper_hosts": [
    "msg1:2181",
    "msg2:2181",
    "msg3:2181"
  ],
  "kafka_znode": "",
  "store_host": "mongo01,mongo02,mongo03",
  "store_db": "argo_msg",
  "certificate": "/var/www/argo-messaging/hostcert.pem",
  "certificate_key": "/var/www/argo-messaging/hostkey.pem",
  "per_resource_auth": "true",
  "log_level": "INFO",
  "push_enabled": true,
  "push_server_host": "push.server",
  "push_server_port": 8443,
  "push_worker_token": "xxxxxxx",
  "push_tls_enabled": true,
  "verify_push_server": true,
  "certificate_authorities_dir": "/var/www/argo-messaging/cas",
  "auth_option": "both",
  "proxy_hostname": "msg.argo.grnet.gr"
}
```

## Authentication Service

### Configuration Files

The main configuration:

- `/etc/argo-api-authn/conf.d/argo-api-authn-config.json which contains the main configuration`

### Configuration Parameters

All the parameters are explained within the service's readme file
[configuration section.](https://github.com/ARGOeu/argo-api-authn#configuration)

### Configuration Management

All the configuration management is done with the help
of the [Argo Ansible Module](https://github.com/ARGOeu/argo-ansible/tree/master/roles/argo-api-authn)

### Examples

##### argo-api-authn-config.json

```json
{
  "service_port": 8443,
  "mongo_host": "mongo01,mongo02,mongo03",
  "mongo_db": "argo_auth",
  "certificate_authorities": "/etc/grid-security/certificates",
  "certificate": "/var/www/argo-api-authn/hostcert.pem",
  "certificate_key": "/var/www/argo-api-authn/hostkey.pem",
  "service_token": "xxxxxxx",
  "supported_auth_types": [
    "x509"
  ],
  "supported_auth_methods": [
    "api-key",
    "headers"
  ],
  "supported_service_types": [
    "ams"
  ],
  "verify_ssl": true,
  "trust_unknown_cas": false,
  "verify_certificate": true,
  "service_types_paths": {
    "ams": "/v1/users:byUUID/{{identifier}}",
    "web-api": "/api/v2/admin/users:byID/{{identifier}}?export=flat"
  },
  "service_types_retrieval_fields": {
    "ams": "token",
    "web-api": "api_key"
  }
}
```

## Push Server

### Configuration Files

The main configuration:

- `/etc/ams-push-server/conf.d/ams-push-server-config.json which contains the main configuration`

### Configuration Parameters

All the parameters are explained within the service's readme file
[configuration section.](https://github.com/ARGOeu/ams-push-server#configuration)

### Configuration Management

All the configuration management is done with the help
of the [Argo Ansible Module](https://github.com/ARGOeu/argo-ansible/tree/master/roles/push-server)

### Examples

#### ams-push-server-config.json

```json
{
  "service_port": 8443,
  "certificate": "/var/www/ams-push-server/hostcert.pem",
  "certificate_key": "/var/www/ams-push-server/hostkey.pem",
  "certificate_authorities_dir": "/var/www/ams-push-server/cas",
  "ams_token": "xxxxxx",
  "ams_host": "msg.argo.grnet.gr",
  "ams_port": 443,
  "verify_ssl": true,
  "tls_enabled": true,
  "trust_unknown_cas": false,
  "log_level": "INFO",
  "skip_subs_load": false,
  "acl": [
    "msg.argo.grnet.gr"
  ]
}
```

## Haproxy

### Configuration Files

The main configuration:

- `/etc/haproxy/haproxy.cfg which contains the main configuration`

### Configuration Parameters

In Haproxy official [Configuration Manual](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/)
you can find all the necessary details on how to set up and operate
a Haproxy load balancer.

### Configuration Management

All the configuration management is done with the help
of the [Argo Ansible Module](https://github.com/ARGOeu/argo-ansible/tree/master/roles/haproxy)

### Examples

##### haproxy.cfg

```text
global
    # to have these messages end up in /var/log/haproxy.log you will
    # need to:
    #
    # 1) configure syslog to accept network log events.  This is done
    #    by adding the '-r' option to the SYSLOGD_OPTIONS in
    #    /etc/sysconfig/syslog
    #
    # 2) configure local2 events to go to the /var/log/haproxy.log
    #   file. A line like the following can be added to
    #   /etc/sysconfig/syslog
    #
    #  local2.*                       /var/log/haproxy.log
    #
    log         127.0.0.1 local2
    log-send-hostname msg.argo.grnet.gr
    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     10000
    nbproc               1                                  # Creates <number> processes when going daemon.
    nbthread             4                                  # Makes haproxy run on <number> threads.
    user        haproxy
    group       haproxy
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats.sock gid 989 mode 660 level admin

# SSL global configuration

    # LS config

    ssl-default-server-options no-tls-tickets
    ssl-default-bind-options no-sslv3 no-tlsv10 no-tlsv11

	## Disabling Session Tickets Although disabling session tickets will undoubtedly have a negative performance impact, for the moment being you will need to do that in order to provide forward secrecy

    tune.ssl.default-dh-param 2048
    ssl-server-verify none

    # ssl ciphers first test
    ssl-default-bind-ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH


#---------------------------------------------------------------------
# common defaults that all the 'listen' and 'backend' sections will
# use if not designated in their block
#---------------------------------------------------------------------
defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
	option 					log-health-checks
    option 					http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch

    retries		    3
    timeout http-request    10s
    timeout queue           5000
    timeout connect         20s
    timeout client          10m
    timeout server          10m
    timeout http-keep-alive 10000
    timeout check           10000
    maxconn                 100


# Statistics Interface Setup

listen stats
        bind *:9000  ssl crt /etc/grid-security/haproxy_argo_grnet_gr_pem.crt no-sslv3 no-tlsv10 no-tlsv11
        mode            http
	log             global
        maxconn 10
        timeout client 5m
        timeout server 5m
        timeout connect 5m
        timeout queue 5m
	timeout check 5m
        stats enable
        stats hide-version
        stats refresh 10s
        stats show-node
        stats auth xxxx:xxxx
        stats uri  /haproxy?stats

#---------------------------------------------------------------------
# main frontend which proxys to the backends
#---------------------------------------------------------------------


#frontend
frontend  msg.argo.grnet.gr
   bind :::443 ssl crt /etc/grid-security/haproxy_argo_grnet_gr_pem.crt no-sslv3 no-tlsv10 no-tlsv11
   bind :::80
   redirect scheme https if !{ ssl_fc }
   http-response set-header Strict-Transport-Security max-age=31536000
   option http-server-close
   option forwardfor
   reqadd X-Forwarded-Proto:\ https
   reqadd X-Forwarded-Port:\ 443
   timeout http-request    10s
   default_backend msg


#---------------------------------------------------------------------
# round robin balancing between the various backends
#---------------------------------------------------------------------


backend msg
 balance roundrobin
        server msg1 msg1.argo.grnet.gr ssl check port 443
        server msg2 msg2.argo.grnet.gr ssl check port 443
        server msg3 msg3.argo.grnet.gr ssl check port 443
```
