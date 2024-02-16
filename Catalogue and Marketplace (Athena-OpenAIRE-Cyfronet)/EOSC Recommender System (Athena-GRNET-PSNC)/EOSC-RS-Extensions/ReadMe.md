Licence
<! --- SPDX-License-Identifier: CC-BY-4.0 -- >

The RS-Extensions provide extra functionality to the EOSC Portal for both the providers and the users of the marketplace. The extensions are built as microservices with REST APIs.

This document will provide a brief overview of the functionalities of the RS-Extensions and link to the documentation folder of each extension.

These functionalities are:

* Content Based RS for the users of the marketplace
* Provider Autocompletion for the providers
* Provider Insights for the providers

## Content Based RS
*documented in `Content Based RS/` folder*

The Content-Based RS has the goal of generating recommendations of similar services (and only services) that a user of the marketplace is currently viewing.

It is deployed in the marketplace infrastructure since it needs access to the database (Mongo) of the marketplace RS and is connected to the frontend through the RS facade.

## Provider Autocompletion
*documented in `Provider Autocompletion/` folder*

The provider autocompletion service has the goal of generating autocompletion suggestions for categorical attributes of an onboarding service. To perform the autocompletion uses the text attributes of the service (i.e. tagline, description) that have already been filled.

The service is currently deployed in the providers infrastructure and consumed by the provider's portal.


## Provider Insights
*documented in `Provider Insights/` folder*

The provider insights service has the goal of providing statistics to the providers about how well each of their services is performing on the recommender system.

The service is currently deployed in the marketplace infrastructure and consumed by the provider's portal.
The communication between the two is done through a public API that requires authentication.
