# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Monitoring and Logging

The application writes all its logs to the standard output.
To collect them, you can use `Graylog` or any other tool that collects logs from standard output.

To set the logging level, set the environment variable `LOG_LEVEL` to one of the following values during configuration:
- DEBUG
- INFO
- WARN
- ERROR
- CRITICAL

Logs generated directly by applications have the following format:
```
[DATE_AND_TIME] [LOG_LEVEL_NAME] NAME: MESSAGE 
```
- DATE_AND_TIME - Date and time of log generation in format YYYY-mm-dd HH-MM-SS
- LOG_LEVEL_NAME - Text logging level for the message 
- NAME - The name of the file that generated the message
- MESSAGE - Message

The application also logs messages from uvicorn which may be in a different format.
