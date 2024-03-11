# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Monitoring and Logging

### Preprocessor

#### Monitoring

The health check endpoint `GET /actuator/health` query returns information about the service status,
helping to determine whether individual components are working properly. 

Correctly working components take the `status` value equal to `UP`, otherwise `DOWN` will appear.

<details>
<summary>Example</summary>

```json
{
    "status": "UP",
    "components": {
        "db": {
            "status": "UP",
            "details": {
                "database": "PostgreSQL",
                "validationQuery": "isValid()"
            }
        },
        "diskSpace": {
            "status": "UP",
            "details": {
                "total": 42949672960,
                "free": 42949632000,
                "threshold": 10485760,
                "exists": true
            }
        },
        "jms": {
            "status": "UP",
            "components": {
                "artificialConnectionFactory": {
                    "status": "UP",
                    "details": {
                        "provider": "ActiveBlaze"
                    }
                },
                "betaConnectionFactory": {
                    "status": "UP",
                    "details": {
                        "provider": "ActiveBlaze"
                    }
                },
                "connectionFactory": {
                    "status": "UP",
                    "details": {
                        "provider": "ActiveBlaze"
                    }
                }
            }
        },
        "kafka": {
            "status": "UP",
            "details": {
                "topics": [
                    "sync-service-dev",
                    "eosc-stats-dev-local",
                    "eosc-stats-dev",
                    "recommendations-evaluation",
                    "recommendations-evaluations-default",
                    "artificial-eosc-stats-dev",
                    "user-sync-default"
                ]
            }
        },
        "livenessState": {
            "status": "UP"
        },
        "ping": {
            "status": "UP"
        },
        "readinessState": {
            "status": "UP"
        },
        "version": {
            "status": "UP",
            "details": {
                "version": "1.4.0-16-gd76793d"
            }
        }
    },
    "groups": [
        "liveness",
        "readiness"
    ]
}
```

</details>

#### Logging

The application writes all its logs to the standard output.
To collect them, you can use `Graylog` or any other tool that collects logs from standard output.

To set the root logging level, set the environment variable `LOGGING_LEVEL_ROOT` 
and to set the preprocessor logging level set `LOGGING_LEVEL_PREPROCESSOR` to one of possible values:
- TRACE
- DEBUG
- INFO
- WARN
- ERROR
- OFF

### Spark Jobs

To monitoring Spark Jobs launch spark history server which displays logging data from all nodes in the Spark cluster.
The history server displays both completed and incomplete Spark jobs.

The status of completed jobs should be always verified manually.