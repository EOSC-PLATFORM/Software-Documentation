# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Troubleshooting

- Common operational issues and solutions.
- Guidelines for diagnosing problems.

### Connection problem to dependent module
When it is present in a response from the diagnostic endpoint, the status for the dependent module is as follows:
```
{
    "NNFinder": {
        "status": "DOWN",
        "error": "Error while connecting to NNFinder: Server disconnected without sending a response."
    }
}
```
this means that there is a problem with the connection to Nearest neighbor finder module and you should check the configuration, whether the address of Nearest neighbor finder module is correct and whether this service is available to Online engine.

### Connection problem to database
When it is present in a response from the diagnostic endpoint, the status of one of the databases: `resource_db`, `metadata_db`, `user_db` or `preprocesor_db` is as follows:

```
    "status": "DOWN",
    "database type": "PostgreSQL",
    "error": "OperationalError while connecting to PostgreSQL: RemoteApiUnavailableError component: PostgreSQL\n        url: URL status: 503 detail: could not translate host name \"URL\" to address: Unknown host\n"
```
it may mean that the database is not working or there is a problem with communication. Check if the connection configuration to the databases is correct.

### Container is starting up however, workers are terminated before full startup
This may be due to insufficient memory RAM allocated for the container. In such a case, increase the amount of allocated RAM or reduce the number of workers. This can be done by configuring the environment variables `WORKERS_PER_CORE` and `WEB_CONCURRENCY`. For details, see [Configuration](CONFIGURATION.md).
