# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

- Purpose of the document and intended audience.
- Overview of the operational aspects covered in the documentation.

# Connectors

`argo-connectors` is bundle of data fetch components that gather insights in
various e-infrastructures for the ARGO monitoring purposes.

It's primary interest is hierarchical topology representation of
e-infrastructures stored in Configuration Management Databases (CMDBs) such as
the EOSC Service Registry or GOCDB, but also flat topologies defined in simple CSV
or JSON formats are supported. Topology lists endpoints with unique addresses
that comprise services specific to each e-infrastructure that needs to be
inspected. They can be simple set of webpages with HTTP service running or some
more sophisticated with peculiar services that are part of e-infrastructure
portfolio. Alongside the unique address is usually contact information attached
of endpoint owner whom will be receiving alerts in case of problems. For
hierarhical topology, endpoints are organized in logical groups specific to
particular e-infrastructure that reflect its internal organization; for EOSC
there are providers and resources.

Next to topology, `argo-connectors` also gather weights and downtimes data.
Weights are Computation Power figures fetched from VAPOR service. Downtimes
data are time period scheduled for each endpoint under maintenance that will
not be taken into account during A/R calculation.

All collected data is transformed in appropriate format and pushed on daily
basis on the corresponding API method of ARGO-WEB-API service.

# POEM

## Description

ARGO POEM service is multi-tenant aware web application used for management of
tenants and corresponding resources needed to bootstrap their monitoring. It's
register of services, repositories, packages and related probes, metric
configurations and metric profiles that instruct ARGO monitoring instances what
kind of probes/tests to execute for given tenant. Additionally it manages
grouping of results and defines configuration of reports that ARGO compute
engine will generate for each tenant. All of that in multi-tenant manner where
single instance of web application can cater for multiple tenants and their
monitoring needs. Users are allowed to login via SAML2 based identity providers
that can be integrated and configured.

## Features

Here is a complete list of features:
* handling of RPM repositories with probes
* versioning of packages and probes
* mapping of probes and metrics with predefined metric configuration templates
* mapping of metrics and service types and grouping of them into metric profiles
* handling of aggregation profiles; definition of service type groups and
  logical operators within and between them so to define the status result
  deduction rules
* definition of availability and reliability reports and its parameters;
  topology sources, filters and applying of different profiles to fully
  accommodate generation of reports
* flexible session and token protected REST API
* use of ARGO WEB-API as a centralized store for various resources
* PostgreSQL with schemas for enabling of multi-tenancy
* integration with SAML identity providers

## Design

ARGO POEM is SPA (single page) web application using Django framework as
backend and ReactJS UI library as a frontend component. Client's browser loads
in bundle code that jointly represents whole frontend component that packs
together Javascript, CSS, fonts, icons and everything else needed to properly
render the UI. Frontend component is glued with backend Django framework as its
staticfile that loads bundle in a single Django template presented to client.
Keeping frontend close to backend allows exploiting of some nice Django
packages that primarily deal with API methods, user authentication and tenant
database handling. Frontend talks to backend over session protected REST API
methods for resources that should be stored in local database. For the other
part of the resources that should be kept on token protected ARGO WEB-API, HTTP
requests are triggered directly from frontend.

Web application is served with Apache web server and uses PostgreSQL as
database storage.

### List of packages used

Backend: `Django`, `dj-rest-auth`, `django-tenants`, `django-webpack-loader`, `djangorestframework`, `djangorestframework-api-key`, `djangosaml2`, `psycopg2-binary`

Frontend: `ReactJS`, `formik`, `react-hook-form`, `react-autosuggest`, `react-diff-viewer`, `react-dom`, `react-fontawesome`, `react-helmet`, `react-notifications`, `react-popup`, `react-router`, `react-select`, `react-table`, `reactstrap`, `webpack`, `yup`
