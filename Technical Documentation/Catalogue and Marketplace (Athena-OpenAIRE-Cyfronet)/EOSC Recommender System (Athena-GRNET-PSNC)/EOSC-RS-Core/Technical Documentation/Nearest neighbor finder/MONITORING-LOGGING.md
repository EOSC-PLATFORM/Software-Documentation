# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Monitoring and Logging
To collect logs, you can use `Graylog` or any other tool that collects logs from standard output.

Logging levels can be set in the environment variable `LOGGING_LEVEL` of the application.  `WARNING` is the default level. The available levels are: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`.

The format of the logs is as follows:

```bash
[<year>-<month>-<day>;<hours>:<minutes>:<seconds> | <logging level>] [<module name>]: <message>
```
