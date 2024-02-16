# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Differential Processing

Differential processing is performed by comparing the resource id and hashes calculated from 
all columns (except language prediction), after the data has been processed by the preprocessor - 
at the output of the preprocessor.

The first differential processing only includes data from the `added` category

### Assumptions

Adopted to simplify the problem:

1. resources are clearly distinguishable based on their content
2. resources never change both in terms of ID and content

### How to run?

To perform differential processing see: [processing dump files](../operations/Operations.md#processing-dump-files),

### Output 

#### Data categories

The data is divided into 5 categories:
- added - new records (unique id and hash)
- deleted - deleted records
- unchanged
- changed_content - a different hash was calculated for the given id
- unstable_id - the id has been changed for a given hash

#### Directory structure

As a result of processing, the data is placed in appropriate directories.
There are 2 folders in the [dump]/[resource] path: `data` and `digest`.

Except `deleted`, `unchanged` and `unstable_id`, which do not contain `data` folder.

The `data` folder contains only processed data for records from the `added` and `changed_content` categories.

The `digest` folder contains all id pairs and hashes divided into categories, with 2 exceptions:
- for `unstable_id` the schema contains: deletedId, digest, addedId 
- for `changed_content` the schema contains: id, deletedDigest, addedDigest
It is not necessary to create all folders if there is no data from a given category.