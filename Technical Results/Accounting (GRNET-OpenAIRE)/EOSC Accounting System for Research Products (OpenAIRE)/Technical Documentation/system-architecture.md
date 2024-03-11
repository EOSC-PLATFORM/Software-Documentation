# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

The EOSC Research Products Accounting is operated by OpenAIRE's UsageCounts service. The service collects usage activity from events from EOSC Data sources, related to research products, like articles, books, datasets, etc. of the EOSC Research Graph and forms metrics of usage activity of EOSC Data sources, categorizing the data retrieved by number of downloads, number of views, number of repositories and all derivative quantitative open metrics, comprehensively.  

UsageCounts service provides standards for usage data exchange, it complies to the COUNTER  Code of Practice for reliable and comparable reports, it respects user’s privacy via IP anonymization of usage events, it offers global coverage and enables accumulation of usage for the same research products by exploiting the metadata deduplication functionality of the EOSC Research Graph.

## System Architecture

Service  architecture comprises two approaches or workflows:
* A PUSH Workflow which allows server side real-time tracking using platform specific tracking software or using a generic log file parser based on Python that parses web server log files. Usage events are dispatched to Matomo Analytics platform by exploiting the platform’s API.

* A PULL Workflow that collects COUNTER CoP usage statistics reports.

![A pictorial view of the architecture is provided in the figure ](./TiersCollectionWorkflows.png").
