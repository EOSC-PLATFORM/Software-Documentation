# EOSC RS Facade

Module responsible for handling recommendation requests and preparing online recommendations.

## Developer's Guide

Wide range of topics, including local environment set-up, committing, etc., is described in details in 
[DEVELOPERS_GUIDE.md](DEVELOPERS_GUIDE.md)


## Dependencies
- [Online engine](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/online-ml-ai-engine/browse)
- [Marketplace RS](https://github.com/cyfronet-fid/recommender-system)
- `JMS` 
- [Preprocessor](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse) (only diagnostic check)
- [Nearline engine](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse) (only diagnostic check)
- [Nearest neighbor finder](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder/browse) (only diagnostic check)
- [Nearest neighbor finder training module](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder-training-module/browse) (only diagnostic check)
- [Content-based engine](https://github.com/athenarc/EOSCF-ContentBasedRS) 
- [Auto-completion](https://github.com/athenarc/EOSCF-Autocompletion) 
- [Provider insights](https://github.com/athenarc/EOSCF-Provider-Insights) 

## HTTP/REST endpoints
API is available (by default) here: `http://localhost:8001/`

| URL                                                     | HTTP Method | Description                                                                      |
|---------------------------------------------------------|-------------|----------------------------------------------------------------------------------|
| /recommendation                                         | POST        | Endpoint used for getting recommendations                                        |
| /project_completion/recommendation                      | POST        | Endpoint used for getting project completion recommendation                      |
| /similar_services/recommendation                        | POST        | Endpoint used for getting similar services recommendation                        |
| /similar_resources                                      | POST        | Endpoint used for getting similar resources recommendation                       |
| /diag                                                   | GET         | A diagnostic endpoint that sends a `GET /diag` request to the associated modules |
| /v1/statistics/rs/daily                                 | POST        | Endpoint used for getting statistic about daily recommendations                  |
| /v1/statistics/rs/most_recommended/                     | POST        | Endpoint used for getting statistic about total recommendations                  |
| /v1/statistics/rs/most_recommended_along_your_services/ | POST        | Endpoint used for getting statistic about most recommended along your services   |

Swagger specification is available at `http://localhost:8001/docs`
 for an instance launched locally.

### Recommendations endpoint

The recommendations endpoint is called in the scope of the personalized recommendations user story to provide several sets of selected resources to be presented to a given user. Based on the context of the recommendation, the endpoint should return a list of recommended items' IDs obtained from the recommender agent.  Along with recommended resources, the response contains corresponding explanations in long and short formats for each recommendation. Explanations contain details of the reasoning behind the recommendation of a given resource. Those explanations could be used as additional information in the assembled recommendation panel.

Facade delegates request for recommendations regarding Services (for requests with `panel_id` equal to `service` or `v1` or `v2` or `data-sources`) to Marketplace Recommender System and all the rest to Online engine.

This endpoint allows you to sort the resource candidates provided in the candidates' field. To sort candidates, engine_version should end with "sort"

#### Recommendation context

| Field          | Description                                                                                 | Type       | Optional |
|----------------|---------------------------------------------------------------------------------------------|------------|----------|
| user_id        | The unique Marketplace identifier of the logged-in user.                                    | Integer    | yes      |
| unique_id      | The unique identifier of the not logged in user                                             | String     |          |
| aai_uid        | The unique AAI identifier of the logged user.                                               | String     | yes      |
| timestamp      | The exact time of the recommendation request sending                                        | DateTime   |          |
| visit_id       | The unique identifier of the user presence on the recommendation page at the specific time  | String     |          |
| page_id        | The unique identifier of the page with the recommendation panel                             | String     |          |
| panel_id       | The unique identifier of the recommender panel on the page                                  | String     |          |
| candidates     | List of candidates for recommendation                                                       | Candidates |          |
| search_data    | Data specification                                                                          | SearchData |          |
| client_id      | Client ID, possible values:  `marketplace`, `search_service`, `user_dashboard`, `undefined` | String     | yes      |
| engine_version | Engine version                                                                              | String     | yes      |

#### Candidates

| Field       | Description                                                           | Type         | Optional |
|-------------|-----------------------------------------------------------------------|--------------|----------|
| dataset     | List of resource ids of dataset candidates for sorting                | List[String] | yes      |
| publication | List of resource ids of publication candidates for sorting            | List[String] | yes      |
| software    | List of resource ids of software candidates for sorting               | List[String] | yes      |
| other       | List of resource ids of other research product candidates for sorting | List[String] | yes      |
| training    | List of resource ids of training candidates for sorting               | List[String] | yes      |
| service     | List of resource ids of service candidates for sorting                | List[String] | yes      |
| datasource  | List of resource ids of data source candidates for sorting            | List[String] | yes      |

#### SearchData

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



**Possible `panel_id` values**

- `"all"`
- `"services"`
- `"v1"` (services)
- `"v2"` (services)
- `"datasets"`
- `"publications"`
- `"software"`
- `"trainings"`
- `"other_research_product"`
- `"data-sources"`
- `"similar_services"` (only for similar_services endpoint)

**Possible `engine_version` values**

| Value                                       | panel_ids                                                   | Use case                       | Recommendation based on                         | Require candidates |
|---------------------------------------------|-------------------------------------------------------------|--------------------------------|-------------------------------------------------|--------------------|
| `"RL"`, `"NCF"`, `"random"`, `"NCFRanking"` | `"services"` or `"data-sources"`                            | UC-5.1, UC-5.2, UC-5.3, UC-5.4 |                                                 |                    |
| `"content_visit"` or None                   | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.2                          | visited services, and resources form `panel_id` |                    |
| `"content_visit_sort"`                      | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.2                          | visited services, and resources form `panel_id` | yes                |
| `"content_order"`                           | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.1                          | ordered services, and resources form `panel_id` |                    |
| `"content_order_sort"`                      | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.1                          | ordered services, and resources form `panel_id` | yes                |
| `"popularity_visit_day"`                    | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.2, UC1.3                   | most frequent visited resources                 |                    |
| `"popularity_visit_total"`                  | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.2, UC1.3                   | most frequent visited resources                 |                    |
| `"popularity_order_day"`                    | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.1, UC1.3                   | most frequent ordered resources                 |                    |
| `"popularity_order_total"`                  | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.1, UC1.3                   | most frequent ordered resources                 |                    |
| `"popularity_visit_day_sort"`               | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.2, UC1.3, UC6.1            | most frequent visited resources                 | yes                |
| `"popularity_visit_total_sort"`             | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.2, UC1.3, UC6.1            | most frequent visited resources                 | yes                |
| `"popularity_order_day_sort"`               | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.1, UC1.3, UC6.1            | most frequent ordered resources                 | yes                |
| `"popularity_order_total_sort"`             | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.1, UC1.3, UC6.1            | most frequent ordered resources                 | yes                |
| `"collaborative_filtering_visit"`           | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.2, UC1.4                   | visited resources of similar users              |                    |
| `"collaborative_filtering_order"`           | `"datasets"`, `"publications"`, `"software"`, `"trainings"` | UC1.1, UC1.4                   | ordered resources of similar users              |                    |

If the user does not exist, recommendations will be based on popularity.

**Possible `ClientId` values**

- `"marketplace"`
- `"search_service"`
- `"user_dashboard"`
- `"undefined"`


#### Response
| Field              | Description                                   | Type         |
|--------------------|-----------------------------------------------|--------------|
| panel_id           | Name of the recommendation list               | String       |
| recommendations    | List of recommended services' IDs             | List[String] |
| explanations       | List of explanations                          | List[String] |
| explanations_short | List of shortened explanations                | List[String] |
| engine_versions    | The internal engine that made recommendations | List[String] |

#### Response from connected recommendation engines

The API of recommendation systems connected to the RS Facade (Online engine and Marketplace Recommender System) should be exactly the same as above, but in the response, it should include the "score" field which determines the relevance of the resource. This field will be used for aggregation and re-ranking. The values ​​of the "score" field should be in the range [0,1] where 1 means the most relevant resource, and 0 - is the least relevant resource.

RecommendationSet:

| Field              | Description                                                                                            | Type         |
|--------------------|--------------------------------------------------------------------------------------------------------|--------------|
| panel_id           | Name of the recommendation list                                                                        | String       |
| recommendations    | List of recommended services' IDs                                                                      | List[String] |
| explanations       | List of explanations                                                                                   | List[String] |
| explanations_short | List of shortened explanations                                                                         | List[String] |
| scores             | A score of the corresponding resource on the basis of which the choice of recommendation has been made | List[Float]  |
| engine_version     | The internal engine that made recommendations                                                          | String       |



### Project completion endpoint

Based on the project given as input, we recommend services that are frequently combined with the ones existing in the project.

Request body:

| Field      | Description                                        | Type |
|------------|----------------------------------------------------|------|
| project_id | The id of the project currently viewed by the user | int  |
| num        | Number of recommendations we want to be returned   | int  |

The response is a list of dictionaries with fields:

| Field      | Description                                          | Type  |
|------------|------------------------------------------------------|-------|
| service_id | Service Id is the id of the recommended service      | int   |
| score      | The score is the support from the frequent item sets | float |

### Similar services endpoint
Based on the service given as input, we recommend similar services utilizing both textual and metadata attributes.

Request body:

| Field      | Description                                              | Type     | Optional |
|------------|----------------------------------------------------------|----------|----------|
| user_id    | The unique Marketplace identifier of the logged-in user. | Integer  | yes      |
| unique_id  | The unique identifier of the not logged in user          | String   | no       |
| aai_uid    | The unique AAI identifier of the logged user.            | String   | yes      |
| timestamp  | The exact time of the recommendation request sending     | DateTime | no       |
| service_id | The id of the service currently viewed by the user       | int      | no       |
| num        | Number of recommendations we want to be returned         | int      | no       |

RecommendationSet is sent in response.

### Similar resources endpoint

Endpoint suggesting similar OARG resources and Knowledge Hub (datasets, publications, software, training materials, other_research_product) for the given id of the resource.

Request body:

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
| resource_type  | Resource type one of: "datasets", "publications", "software", "trainings", "other_research_product" | String   |          |

RecommendationSet is sent in response.

### Endpoint diag

Returns UP status if the module is running.
Additionally it checks whether dependent modules communicate correctly,
 the following are checked:
- `Online engine` - Send request to endpoint `/diag`.
- `Marketplace RS` - Send request to endpoint `/health`.
- `Content-based engine` - Send request to endpoint `/v1/health`.
- `Auto-completion` - Send request to endpoint `/v1/health`.
- `JMS` - checks if a connection can be made via stomp.
- `Preprocessor` - Send request to endpoint `/actuator/health`.
- `Nearline engine` - Send request to endpoint `/diag`.
- `Nearest neighbor finder` - Send request to endpoint `/diag`.
- `Nearest neighbor finder training module` - Send request to endpoint `/diag`.
- `Provider insights` - Send request to endpoint `/v1/health`.

In the default setting, this endpoint does not display the details of the
queried modules (fields nested in json).
In order to see the details of these modules: `GET /diag?details=true`

## Possible exceptions

| Name               | HTTP status code | HTTP status     | Description                          |
|--------------------|------------------|-----------------|--------------------------------------|
| UnspecifiedProblem | 500              | Internal Error  | unknown error happened               |
| TimeoutException   | 408              | Request Timeout | Timeout when connected to remote API |
| ValidationError    | 400              | Bad Request     | Invalid response from remote api     |


## JMS message

In order to calculate the quality of recommendations and to train models used in recommendation engines, RS-Facade logs requests for recommendations along with the answers. A message containing the complete request and response is sent to Databus. The exact scheme of sent messages is presented in the tables below:

| Field               | Description                       | Type                  |
|---------------------|-----------------------------------|-----------------------|
| context             | Recommendation context            | RecommendationContext |
| panel_id            | Name of the recommendation lists  | String                |
| recommendations     | List of recommended services' IDs | List[String]          |
| recommender_systems | List of recommendation systems    | List[String]          |
| sources             | List of sources                   | List[Source]          |

#### Source

| Field              | Description                                   | Type         |
|--------------------|-----------------------------------------------|--------------|
| engine_version     | The internal engine that made recommendations | String       |
| panel_id           | Name of the recommendation list               | String       |
| recommendations    | List of recommended services' IDs             | List[String] |
| recommender_system | Name of the recommendation system             | String       |

## Changelog
For a detailed log of changes please refer to [CHANGELOG.md](CHANGELOG.md)