# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Prerequisites
1. `git`
2. `docker`
3. `.env` file in the project root (check [CONFIGURATION.md](CONFIGURATION.md) for more info)
4. `docker-compose`  version: `>1.29.2`

## How to get latest version of application

To build the application, download the latest version from the repository using:

HTTPS:

`git clone https://git.man.poznan.pl/stash/scm/eosc-rs/online-ml-ai-engine.git`

SSH:

`git clone ssh://git@git.man.poznan.pl:7999/eosc-rs/online-ml-ai-engine.git`

## How to build

After downloading the repository, build the docker container form [Dockerfile](../Dockerfile) using [docker compose file](../docker-compose.yaml): 

`docker-compose build`