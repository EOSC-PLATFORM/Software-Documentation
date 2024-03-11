# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Troubleshooting

### Connection problems with Kafka

When connection with Kafka is broken during connection(either during starting module or during runtime)
you will see following error in logs:

```log
[ERROR] nearline_app.database_connectors.PostgresConnector: Trying to reestablish connection with Postgres
FAIL [rdkafka#consumer-1] [thrd:ip/bootstrap]: ip/bootstrap: Connect to ipv4#ip:port failed: Unknown error (after 21053ms in state CONNECT)
```

this mean this Kafka is not available at the moment.
It is recommended to check this connection outside the module.

### Connection problems with Postgres

When connection with Postgres is broken during connection(either during starting module or during runtime)
you will see following error in logs:

```log
[ERROR] nearline_app.database_connectors.PostgresConnector: Can't connect to postgres database, after 1 min retrying...
```

this mean this Postgres is not available at the moment.

During startup, following message will be displayed if Postgres is not running:

```log
Postgres is not running
Kafka consumer not started
```
