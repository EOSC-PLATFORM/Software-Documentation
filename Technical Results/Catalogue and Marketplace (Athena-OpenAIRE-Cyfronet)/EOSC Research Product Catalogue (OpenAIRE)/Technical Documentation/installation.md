# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Installation

### Software repositories

Knowledge Graph – Metadata Aggregation system (CNR)
Web application accessible only to the OpenAIRE content aggregation team for the management of the processes for the collection and harmonisation of the bibliographic records.
D-Net software toolkit version 5.0.17-PROD, AGPL 3.0, http://svn-public.driver.research-infrastructures.eu/driver/dnet45/webapps/dnet-container-openaireplus/trunk

Knowledge Graph – File Crawling/ Aggregation system (ARC and OpenAIRE)
Web application accessible only to the OpenAIRE content aggregation team for the management of the processes for the collection of the fulltext of publications
PDF aggregation controller, version 2.6, Apache 2.0, https://code-repo.d4science.org/lsmyrnaios/UrlsController
PDF aggregation worker, version 2.6, Apache 2.0, https://code-repo.d4science.org/lsmyrnaios/UrlsWorker

Knowledge Graph – Information Inference System (ARC, ICM, and OpenAIRE)
IIS is a flexible data processing system for handling big data based on Apache Hadoop technologies. Main goal of the IIS is to provide data/text mining functionality for the OpenAIRE system. In practice, IIS defines data processing workflows that connect various mining modules
Apache 2.0, https://github.com/openaire/iis

Knowledge Graph – Deduplication System (CNR & OpenAIRE)
Software component for the duplicate identification and resolution within the Knowledge Graph of: research products, data sources, and organisations. https://graph.openaire.eu/docs/graph-production-workflow/deduplication
dnet-dedup-openaire module within the dnet-hadoop project, version 1.2.5, AGPL 3.0, https://code-repo.d4science.org/D-Net/dnet-hadoop

Knowledge Graph – Statistics (ARC)
Software component for the calculation of statistics over the Knowledge Graph contents
dnet-stats-update, dnet-stats-promote modules within the dnet-hadoop project, version 1.2.5, AGPL 3.0, https://code-repo.d4science.org/D-Net/dnet-hadoop

Knowledge Graph – Data/Graph Provision System (CNR)
Software component for the orchestration of the set of processes that implement the Knowledge Graph processing pipeline. https://graph.openaire.eu/docs/graph-production-workflow
dhp-workflows module within the dnet-hadoop project, version 1.2.5, AGPL 3.0, https://code-repo.d4science.org/D-Net/dnet-hadoop
dhp-schemas project, version 3.17.1, AGPL 3.0, https://code-repo.d4science.org/D-Net/dhp-schemas
dhp-graph-dump project, version 1.2.5, AGPL 3.0, https://code-repo.d4science.org/D-Net/dhp-graph-dump

During the EOSC Future project the following changes have been performed:

- Knowledge Graph model extension to support the representation of the EOSC Services. (CNR)
dhp-schemas project, version 3.17.1, AGPL 3.0, https://code-repo.d4science.org/D-Net/dhp-schemas
- Deduplication of services and data sources (CNR)
dnet-dedup-openaire module within the dnet-hadoop project, version 1.2.5, AGPL 3.0, https://code-repo.d4science.org/D-Net/dnet-hadoop
- EOSC tagging (CNR)
dhp-enrichment module within the dnet-hadoop project, version 1.2.5, AGPL 3.0, https://code-repo.d4science.org/D-Net/dnet-hadoop/src/branch/master/dhp-workflows/dhp-enrichment
- Text and Data Mining (TDM) to find links between publications and EOSC services (ARC & ICM)
TDM module is part of the IIS source code repository. Exact module location: https://github.com/openaire/iis/tree/master/iis-wf/iis-wf-referenceextraction/src/main/resources/eu/dnetlib/iis/wf/referenceextraction/service
License: Apache 2.0