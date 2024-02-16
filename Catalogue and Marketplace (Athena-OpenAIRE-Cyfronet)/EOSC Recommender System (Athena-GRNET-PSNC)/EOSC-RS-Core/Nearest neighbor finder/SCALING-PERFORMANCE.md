# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Scaling and Performance

With the expanding database of objects, the size of index files will increase and fill up application's memory. The main way to counter that is to increase RAM size on the servers of all modules. Another problem in this case is the increased time needed to train the indexes, which can be solved by increasing the number of workers in the training module. The index download time is already balanced by the Downloader running in parallel to NN Finder, so it should not be a problem.

With increasing number of portal users, load on NN Finder search endpoint will rise. The main way to improve on that would be horizontal scaling by deploying multiple application instances on separate servers and distributing the load between them with a load balancer. Note that when scaling, the NN Finder Downloader would need changes in code that make it able to notify all instances of NN Finder, as they all need to read the new data from shared volume.

When resources of a new language are to be added to the indexes, the list in `RESOURCE_LANGUAGES` variable is to be expanded by the language identifiers in the database. This will also increase the filesize of indexes depending on the amount of newly included resources.

## Performance Testing

The performance of the system can be tested using [Locust](https://locust.io/), which allows running configurable load tests..

![Results of a load test](assets/test-2023-12-21.png)

The tests performed with the Locust framework show that the module keeps a steady response time under 500ms and serves around 70 requests per second, with the requests parametrized by a variety of resource types and simulated embeddings. The test can be reproduced using the script located in `test/performance/locustfile.py` by following the [official tutorial](https://docs.locust.io/en/stable/quickstart.html).

## Monitoring

The monitoring of the resources used by the system can be performed using a system memory monitoring tool, such as `htop`, or the Kubernetes Dashboard.
