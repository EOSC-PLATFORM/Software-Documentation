# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Scaling and Performance

The preprocessor should be vertically scaled depending on current needs: CPU, RAM, storage or network speed.

Scaling the computing cluster should be performed in accordance with general practices.

## Load tests

The load tests should give an answer to the following question:

> Is the preprocessor able to do its job under specific work load?

### What could be measured

- processing dumps (in cluster)
- processing user actions
- processing Marketplace events 
- calculating statistics (in the database - PostgreSQL)

The load test regarding Marketplace events has been abandoned because it is not expected that the number of events will increase significantly to values that the application would not be able to process. Mostly, these are single events.

### Acceptance criteria

Answer for the above question is "Yes" only if the preprocessor is able to handle the [target load](#target-load) in
[test environments](#test-environments).

### Target load

#### Dumps - calculated in cluster

- Size of a single JSONL file: 40 MB
- Total size of file collection: 8 GB
- Expected processing time: < 1h

#### User Actions - read from data bus (JMS)

- Throughput: 100 messages/s
- Time: 1h
- Total messages processed: 360 000

#### Statistics - calculated in database

- Total number of user actions: 360 000
- Maximum processing time: 1h

### Test Environments

Processing dumps was launched on an external computing cluster.

Previous tests were launched on a Linux-based test machine which is an equivalent of Intel Core I7, 32GB RAM,
100GB HDD. The preprocessor, JMS queue and database were running on the same machine.

### Additional assumptions - User Actions

The assumed traffic load is much larger than at the time of writing the tests.
In the future, based on traffic analysis, it should be adjusted accordingly.

* Number of active (non-anonymous) users: 4000
* Ratio of initially logged-in users to anonymous users: 1:100
* Number of User Actions per session: 1 - 10
* Chance for User sign-in (for anonymous users): 20%

### Conducting the test
#### User Actions

To perform the test, it is necessary to generate User Actions consistent with the specification.
To generate events, you can use a script or a simple application that is able to create events in json format
and send them to JMS.
As a result of processing, appropriate messages will appear on Kafka (the topic as set in the `KAFKA TOPIC _SESSION` environment variable)
Each received event results in one message being sent to Kafka - the user's session is updated.
Events are also reflected in the database, but creating a message on a Kafka topic is sufficient
to determine that the event has been processed.

#### Calculating statistics

The above test results in the generation of many records in the database,
which can be used to test the performance of the database on which statistics are calculated.
The application sends a request to calculate statistics by appropriately setting the `CRON_DAILY_CALCULATIONS`
environment variable. It should be set so that processing is performed only once.
The test ends successfully when the appropriate message appears on the Kafka topic (env var - `KAFKA_TOPIC_STATS`).

#### Dumps processing

To conduct the test, you can use an existing dump or prepare data. The test assumes the appropriate configuration of
the computing cluster, otherwise we may not be able to run processing. The status and processing time are checked
directly on the cluster. Processing should be started in the same way as in the case of regular dumps, but depending on
the data source, the download phase may be skipped and the data may be manually loaded into hdfs.
The procedure is described in [operations](../operations/Operations.md).

## Monitoring consumption of computing resources

### Monitoring the application running locally

Employ OS tools like Task Manager (Windows) or `top`, `htop` (Linux) for real-time insights into CPU, memory, and processes.

### Monitoring the application running in a container

Use container-specific tools like docker stats for real-time resource usage.
In Kubernetes, utilize built-in components like cAdvisor, Prometheus, and Grafana for cluster-wide monitoring.

### Other monitoring solutions

* **Nagios**

    Open-source monitoring system with extensible plugins for diverse service monitoring. Provides features alerting mechanisms and supports NRPE for remote monitoring.


* **Zabbix**

    Open-source solution with an agent-based approach for collecting host data. Employs triggers, actions, and web monitoring for comprehensive application insights.

### Best Practices

1. **Define Metrics**

    Identify key metrics (CPU, memory, disk I/O) relevant for your needs.


2. **Thresholds and Alerts**

    Set appropriate thresholds to trigger alerts for abnormal resource consumption.


3. **Scalability**

    Choose monitoring solutions that scale efficiently, especially in containerized environments.


4. **Automation**

   * Automate the deployment of monitoring agents and configurations for consistency.
   * Regularly update monitoring setups to adapt to your infrastructure. 
   * Choose monitoring solutions based on specific needs and preferences.