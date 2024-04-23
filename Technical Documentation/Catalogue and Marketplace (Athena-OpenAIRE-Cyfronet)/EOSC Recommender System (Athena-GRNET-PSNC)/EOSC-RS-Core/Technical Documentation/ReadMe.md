# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >


# Recommender System
==================

This code repository contains stuff that spans over multiple microservices that together constitute a Recommender System.

## Installation guide

### RS-core system
To install the whole RS-core system, follow these steps:

1. Set up and run:
- PostgreSQL database with 2 databases: resource_db and preproc_db
- HBase database (optional)
- Kafka
- Hadoop (HDFS + Spark)
- JMS

2. Deploy RS-core components:
- [Preprocesor](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse/doc/DEPLOYMENT.md)
- [Nearline engine](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse/docs/DEPLOYMENT.md)
- [Nearest neighbor finder](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder/browse/docs/DEPLOYMENT.md)
- [Nearest neighbor finder training module](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder-training-module/browse/docs/DEPLOYMENT.md)
- [Online engine](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/online-ml-ai-engine/browse/docs/DEPLOYMENT.md)
- [RS Facade](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/rs-facade/browse/docs/DEPLOYMENT.md)

The order in which the modules are run does not matter.

### RS-extensions
Deploy RS-extensions components:
- [Content Based RS](https://github.com/athenarc/EOSCF-ContentBasedRS/blob/master/docs/deployment.md)
- [Provider Autocompletion](https://github.com/athenarc/EOSCF-Autocompletion/blob/master/docs/deployment.md)
- [Provider Insights](https://github.com/athenarc/EOSCF-Provider-Insights/blob/master/docs/deployment.md)

### Marketplace RS
Deploy Marketplace RS components: 
- [Marketplace RS](https://github.com/cyfronet-fid/recommender-system)



## Load new data to system

To load new data into the system follow the instructions in the [LOAD_NEW_DATA.md](LOAD_NEW_DATA.md)

## Diagrams

[Go to monitoring diagram](deployment_diagram/out/deployment_monitoring.png)

[Go to deployment diagram](deployment_diagram/out/deployment_current.png)

[Go to module dependencies diagram](deployment_diagram/out/module_dependencies.png)

## Scaling performance
To monitor the system's resource consumption, for load testing, or to scale the recommendation system go to [SCALING-PERFORMANCE.md](SCALING-PERFORMANCE.md)
