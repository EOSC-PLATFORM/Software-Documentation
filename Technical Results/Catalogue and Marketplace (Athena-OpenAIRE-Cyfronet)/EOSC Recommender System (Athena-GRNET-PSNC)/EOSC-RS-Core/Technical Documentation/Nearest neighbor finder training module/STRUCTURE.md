# Structure file

```bash
.
├── app                             # main app folder
│   ├── core                        # core folder shared between modules
│   │   ├── classes                 # folder for classes used
│   │   │   └── Indexer.py          # base class for interacting with indexes
│   │   ├── functions               # folder for functions used
│   │   │   ├── connection.py       # functions connecting to data sources.
│   │   │   ├── training.py         # functions training indexers from database tables
│   │   │   └── utils.py            # functions supporting other functions
│   │   └── tables_config.py        # configuration for operations on database tables
│   ├── exceptions.py               # API exceptions
│   ├── main.py                     # FastAPI application for the Training Module
│   ├── settings.py                 # environment variables and project configuraiton
│   └── worker
│       ├── celery_app.py
│       └── celery_worker.py
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
│   ├── requirements.txt            # Python packages for test environment
│   └── test_main.py                # pytest testing file
└── STRUCTURE.md                    # structure file
```
