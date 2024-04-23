# EOSC Preprocessor service

## Introduction

The "preprocessor" is an ETL (extract, transform, load) component for EOSC Recommender System (RS), deployable as a 
standalone service. The preprocessor is responsible for delivery of data to an AI-based recommendations generator. In 
particular, it performs data ingestion, initial transformation (filtering, cleaning, conversion) and saving. 
Morevoer, it acts as a framework solution for managing computation-intensive tasks which are implemented in form of 
jobs for Apache Spark based cluster. Preprocessing is a first step in the data processing workflow 
implemented by the RS. An OpenAIRE Research Graph is one of many data sources to be processed by the preprocessor.

More about EOSC can be found on https://eosc-portal.eu.


## Features

Here the most important features are listed. For a detailed log of changes please refer to [CHANGELOG.md](CHANGELOG.md)

Intgerations
- Integration with EOSC Marketplace via JMS bus;

User Actions
- Constructing "User Sessions" from "User Actions";
- Support for a new format of User Actions - still the old data structure is supported.
- Generator of User Actions, for the purpose of testing, simulating different types of resources.

OAG processing
- The OAG processing logic supports different preprocessing methods depending on a resource type.

Available interfaces
- REST interface to automate the run of jobs in Hadoop cluster.

Statistics
- Calculation of statistics, necessary for preprocessor's AI modules to prepare recommendations.


## Usage and operations

Basic usage is described in details in [DEVELOPERS_GUIDE.md](DEVELOPERS_GUIDE.md).

How to operate the already running preprocessor + scripts automating daily routines,
is described in [Operations.md](operations/Operations.md)


## Contributing

Please refer to a separate document [CONTRIBUTING.md](CONTRIBUTING.md).


## System Design

For architectural assumptions and implemented concepts please refer to [SYSTEM_DESIGN.md](doc/SYSTEM_DESIGN.md).
