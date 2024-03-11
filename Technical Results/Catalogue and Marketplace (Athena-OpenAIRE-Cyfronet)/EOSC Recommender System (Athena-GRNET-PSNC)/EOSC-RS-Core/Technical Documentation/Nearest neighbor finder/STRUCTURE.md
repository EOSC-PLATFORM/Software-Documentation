# Structure file

``` bash
.
├── app                             # main app folder
│   ├── core                        # core folder shared between modules
│   │   ├── classes                 # folder for classes used
│   │   │   ├── Indexer.py          # base class for interacting with indexes
│   │   │   └── SearchContext.py    # format of search context data
│   │   ├── functions               # folder for functions used
│   │   │   ├── connection.py       # functions connecting to data sources.
│   │   │   ├── graph_relations.py  # functions for search in graph
│   │   │   ├── training.py         # functions training indexers from database tables
│   │   │   └── utils.py            # functions supporting other functions
│   │   └── tables_config.py        # configuration for operations on database tables
│   ├── exceptions.py               # API exceptions
│   ├── downloader.py               # FastAPI application for downloading indexes from HDFS
│   ├── main.py                     # MAIN FastAPI application for the NN Finder
│   ├── settings.py                 # enviroment variables and project configuraiton
│   └── validation.py               # validation functions for query input data
├── CHANGELOG.md                    # project changelog
├── CITATION.cff                    # project citation template
├── CODE_OF_CONDUCT.md              # contributors code of conduct
├── CONTRIBUTING.md                 # guide for contributing
├── DEVELOPERS_GUIDE.md             # guide for developers
├── docker-compose.yml              # Docker compose config
├── Dockerfile                      # Docker image config
├── Jenkinsfile                     # Jenkins CI/CD config
├── LICENSE.txt                     # EUPL license
├── poetry.lock                     # poetry file
├── pyproject.toml                  # pyproject file
├── README.md                       # module usage summary and reference file
├── requirements.txt                # Python requirements for running the app
├── tables_config.json              # JSON file with configuration of tables for training
├── test                            # folder with files for testing the module
│   ├── example_context_data.py     # example context data for the search endpoint
│   └── test_main.py                # pytest testing file
└── STRUCTURE.md                    # structure file
```
