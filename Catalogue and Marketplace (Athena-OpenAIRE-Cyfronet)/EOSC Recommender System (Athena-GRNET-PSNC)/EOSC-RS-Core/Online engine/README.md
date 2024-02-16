# EOSC Online Engine
Module responsible for handling recommendation requests and preparing online recommendations.
For more details, see [INTRODUCTION.md](docs/INTRODUCTION.md), [SYSTEM-ARCHITECTURE.md](docs/SYSTEM-ARCHITECTURE.md) and [INDEX.md](/docs/INDEX.md).

## Prequsisties
- Python 3.8
- All python requirements are in [requirements.txt](requirements.txt)


## Dependencies
- [Nearest neighbor finder](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder/browse)
- Postgresql
- Hbase

## Configuration
Configuring the application involves setting environment variables. For more details, see [CONFIGURATION.md](docs/CONFIGURATION.md).


## Building and deployment
To build an application see [BUILDING.md](docs/BUILDING.md) and for deploy [DEPLOYMENT.md](docs/DEPLOYMENT.md)


## API
The API is in the form of HTTP/REST endpoints:

|                     URL                       | HTTP Method |                        Description                         |
| :-------------------------------------------: | :---------: | :--------------------------------------------------------: |
| /recommendation                               | POST        | Endpoint used for getting recommendations                  |
| /similar_resources                            | POST        | Endpoint used for getting similar resources                |
| /diag                                         | GET         | Diagnostic endpoint                                        |

Swagger specification is available at: 
* [localhost:8001/docs](http://localhost:8001/docs) for an instance launched locally 
* [EOSC Online Engine API](swagger.json)

### Recommendations endpoint

The recommendations endpoint is called in the scope of the personalized recommendations user story to provide set of selected resources to be presented to a given user. Based on the context of the recommendation, the endpoint should return a list of recommended items' IDs obtained from the recommender agent. Along with recommended resources, the response contains corresponding explanations in long and short formats for each recommendation. Explanations contain details of the reasoning behind the recommendation of a given resource. Those explanations could be used as additional information in the assembled recommendation panel.

#### Request: Recommendation context

| Field          | Description                                                                                                                     | Type         | Optional |
|----------------|---------------------------------------------------------------------------------------------------------------------------------|--------------|----------|
| user_id        | The unique Marketplace identifier of the logged-in user.                                                                        | Integer      | yes      |
| unique_id      | The unique identifier of the not logged in user                                                                                 | String       |          |
| aai_uid        | The unique AAI identifier of the logged user.                                                                                   | String       | yes      |
| timestamp      | The exact time of the recommendation request sending                                                                            | DateTime     |          |
| visit_id       | The unique identifier of the user presence on the recommendation page at the specific time                                      | String       |          |
| page_id        | The unique identifier of the page with the recommendation panel                                                                 | String       |          |
| panel_id       | The unique identifier of the recommender panel on the page                                                                      | String       |          |
| candidates     | List of candidates for recommendation                                                                                           | List[String] |          |
| search_data    | Data specification                                                                                                              | SearchData   |          |
| client_id      | Client ID                                                                                                                       | String       | yes      |
| engine_version | Engine version                                                                                                                  | String       | yes      |


**Possible panel_id values**
- `"datasets"`
- `"publications"`
- `"software"`
- `"trainings"`
- `"other_research_product"`

**Possible engine_version values**

| Value | Use case| Recommendation based on | Require candidates |
|---|---|---|---|
| `"content_visit"` or None | UC1.2 | visited services, and resources form `panel_id` |  |
| `"content_visit_sort"` | UC1.2, UC6.1 | visited services and resources form `panel_id`  | yes |
| `"content_order"` | UC1.1 | ordered services and resources form `panel_id`  |  |
| `"content_order_sort"` | UC1.1, UC6.1 | ordered services and resources form `panel_id` | yes |
| `"popularity_visit_day"` | UC1.2, UC1.3 | most frequent visited resources |  |
| `"popularity_visit_total"` | UC1.2, UC1.3 | most frequent visited resources |  |
| `"popularity_order_day"` | UC1.1, UC1.3 | most frequent ordered resources |  |
| `"popularity_order_total"` | UC1.1, UC1.3 | most frequent ordered resources |  |
| `"popularity_visit_day_sort"` | UC1.2, UC1.3, UC6.1 | most frequent visited resources | yes |
| `"popularity_visit_total_sort"` | UC1.2, UC1.3, UC6.1 | most frequent visited resources | yes |
| `"popularity_order_day_sort"` | UC1.1, UC1.3, UC6.1 | most frequent ordered resources | yes |
| `"popularity_order_total_sort"` | UC1.1, UC1.3, UC6.1 | most frequent ordered resources | yes |
| `"collaborative_filtering_visit"` | UC1.2, UC1.4 | visited resources of similar users |  |
| `"collaborative_filtering_order"` | UC1.1, UC1.4 | ordered resources of similar users |  |

If the user does not exist, recommendations will be based on popularity.

**Possible ClientId values**
- `"marketplace"`
- `"search_service"`
- `"user_dashboard"`
- `"undefined"`

**Possible exceptions**

|              Name              |             HTTP status code        |  Description|
|---|---|---|
| UnspecifiedProblem | 500  | Unknown error happened |
| RemoteApiUnavailableError | 503  | Remote component error |
| EmptyCandidateList             | 400  | Candidate list to sort is empty. It can occur if panel_id contains `sort` |


#### SearchData


Currently no information about the user search context in `SearchData` is provided along with the request therefore, they are not used in the process of making recommendations.

| Field                       | Description       | Type         | Optional |
|-----------------------------|-------------------|--------------|----------|
| q                           | Search phrase     | String       | yes      |
| category_id                 | Category          | List[String] | yes      |
| geographical_availabilities | Countries         | List[String] | yes      |
| order_type                  | Order type        | String       | yes      |
| providers                   | Provider          | List[String] | yes      |
| rating                      | Rating            | String       | yes      |
| related_platforms           | Related platforms | List[String] | yes      |
| scientific_domains          | Scientific domain | List[String] | yes      |
| sort                        | Sort filter       | String       | yes      |
| target_users                | Target users      | List[String] | yes      |
| engine_version              | Engine version    | String       | yes      |


#### Response: RecommendationSet 


| Field              | Description                                                                                            | Type         | Optional |
|--------------------|--------------------------------------------------------------------------------------------------------|--------------|----------|
| panel_id           | Name of the recommendation list                                                                        | String       | yes      |
| recommendations    | List of recommended services' IDs                                                                      | List[String] | yes      |
| explanations       | List of explanations                                                                                   | List[String] | yes      |
| explanations_short | List of shortened explanations                                                                         | List[String] | yes      |
| scores             | A score of the corresponding resource on the basis of which the choice of recommendation has been made | List[Float]  | yes      |
| engine_version     | The internal engine that made recommendations                                                          | String       | yes      |

### Similar resources endpoint

Endpoint suggesting similar OARG resources and Knowledge Hub (datasets, publications, software, training materials, other_research_product) for the given id of the resource.

RecommendationSet is sent in response.

#### Request


| Field          | Description                                                                                         | Type     | Optional |
|----------------|-----------------------------------------------------------------------------------------------------|----------|----------|
| user_id        | The unique Marketplace identifier of the logged-in user.                                            | Integer  | yes      |
| unique_id      | The unique identifier of the not logged in user                                                     | String   |          |
| aai_uid        | The unique AAI identifier of the logged user.                                                       | String   | yes      |
| timestamp      | The exact time of the recommendation request sending                                                | DateTime |          |
| page_id        | The unique identifier of the page with the recommendation panel                                     | String   |          |
| panel_id       | The unique identifier of the recommender panel on the page                                          | String   |          |
| client_id      | Client ID, possible values:  marketplace, search_service, user_dashboard, undefined                 | String   | yes      |
| engine_version | Engine version                                                                                      | String   | yes      |
| resource_id    | Resource unique identifier                                                                          | String   |          |
| resource_type  | Resource type one of: `datasets`, `publications`, `software`, `trainings`, `other_research_product` | String   |          |


### Diagnostic endpoint

Endpoint to check the module's operating status and the status of connections to other dependent modules.


| Field name     | Value if it works                                                                                                                                                                                                                                                                                                                                           | Value on error                                                                                                                                                              | URL                                | Description                                                                                                                                                                                                                                  |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| status         | UP                                                                                                                                                                                                                                                                                                                                                          | DOWN                                                                                                                                                                        |                                    | The status tells you if the component is running                                                                                                                                                                                             |
| version        | 1.5.X                                                                                                                                                                                                                                                                                                                                                       |                                                                                                                                                                             |                                    | The version of the module.                                                                                                                                                                                                                   |
| metadata_db    | { "status": "UP", "database type": "PostgreSQL", "tables": { "metadata_bin": "UP" } },                                                                                                                                                                                                                                                                      | {         "status": "DOWN",         "database type": "PostgreSQL",         "error": "Error while connecting to PostgreSQL:{error}"     }                                    | PREPROCESOR_DB_HOST                | Checking the connection to the Metadata database (PostgreSQL) and checking if there is a table with metadata in this database.                                                                                                               |
| resource_db    | { "status": "UP", "database type": "PostgreSQL", "tables": { "datasets_bin": "UP", "services_bin": "UP", "publications_bin": "UP", "software_bin": "UP", "otherresearchproduct_bin": "UP", "trainings_bin": "UP" } }                                                                                                                                        | {         "status": "DOWN",         "database type": "PostgreSQL",         "error": "Error while connecting to PostgreSQL:{error}"     }                                    | PREPROCESOR_DB_HOSTor  HBASE_HOST  | Checking the connection to the Resource database (PostgreSQL or Hbase depending on RESOURCE_DB) and checking if there are all tables specified in the  Metadata database.                                                                    |
| user_db        | "user_db": { "status": "UP", "database type": "HBase", "tables": { "anon_users": "UP", "logged_users": "UP" } },                                                                                                                                                                                                                                            | {         "status": "DOWN",         "database type": "HBase",         "error": "Error while connecting to Hbase: {error}" }                                                 | MYSQL_RESOURCE_HOST or  HBASE_HOST | Checking the connection to the Users database (MySQL or Hbase depending on USER_DB) and checking if there are all tables specified in the  Metadata database.                                                                                |
| preprocesor_db | { "status": "UP", "database type": "PostgreSQL", "tables": { "stats_day_table_dataset": "UP", "stats_total_table_dataset": "UP", "stats_day_table_publication": "UP", "stats_total_table_publication": "UP", "stats_day_table_software": "UP", "stats_total_table_software": "UP", "stats_day_table_training": "UP", "stats_total_table_training": "UP" } } | {         "status": "DOWN",         "database type": "PostgreSQL",         "error": [             "OperationalError while connecting to PostgreSQL:{error}"         ]     } | PREPROCESOR_DB_HOST                | Checking the connection to the Preprocessor database (PostgreSQL) and checking if all needed tables exist in this database and checking if these tables are empty. If the tables exist but are empty, their status is:  "Exist but is empty" |
| NNFinder       | { "status": "UP", ... }                                                                                                                                                                                                                                                                                                                                     | {         "status": "DOWN",         "error": "Error while connecting to NNFinder: {error}" }                                                                                | NN_FINDER_URL/diag                 | Checking the connection to the Nearest neighbor finder and its status.                                                                                                                                                                       |