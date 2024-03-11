# Preprocessor - Load Testing

## Introduction

The load tests should give an answer to the following question: 

> Is the preprocessor able to do its job under specific work load?


## What should be measured

- processing dumps,
- processing user actions,
- processing Marketplace events,
- calculating statistics.


## Acceptance criteria

Answer for the above question is "Yes" only if the preprocessor is able to handle the [target load](#target-load) in 
[test environments](#test-environments).


## Target load

### Dumps

- Size of a single JSONL file: 40 MB
- Total size of file collection: 8 GB
- Expected processing time: < 12h

### User Actions

- Throughput: 200 messages/s
- Time: 1h
- Total messages processed: 720 000


### Marketplace events

- Throughput: 200 messages/s
- Time: 1h
- Total messages processed: 720 000


### Statistics

- Total number of user actions: 720 000
- Maximum processing time: 1h


## Test Environments

Processing dumps is launched on an external computing cluster with the following specification:
(to do)

Other processings are launched on a Linux-based test machine which is an equivalent of Intel Core I7, 32GB RAM, 
100GB HDD. The preprocessor, JMS queue and database are running on the same machine.


## The Tests

User actions and marketplace domain events:
- automated test runnable on demand,
- confirm that all the produced messages have been processed,

Statistics:
- automated test runnable on demand

Dumps:
- performance reports saved files for every launch of a Spark job,
- reports verified manually.
