# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Installation

The UsageCounts feature complies with the project COUNTER standards, ensuring adherence to its technical specifications and recommended open source technologies. To set up and launch a similar system, please consult the documentation provided on https://www.projectcounter.org/. We have opted not to reproduce the documentation here to ensure it remains current and accurate.


### On the Repository's side

There are four steps that need to be performed by Data Source managers in order to configure and use the EOSC Accounting for Research Products Service. These steps require the co-operation of the datasouce and given below:


* Download the tracking code for the repository platform.
* Configure the tracking code according to the instructions. The code and the instructions are maintained on Github:
  * as a patch for various versions of [DSpace](https://github.com/openaire/OpenAIRE-Piwik-DSpace)
  * as an [Eprints](https://github.com/openaire/EPrints-OAPiwik) plugin for version 3
  * as a python script in the form of a [Generic Matomo Tracker](https://github.com/openaire/Generic-Matomo-Tracker)
* Deploy the tracking code in your repository platform.

## On the OpenAIRE's side

OpenAIRE's usage statistics staff will validate the installation of the tracking code and inform the repository manager accordingly.


## Retrieving the reports

A variety of reports generated via OpenAIRE UsageCounts Service are available via a SUSHI-Lite Endpoint. The reports comply with [COUNTER CoP Release 4](https://usagecounts.openaire.eu/resources#apis)
