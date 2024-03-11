# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Troubleshooting

- Common operational issues and solutions.
- Guidelines for diagnosing problems.

### Connection problem to Kafka
When it is present in a response from the diagnostic endpoint, the status is as follows:
```json
{
    "status": "DOWN",
    "components": {
      [...]
        "kafka": {
            "status": "DOWN",
      [...]
        }
    }
}
```
it may mean that the Kafka is not working or there is a problem with communication. Check if the connection configuration to the Kafka is correct.

### Connection problem to database
When it is present in a response from the diagnostic endpoint, the status is as follows:
```json
{
    "status": "DOWN",
    "components": {
      [...]
        "db": {
            "status": "DOWN",
      [...]
        }
    }
}
```
it may mean that the database is not working or there is a problem with communication. Check if the connection configuration to the databases is correct.

### Connection problem to JMS
When it is present in a response from the diagnostic endpoint, the status is as follows:
```json
{
    "status": "DOWN",
    "components": {
      [...]
        "jms": {
            "status": "DOWN",
      [...]
        }
    }
}
```
it may mean that the JMS is not working or there is a problem with communication. Check if the connection configuration to the JMS is correct.