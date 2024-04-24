# Structure file

```bash
.
├── nearline_app
│   ├── data_generators
│   │   ├── artificial_generator.py
│   ├── database_connectors
│   │   ├── BetterConnection.py
│   │   ├── DataBaseConnector.py
│   │   ├── HBaseConnector.py
│   │   └── PostgresConnector.py
│   ├── scripts
│   │   ├── get_data_from_kafka_topic.py
│   │   ├── hbase_initiation.py
│   │   ├── postgres_initiation.py
│   │   └── README.md
│   ├── spark
│   │   ├── test
│   │   │   ├── *.csv
│   │   │   ├── test_job_context.py
│   │   │   ├── test_update_id_job.py
│   │   │   ├── utils.py
│   │   │   └── test_adding_job.py
│   │   ├── job.py
│   │   ├── logger_provider.py
│   │   ├── adding_job.py
│   │   ├── deletion_job.py
│   │   ├── udf_and_utils.py
│   │   ├── update_content_job.py
│   │   ├── update_id_job.py
│   │   └── runner_diff.py
│   ├── connector.py
│   ├── kafka_runner.py
│   ├── main.py
│   ├── processor.py
│   ├── requirements.txt
│   ├── settings.py
│   ├── spark_brain.py
│   └── utils.py
├── hadoop-config
│   └── README.md
├── tests
│   ├── datasets.csv
│   ├── HbaseMocks.py
│   ├── KafkaMocks.py
│   ├── test_BetterConnection.py
│   ├── test_connector.py
│   ├── test_HBaseConnector.py
│   ├── test_kafka.py
│   ├── test_PostgresConnector.py
│   ├── test_processor.py
│   └── utils_mocks.py
├── CHANGELOG.md
├── CITATION.cff
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── DEVELOPERS_GUIDE.md
├── docker-compose.yml
├── Dockerfile
├── initialize.py
├── Jenkinsfile
├── LICENSE.txt
├── README.md
├── requirements.txt
└── TODO.md
```
