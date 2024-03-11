# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## System Architecture

- Description of the software/application architecture.
- Components, modules, and their interactions.

Below, we present an overview of the EOSC Marketplace APIs in scope of interoperability patterns regarding order management. Users are presented with a consistent EOSC Marketplace user interface, while communities, providers and operations team can leverage the APIs to achieve high interoperability level and provide value to the users in a way they see fit.


Integrators (providers and communities) can choose from a range of integration levels, adding flexibility.

In a minimal setup, a provider can use Marketplace UI to configure their offerings and leverage SOMBO for order management, avoiding any implementation and integration cost whatsoever.

On the other hand, one can choose to use an in-house system, that fully integrates with EOSC Marketplace APIs both for offering and order management. Existing community systems can be extended this way, exposing the communities to EOSC users while maintaining the same set of tools for operations.

##Offering

Exposes functions that are necessary to manage offerings, including their technical parameters and ordering configuration. Its OpenAPI Specification is available here.

##Ordering

It is an API that enables integration with the ordering process. External Order Management Systems (OMSes) can use it to keep order processing on their side, but still providing users with a consistent order workflow and support.

