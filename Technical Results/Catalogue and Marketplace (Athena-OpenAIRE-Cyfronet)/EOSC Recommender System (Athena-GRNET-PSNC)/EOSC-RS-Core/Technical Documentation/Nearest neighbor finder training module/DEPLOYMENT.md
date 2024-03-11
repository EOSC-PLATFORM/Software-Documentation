# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

Before the deployment of main NN Finder API, the Downloader service needs to be running, preferrably on a separate server. The docker-compose.yml file is ready for deployment of both services, as they share this repository. Check out [System Architecture](docs/SYSTEM-ARCHITECTURE.md) for information about dependencies.

### Celery Worker

1. Run command `docker compose up`to start the fastapi instance in the created container

### Nearest Neighbor Finder Training Module
On the NN Finder Training Module server:

5. Run command `docker compose up`to start the fastapi instance in the created container
2. Use Training Module's health check `/diag` - Celery should be accessible through the Redis/RabbitMQ connection, so the status should be `UP`.
3. Navigate to the /docs webpage on port 8001 to test the endpoints
4. Send an example request to Training Module's endpoint `/train/services` - the task should be sent to the worker and new trained index should appear in HDFS Index Storage.
