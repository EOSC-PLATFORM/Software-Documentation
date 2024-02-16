# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Prerequisites
1. `git`
2. `docker`
3. `.env` file in the project root as stated in [Configuration](CONFIGURATION.md).
4. `docker-compose`  version: `>1.29.2`

## How to get latest version of application

To build any of the applications, download the latest version from the repository to the server using:

HTTPS:

`https://git.man.poznan.pl/stash/scm/eosc-rs/nearest-neighbor-finder.git`

SSH:

`git clone ssh://git@git.man.poznan.pl:7999/eosc-rs/nearest-neighbor-finder.git`

## How to build

After downloading the repository, build the docker container form [Dockerfile](../Dockerfile) using [docker compose file](../docker-compose.yml).

### Nearest Neighbor Finder Downloader
On the Downloader server:

1. Copy repository to the server
2. Comment out the `fastapi` service in docker-compose.yml
3. Add required .env file in the project directory and fill it out with the required variables as stated in [configuration](CONFIGURATION.md)
4. Build docker image with `docker compose build`

### Nearest Neighbor Finder
On the NN Finder server:

1. Copy repository to the server
2. Comment out the `downloader` service in docker-compose.yml
3. Add required .env file in the project directory and fill it out with the required variables as stated in [configuration](CONFIGURATION.md)
4. Build docker image with `docker compose build`
