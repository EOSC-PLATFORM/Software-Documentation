# Guide for loading new data to Nearest Neighbor Finder

Prerequisites:
- Indexes trained by NNFinder Training Module (NNFTM) and stored in HDFS
- Graph dicts stored in HDFS

## Load data to NNFinder
- load the indexes from HDFS to NN Finder using the **\update_index** endpoint in order to perform neihgbor search on new data.

```bash
PUT https://{NNF_URL}/update_index/?tables=["datasets","publications","software","other_research_product","services","trainings","data_sources","users_aai","users_anon","users"]
```

- Dicts for graph search are loaded to NNFinder only on module startup.
