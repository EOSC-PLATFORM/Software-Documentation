# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Scaling

With the expanding database of objects, the size of index files will increase and fill up application's memory. The main way to counter that is to increase RAM size on the servers of all modules. Another problem in this case is the increased time needed to train the indexes, which can be solved by increasing the number of workers in the Training Module. The index download time is already balanced by the Downloader running in parallel to NN Finder, so it should not be a problem.

With increasing number of portal users, only load on NN Finder search endpoint will rise, and the Training Module should not be affected, apart from the increased filesize of the user indexes, which was already described in the last paragraph.

When resources of a new language are to be added to the indexes, the list in `RESOURCE_LANGUAGES` variable is to be expanded by the language identifiers in the database. This will also increase the filesize of indexes depending on the amount of newly included resources.

## Performance Testing

There were no performance tests conducted on this module for the following reasons:
- the training process is based on a message queue, and the training time will vary depending on the number of workers available, as well as the index size.
- interaction with the endpoints is only done by a developer or system administrator, so the processing time is not crucial in terms of user experience

## Monitoring

The monitoring of the resources used by the system can be performed using a system memory monitoring tool, such as `htop`, or the Kubernetes Dashboard.

The training message queue can be monitored using the [Celery Flower](https://flower.readthedocs.io/en/latest/) tool.
