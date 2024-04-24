# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Troubleshooting

- Common operational issues and solutions.
- Guidelines for diagnosing problems.

### Connection problem to dependent module
When in response from the diagnostic endpoint, the status for the dependent module is as follows:
```
{
    "status": "DOWN",
    "error": "Error while connecting to Athena RS: All connection attempts failed"
}
```
this means that there is a problem with the connection to this module and you should check the configuration, whether the address of this module is correct and whether this service is available to RS Facade.

### Container is starting up however, workers are terminated before full startup
This may be due to insufficient memory RAM allocated for the container. In such a situation, increase the amount of RAM or reduce the number of workers. This can be done by configuring the environment variables `WORKERS_PER_CORE` and `WEB_CONCURRENCY`. For details, see [Configuration](CONFIGURATION.md).
