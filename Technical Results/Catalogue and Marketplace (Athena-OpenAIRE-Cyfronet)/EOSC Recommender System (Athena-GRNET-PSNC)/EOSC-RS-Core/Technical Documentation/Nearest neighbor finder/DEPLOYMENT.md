# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

Before the deployment of main NN Finder API, the Downloader service needs to be running, preferrably on a separate server. The docker-compose.yml file is ready for deployment of both services, as they share this repository. **Both services have to share the same volume "/app/indexers" to work properly.**

### Nearest Neighbor Finder Downloader
On the Downloader server:

1. Assure the shared volume "/app/indexers" is available and accesible.
2. Run command `docker compose up` to start the fastapi instance in the created container
3. Navigate to the /docs page on port 8010 to test the endpoints

### Nearest Neighbor Finder
On the NN Finder server:

1. Assure the shared volume "/app/indexers" is available and accesible.
2. Run command `docker compose up`to start the fastapi instance in the created container
3. Navigate to the /docs webpage on port 8000 to test the endpoints
