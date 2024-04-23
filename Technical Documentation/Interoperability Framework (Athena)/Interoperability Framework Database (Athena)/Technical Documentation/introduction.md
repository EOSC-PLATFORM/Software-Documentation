# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Introduction

**EOSC Interoperability Framework Registry**, provides  both  data  and  functionality  to  register,  maintain,  administer  and  share *Interoperability Guideline* records onboarded  by various providers. Moreover, it’s the point of reference for all EOSC Future  components  that  provide  added value to this information and help in making all this data and services searchable and accessible using various tools, both for researchers and end users.

The purpose of this document is to compile a set of basic instructions for configuring, building, installing, monitoring and maintaining a working instance of the EOSC Interoperability Framework Registry. It does not cover resource management operations: it provides thne necessary documentation for tech leads and integrators to set up the EOSC EOSC Interoperability Framework Registry as a EOSC Core Component. Note that there are a lot of integrations with other EOSC Core Components: the EOSC Interoperability Framework Registry does not work as a standalone monolithic software package, and in fact it's very tightly coupled with EOSC Service Catalogue, sharing database storage layer and service infrastructure. All these integrations are included in the documentation and in the Interoperability Guidelines referenced at the end of this document, in the References section.

### Intended audience

- Admins that are responsible for maintaining the EOSC Interoperability Framework Registry component
- Developers for building the software after code modifications
- Security admins for providing access to EOSC Service Catalogue proprietary features
- EOSC Core Component tech leads/integrators
- Anyone  else that  needs  to  configure, build, install and maintain an instance of the EOSC Interoperability Framework Registry

  