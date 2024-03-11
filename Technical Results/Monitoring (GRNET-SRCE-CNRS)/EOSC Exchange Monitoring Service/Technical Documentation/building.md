# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## How to build

### Monitoring box

For the monitoring box to run, you will need to have Sensu backend and agent installed. 

They can be built from source as described in [Sensu GitHub repo](https://github.com/sensu/sensu-go/blob/main/README.md#building-from-source).

### Web API

Web API is contained in a single golang binary. To build it from source you can follow the instruction here <https://github.com/ARGOeu/argo-web-api#installation>


### Compute/Streaming engine

Compute/Streaming engine consists of a series of data analytic jobs that run on Apache Flink Platform plus a suite of python scripts that allow easier operations such as more convenient handling of job submission and scheduling etc... 

We currently operate the following set of data analytic jobs:
- **Ingestion job**: This is a realtime streaming job that is able to ingest data from the Messaging System and store it at hdfs destinations in the form of rolling avro files (See more about avro format [here](https://avro.apache.org/))
- **Multi Computation job**: This is a batch job that operates on tenant monitoring data (retrieved from hdfs sources) and topology, profile and downtime data (retrieved from Web API). It produces availability, reliability, status and trend results which are stored at a remote MongoDB destination and finally served by Web API
- **Streaming job**: This is a streaming job that operates realtime by observing a stream of monitoring data coming from Messaging service and produces near realtime status events that are used for providing near real-time results and notifications

The Compute/Streaming engine sources are hosted in the repo: <https://github.com/ARGOeu/argo-streaming>

The current stable production versions sources of the computation jobs are in the following repository folder: <https://github.com/ARGOeu/argo-streaming/tree/master/flink_jobs_v2>


#### Prepare local build environment for JARS
Assuming you are working on Centos 7, you will need Java 1.8 (openjdk) and Maven 3.0.5 Installed

Issue the following commands:
```
yum --enablerepo=base clean metadata -y
yum update -y
yum install -y java-1.8.0-openjdk-devel \
                   maven \
                   git
```

Check out the compute/streaming engine source repo by issuing:
```
git clone https://github.com/argoeu/argo-streaming
```

Move to the repo folder that current stable analytics jobs reside (`/flink_jobs_v2`)
```
cd ./argo-streaming/flink_jobs_v2
```

To build the JAR packages issue:
```
mvn clean && mvn package
```

The process takes a while in order to download all the depedencies, run the tests and package the JARS.

The resulting uber JARS (with all the depedencies included) will be located at the following folders (from the root of project):
- **Ingestion job uber JAR**: `./flink_jobs_v2/ams_ingest_metric/target/ams-ingest-metric-*.jar`
- **Multi job uber JAR**: `/flink_jobs_v2/batch_multi/target/ArgoMultiJob-*.jar`
- **Streaming job uber JAR**: `./flink_jobs_v2/stream_status/target/streaming-status-*.jar`

__Note:__ Don't use the JARS prefixed with `original-` because they are smaller in size and don't include the required depedencies which will cause issues when deploying on the flink cluster

Keep in mind that you will need a working flink cluster (along with HDFS) in order to be able to submit the jobs for execution. 

#### Prepare local environment for python scripts

As mentioned before the compute/streaming engine comes with a set of python utility scripts that allow easier operations. In order to use them you must create a virtual python environment (Python 3.6) and checkout the `/bin` and `/conf` folders from argo-streaming repository <https://github.com/argoeu/argo-streaming>

- `./conf`: Includes template configuration files for the python scripts
- `./bin`: Includes the python utility scripts that allow easier submission of job and controlling tenants and configurations

You can execute unit tests by issuing: 

1) First enable the python virtual environment you have set up (for more info see [here](https://docs.python.org/3/library/venv.html))

2) After having enabled the environment and having Python 3.6 and pip3 at your disposal issue the following to install the required depedencies:
```
git checkout https://github.com/argoeu/argo-streaming
cd ./argo-streaming/bin
pip3 install -r requirements.txt --user
```

3) Then you can execute unit tests by issuing
```
pytest
```



