# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

### Prerequisites

1. `docker`
2. `.env` file in the project root (check [CONFIGURATION.md](CONFIGURATION.md) for more info)
4. `docker-compose`  version: `>1.29.2`

### Building
- Run the ```docker-compose build``` command to build a docker image of the application. For more details, see [BUILDING.md](BUILDING.md)

### Running
To create and run an application instance from a previously built docker image, run the ```docker-compose up``` command. It uses the startup configuration in the [docker compose file](../docker-compose.yaml) file and the application configuration in the [.env](../.env) file. By default, the application will be launched on port 8001.




In case of a startup problem, check if the image was built correctly.
