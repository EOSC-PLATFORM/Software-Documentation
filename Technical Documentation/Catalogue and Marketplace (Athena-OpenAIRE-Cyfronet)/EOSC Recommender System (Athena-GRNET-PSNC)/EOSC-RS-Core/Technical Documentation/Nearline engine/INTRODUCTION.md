# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

The Nearline engine is responsible for processing data in a dynamic manner. It can perform almost real
time calculations, but they are not required for serving recommendations to users. In this way, pre-processed
data can be saved in the internal database and further processed in order to prepare user features.
It is also possible to prepare a recommendation using Nearline ML/AI that can be used in the future.
Nearline recommendation algorithms work incrementally using online learning; they do not process the entire data
set but only new information that comes with events. Using data prepared by Nearline, user profiles are created
that will be used by the online module.

The purpose of Nearline engine is processed and stored data from kafka and hdfs to
different databases.

The main functionalities of the module:
* Process different types of events (like user actions) from kafka and store them in the database
* Process resource data from HDFS on spark and store them in the database

The application is built as a microservice with a REST API.

## API
Swagger specification is available at:
* [localhost:8000/docs](http://localhost:8000/docs) for an instance launched locally
* [Wiki page](https://wiki.eoscfuture.eu/pages/viewpage.action?pageId=20743093)

## Limitations

This modul does not support scientific domains.

## Possible Extensions

* **new data type**
  * make sure that preprocessor is able to process new data type
  * in `nearline_app.utils` in `name_map` add new data type
  * add necessary columns for user tables and resource metadata table
* **new source of data**:
  * if new type of action on Kafka is considered, add new topic for KafkaRunner and appropriate logic
  for processing and storing switches
  * otherwise, bigger extension will be needed
* **added new language**:
  * adding additional logic related to the use of different model depending on the detected language
  * using a multilingual model (model change below) (involves the need for more resources)
* **language change**:
  * change a model that supports a different language
* **multilingual**:
  * use a multilingual model (involves the need for more resources)
* **model change**:
  * for processing on spark, new pipeline logic must be added
  * for user action processing, new embedder must be added
