# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## EOSC Recommender System

**Introduction**

The EOSC Recommendation System (EOSC-RS) is a novel component of the EOSC Portal. The goal of the EOSC-RS is to recommend a set of resources to a user in a given context, based on their preferences, background data and algorithms. As a result, it improves the overall User Experience (UX) and increase the uptake of the EOSC resources among user communities.  To identify resources useful for a user, the EOSC-RS predicts (or compares) the utility of some of them and then decides which to recommend based on this comparison. The presented recommendations facilitate rapid identification of applicable resources in EOSC as well as better findability of datasets relevant to the particular user.

The EOSC-RS delivers two main types of recommendations: recommendations for Consumers (researchers) and recommendation for (resource) Providers. The EOSC-RS is available to other EOSC components through a dedicated API (the RS Facade), but it doesn't communicate with end-users directly. 

[Interoperability guideline](https://zenodo.org/doi/10.5281/zenodo.7849177) presents details of the RS architecture and connections between software components.  

**Packages**

- EOSC-RS-Core: RS core framework serving recommendations for research products and trainings (PSNC)
- EOSC-RS-Extensions : RS engine serving additional recommendations in the Marketplace and recommendations for providers (ATHENA)
- EOSC-RS-Metrics: evaluation framework for recommendations  (GRNET)
- EOSC-RS-MP: RS engine serving recommendations for services in the Marketplace (Cyfronet)

**Software components**

EOSC-RS-Core

- Nearline engine	[docs](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse/docs)
- Online engine	[docs](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/online-ml-ai-engine/browse/docs)
- Nearest neighbor finder	[docs](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder/browse/docs)
- RS Facade	[docs](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/rs-facade/browse/docs)
- Nearest neighbor finder training module	[docs](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder-training-module/browse/docs) 
- Pre-processor	[docs](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse)

EOSC-RS-Extensions

- Content Based RS	[docs](https://github.com/athenarc/EOSCF-ContentBasedRS/tree/master/docs)	
- Provider Autocompletion	[docs](https://github.com/athenarc/EOSCF-Autocompletion/tree/master/docs)
- Provider Insights	[docs](https://github.com/athenarc/EOSCF-Provider-Insights/tree/master/docs)

EOSC-RS-Metrics

- RMF   [docs](https://github.com/ARGOeu/eosc-recommender-metrics/tree/devel/docs)

Additional information about the software components, such as TRLs or SBoM (Sofware Bill of Materials) can be found on the [EOSC-F Wiki](https://wiki.eoscfuture.eu/display/EOSCF/Software+components+map)
