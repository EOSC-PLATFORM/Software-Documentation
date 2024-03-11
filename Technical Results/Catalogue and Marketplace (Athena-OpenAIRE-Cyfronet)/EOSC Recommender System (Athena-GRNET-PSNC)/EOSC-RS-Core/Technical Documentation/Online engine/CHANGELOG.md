# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [UNRELEASED] - UNRELEASED
### Added
### Changed
### Fixed
### Removed

## [1.6.9] - 2023-11-29
### Added
### Changed
- Documentation [@kmartyn]
### Fixed
- Resources are sorted by popularity if no resource exists in the resource database [@kmartyn]
### Removed

## [1.6.8] - 2023-11-14
### Added
- Documentation [@kmartyn]
### Changed
### Fixed
- Fix the returned engine_version when sorting with anonymous user [@kmartyn]
### Removed

## [1.6.7] - 2023-09-08
### Fixed
- Fix candidate generation [@kmartyn]

## [1.6.6] - 2023-08-25
### Changed
- Names of resource types have been unified [@kmartyn]
- Upgrade pydantic [@kmartyn]

## [1.6.5] - 2023-08-02
### Fixed
- Recommendation less than 3 resources [@kmartyn]
- Recommendation for all disliked resources [@kmartyn]

## [1.6.3] - 2023-08-01
### Fixed
- Sorting by popularity resources that not exist [@kmartyn]

## [1.6.2] - 2023-07-28
### Added
- Recommendation based on OARG graph [@kmartyn]

## [1.6.0] - 2023-07-07
### Changed
- Recomendation based on all types of last viewed resources [@kmartyn]

## [1.5.5] - 2023-06-20
### Changed
- aai_uid is not specified in the request if it is "" instead of none [@kmartyn]
### Fixed
- Sorting resources when no candidate is present in the database [@kmartyn]

## [1.5.4] - 2023-06-16
### Fixed
- Fix sorting resources for anonymus user [@kmartyn]

## [1.5.3] - 2023-06-14
### Added
- Include missing resources when sorting  [@kmartyn]
### Changed
- Changed the main folder from app to online_app [@kmartyn]
### Fixed
- Explanations for other research product [@kmartyn]

## [1.5.2] - 2023-05-24
### Added
- Handling user dislike for recommendation based on popularity [@kmartyn]
### Changed
- New scoring model

## [1.5.1] - 2023-05-09
### Fixed
- Resource type text in explanation [@kmartyn]
- Fix order of user resources [@kmartyn]
- Error with popularity recommendations even if the user visit something [@kmartyn]

## [1.5.0] - 2023-04-28
### Added
- Handling user dislike [@kmartyn]
- Add recommendation of similar resources to the resource last saw [@kmartyn]
### Changed
- Model v4 [@witoldt]
- Model load from state_dict [@kmartyn]

## [1.4.1] - 2023-03-17
### Changed
- Changing environment variable DEFAULT_POPULARITY_RECOMENDATION value type from "yes"
 to True/False [@kmartyn]
### Fixed
- Fix explanations text [@kmartyn]
- Fix other research product table mapping [@kmartyn]

## [1.4.0] - 2023-03-10
### Changed
- adapting the requests scheme to NNfinder [@kmartyn]
### Fixed
- Logging messages [@kmartyn]

## [1.3.1] - 2023-02-01
### Added
- LICENSE.txt [@kmartyn]
- Possiblity to choose whether to use a connection pool for PostgreSQL. [@kmartyn]

## [1.3.0] - 2023-01-20
### Added
- Connection pool for communication with PostgreSQL [@kmartyn]
- Connection pool for communication with HBase [@kmartyn]
- Possiblity for enabling re-ranking and prediction next resource [@kmartyn]

### Changed
- Read HBase resource metadata from PostgreSQL [@kmartyn]
- Default number of recommended resources set to 5 [@kmartyn]
### Removed
- supporting MySQL as user, resource and metadata database [@kmartyn]

## [1.2.0] 2022-12-13
### Added
- Re-ranking [@alext]
- Field engine_version to recommendation endpoint [@kmartyn]
- Endpoint /similar_resources [@kmartyn]
- Other research product recommendations [@kmartyn]
- PostgreSQL db backend for users, resources and metadata [@kmartyn]
- Sorting resources by popularity [@kmartyn]
### Changed
- Recomendation score = re-ranking score [@kmartyn]
- Endpoint recommendations now take a single panel_id value and response is a single
recommendation set instead of a list [@kmartyn]
- In recommendations entpoint response panel_name => panel_id [@kmartyn]
- Panel_id now represents only the resource type, while the selection of the method
 of creating recommendations takes place through the engine_version field. [@kmartyn]
- change names of environment variables [@kmartyn]<br>
    PREPROCESOR_DB_HOST -> POSTGRESQL_HOST,<br>
    PREPROCESOR_DB_PORT -> POSTGRESQL_PORT,<br>
    PREPROCESOR_DB_USER -> POSTGRESQL_PREPROCESOR_USER,<br>
    PREPROCESOR_DB_PASSWORD -> POSTGRESQL_PREPROCESOR_PASSWORD,<br>
    PREPROCESOR_DB_DATABASE -> POSTGRESQL_PREPROCESOR_DATABASE,<br>
    PREPROCESOR_DB_SCHEMA -> POSTGRESQL_PREPROCESOR_SCHEMA
### Fixed
- In recommendations response pannel_id -> panel_id and score -> scores

## [1.1.0] 2022-10-20
### Added
- Load lates HBase table names from metadata database [@kmartyn]
- Improve diagnostic endpoint to check dependent modules [@kmartyn]
- Support of AAI_uid [@kmartyn]
### Changed
- The format of the stored data in MySQL [@kmartyn]
### Fixed
- Error message when Postgresql is down or tables are empty [@kmartyn]

## [1.0.0] 2022-09-16
### Added
- MySQL integration [@kmartyn]
- Hbase integration [@kmartyn]
- PostrgeSQL integration [@kmartyn]
- NNFinder integration [@kmartyn]
- Docker integration [@kmartyn]
- Metadata database integration [@kmartyn]
- Embedding prediction network [@witoldt]
- Resource scoring model [@witoldt]
- Recommendations endpoint [@kmartyn]
- Diagnostic endpoint [@kmartyn]
- Candidate generator [@kmartyn]
- Scoring [@kmartyn]
- Recommendations based on the history of orders [@kmartyn]
- Recommendations based on the viewing history [@kmartyn]
- Recommendations based on general popularity [@kmartyn]
- Recommendations based on popularity among users
 with a similar background/interests [@kmartyn]
- Sorting resources [@kmartyn]
- Explantaions [@kmartyn]
- Datasets recommendations [@kmartyn]
- Publications recommendations [@kmartyn]
- Software recommendations [@kmartyn]
- Trainings recommendations [@kmartyn]
- Tests [@kmartyn]
- Default recommendations [@kmartyn]
