# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [UNRELEASED] - UNRELEASED
### Added
### Changed
### Fixed
### Removed

## [1.5.2] - 2024-01-02
### Added
### Changed
 - Adding /v1 to endpoints similar_services and project_completion
### Fixed
### Removed

## [1.5.1] - 2023-12-05
### Added
- Added unique_id, aai_uid and timestamp fields to similar services context [@kmartyn]
### Changed
### Fixed
### Removed

## [1.5.0] - 2023-12-05
### Added
### Changed
- Response from similar services to RecommendationSet [@kmartyn]
### Fixed
- Transferring candidates of data-sources for sorting [@kmartyn]
### Removed

## [1.4.7] - 2023-11-29
### Added
### Changed
- Rename and split ATHENA_RS_URL to CONTENT_BASED_ENGINE_URL and AUTO_COMPLETION_URL [@kmartyn]
### Fixed
### Removed

## [1.4.6] - 2023-11-15
### Added
- Documentation [@kmartyn]
### Changed
### Fixed
- Fix input type from marketplace RS [@kmartyn]
### Removed

## [1.4.5] - 2023-10-20
### Added
### Changed
### Fixed
- Refactor [@kmartyn]
- Set default values to None [@kmartyn]
### Removed

## [1.4.4] - 2023-08-25
### Added
### Changed
- Add delay in JMS closing  [@kmartyn]
- Upgrade pydantic [@kmartyn]
### Fixed
### Removed

## [1.4.3] - 2023-07-28
### Added
### Changed
### Fixed
- Improve error handling when connecting to JMS [@kmartyn]
### Removed

## [1.4.2] - 2023-07-12
### Added
### Changed
- Changed the main folder from app to facade_app [@kmartyn]
### Fixed
- Adding more exception handling to the JMS connection [@kmartyn]
### Removed

## [1.4.1] - 2023-05-31
### Added
### Changed
### Fixed
- Closing connections to JMS when querying the diagnostic endpoint [@kmartyn]
### Removed

## [1.4.0] - 2023-04-28
### Added
- Endpoint diag check Preprocessor, Nearline engine, Nearest neighbor finder,
 Nearest neighbor finder trainig module. [@kmartyn]
 - Add proxy to Provider Insights [@kmartyn]
### Changed
- Endpoint diag allows to get the details of other modules [@kmartyn]
### Fixed
### Removed

## [1.3.1] - 2023-03-29
### Added
### Changed
### Fixed
- Fix empty engine_version [@kmartyn]
- Fix json message to JMS [@tlysiak]
### Removed

## [1.3.0] - 2023-03-17
### Added
- Unittest for sort resources [@kmartyn]
### Changed
- Changing candidate resource handling for recommendation endpoint [@kmartyn]
- Split file recommendation to recommendation and engine_recommendation [@kmartyn]
### Fixed
### Removed
- Connection to kafka [@kmartyn]

## [1.2.6] - 2023-03-10
### Added
### Changed
- Change of the diagnostic endpoint that is queried for Marketplace RS [@kmartyn]
- Change API schema for candidates [@kmartyn]
### Fixed
### Removed

## [1.2.5] - 2023-03-01
### Added
### Changed
### Fixed
- Close JMS connection on failure [@kmartyn]
### Removed

## [1.2.4] - 2023-01-25
### Added
- Add the possibility of using SSL when communicating with JMS [@tlysiak]
### Changed
### Fixed
### Removed

## [1.2.3] - 2023-01-18
### Added
- Add possibility to change JMS topic [@kmartyn]
### Changed
### Fixed
### Removed

## [1.2.2] - 2023-01-18
### Added
- Add support for panel_id = data-sources [@kmartyn]
### Changed
### Fixed
### Removed

## [1.2.1] - 2022-12-21
### Added
### Changed
### Fixed
- Sending JMS recommendation message from Athena RS [@kmartyn]
### Removed

## [1.2.0] 2022-12-14
### Added
- Field engine_version to recommendation endpoint [@kmartyn]
- Validation panel_id values [@kmartyn]
- Other research product recommendations [@kmartyn]
- Added field type mapping from Marketplace RS (string->int) [@kmartyn]
- Added sending event with recommendations to JMS [@tlysiak]
- Added sending event with recommendations to Kafka [@tlysiak]
- Endpoint /similar_resources [@kmartyn]
### Changed
- Endpoint recommendations now take a single panel_id value and response is a single
 recommendation set instead of a list [@kmartyn]
- In recommendations entpoint response panel_name => panel_id [@kmartyn]
### Fixed
### Removed

## [1.1.0] 2022-10-20
### Added
- Recommendations for all types of resources simultaneously [@kmartyn]
- Aggregation by sort by highest score [@kmartyn]
- Aggregation by top resource from each type [@kmartyn]
### Changed
- Change to asynchronous requests for recommendations [@kmartyn]
- Improve diagnostic endpoint to check dependent modules [@kmartyn]
- Support of AAI_uid [@kmartyn]
- Panel_id now represents only the resource type, while the selection of the method
 of creating recommendations takes place through the engine_version field. [@kmartyn]
### Fixed
### Removed

## [1.0.0] 2022-09-16
### Added
- Proxy to Online Engine [@tlysiak]
- Proxy to Marketplace RS [@tlysiak]
- Proxy to Athena RS [@kmartyn]
- Docker integration [@tlysiak]
- Project completion endpoint [@kmartyn]
- Recommendations endpoint [@tlysiak]
- Similar services endpoint [@kmartyn]
- Diagnostic endpoint [@kmartyn]
- Recommendations based on the history of orders [@kmartyn]
- Recommendations based on the viewing history [@kmartyn]
- Recommendations based on general popularity [@kmartyn]
- Recommendations based on popularity among users with a similar
 background/interests [@kmartyn]
- Sorting resources [@kmartyn]
- Datasets recommendations [@kmartyn]
- Publications recommendations [@kmartyn]
- Software recommendations [@kmartyn]
- Trainings recommendations [@kmartyn]
- Services recommendations [@kmartyn]