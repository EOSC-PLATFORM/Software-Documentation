# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction
The RS Facade application uses only environmental variables for control its behaviour.
We provide a detailed description of the configuration process below.

## Configuration Overview
configuration can be provided by setting the appropriate environment variables on the system 
or through an `.env` file placed in the root directory of the project.
`.env` file should never be stored in the repository.

## Environmental Variables

The following environment variables must be set to run the module:

| <b>Variable name</b>                        | Description                                                                                                                   | Default value              |
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| ONLINE_ENGINE_URL                           | URL to the Online ML/AI Engine                                                                                                | `http://127.0.0.1:8001`    |
| CYFRONET_RS_URL                             | URL to Marketplace RS                                                                                                         | `http://127.0.0.1:8001`    |
| AUTO_COMPLETION_URL                         | URL to Auto-completion                                                                                                        | `http://127.0.0.1:8002`    |
| CONTENT_BASED_ENGINE_URL                    | URL to Content-based engine                                                                                                   | `http://127.0.0.1:8002`    |
| PREPROCESSOR_URL                            | URL to Preprocessor                                                                                                           | `http://127.0.0.1:8001`    |
| NEARLINE_ENGINE_URL                         | URL to Nearline engine                                                                                                        | `http://127.0.0.1:8001`    |
| NEAREST_NEIGHBOR_FINDER_URL                 | URL to Nearest neighbor finder                                                                                                | `http://127.0.0.1:8001`    |
| NEAREST_NEIGHBOR_FINDER_TRAINING_MODULE_URL | URL to Nearest neighbor finder training module                                                                                | `http://127.0.0.1:8001`    |
| PROVIDER_INSIGHTS_URL                       | URL to Provider Insights                                                                                                      | `http://127.0.0.1:8001`    |
| JMS_URL                                     | URL to JMS                                                                                                                    | 127.0.0.1                  |
| JMS_PORT                                    | Port of JMS                                                                                                                   | 8001                       |
| JMS_USER                                    | JMS user                                                                                                                      | admin                      |
| JMS_PASSWORD                                | JMS user password                                                                                                             | admin                      |
| SSL                                         | Boolean type variable that determines the use of SSL <br>when communicating with JMS                                          | False                      |
| LOG_LEVEL                                   | Log level                                                                                                                     | INFO                       |
| NUMBER_OF_RECOMMENDATION                    | The number of recommendations returned <br>for the panel_id = `"all"`                                                         | 10                         |
| AGGREGATION_TYPE                            | The type of aggregation to be performed for `"all"` panel_id.  <br>Possible values: `top`, `sort`                             | top                        |
| EXTERNAL_API_TIMEOUT                        | How long to wait for external API response                                                                                    | 2                          |
| EXTERNAL_API_TIMEOUT_DIAG                   | How long to wait for external API response on diagnostic endpoint                                                             | 10                         |
| JMS_RECOMMENDATION_TOPIC                    | JMS recommendation topic                                                                                                      | `"/topic/recommendations"` |
| WORKERS_PER_CORE                            | Number of fastapi workers per core                                                                                            | `4`                        |
| WEB_CONCURRENCY                             | Override the automatic definition of number of fastapi workers. Independent of how many CPU cores are available in the server |                            |

## Security Considerations
The .env file should never be committed to the repository. It should be created manually on the server.


