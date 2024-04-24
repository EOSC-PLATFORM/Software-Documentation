# Instruction, on how to load new data into the recommender system

## 1. Preprocessor

### 1.1. Load dump to the Preprocessor

To load the dump to preprocessor you have to go to
this [repo](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/preprocessor/browse) 
and do as in instruction.

### 1.2 End Messages

After loading the dump, the Preprocessor should send a message to Kafka

## 2 Nearline Engine

### 2.1 Resource Embeddings

For creating resource embeddings, we have 2 options:

- Nearline ML AI engine (PySpark)
   [branch master](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse)
**recommended**
- Nearline ML AI
  engine [branch feature/slurm](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse?at=refs%2Fheads%2Ffeature%2Fslurm)

#### 2.1.1 Slurm version

Then you have to use one of the endpoint like in this 
[instruction](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse/LOAD_NEW_DATA.md).

#### End Messages

After processing each file and folder, a message will be sent to Kafka.

#### 2.1.2 PySpark version

To run this version, you need to prepare python environment on Spark as in the
[instruction](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse/app/user_entity/spark/README.md)
.

Then you have to use one of the endpoint like in this 
[instruction](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse/LOAD_NEW_DATA.md).

### 2.3 User Embeddings

For creating user embeddings, you need to follow this
[instruction](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearline-ml-ai-engine/browse/LOAD_NEW_DATA.md).

## 3 Nearest Neighbor Index training

- Update embeddings in PostgreSQL or HDFS, and the metadata table in PostgreSQL
- Train new indexes using NNFinder Training Module: [instructions](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder-training-module/browse/LOAD_NEW_DATA.md)
- Load the trained indexes to NNFinder: [instructions](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder/browse/LOAD_NEW_DATA.md)

## 4. Online Engine

In order to load new data into Online Engine, after loading data into PostgreSQL and HBase databases and updating
metadata tables, the Online Engine module must be reloaded.
Details [online engine](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/online-ml-ai-engine/browse/LOAD_NEW_DATA.md)
