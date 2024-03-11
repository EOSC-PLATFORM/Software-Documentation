# Guide for developers

This document explains coding conventions, typical tasks such as compilation,
building and testing.

## How to run using *docker compose*

1. Add required .env file in the project directory
2. Create pod for volume "indexers" shared between main API and loader services
3. Build docker image with `docker compose build`
4. Run command `docker compose up`to start the fastapi instance in the created container

## Testing the system

Prerequisites: Python 3.8
1. Add required .env file in the project directory
2. run `virtualenv --python=/usr/bin/python3.8 venv` (or provide other location of your python installation)
3. run `source venv/bin/activate`
4. run `pip install -r requirements.txt pytest coverage pydantic[dotenv] httpx`
5. in venv/lib/python3.8/site-packages/ add file path.pth containing full paths to folders `app` and `test`
6. run `coverage run -m pytest test/test_main.py --log-cli-level=INFO`

## System Design

Nearest Neighbor Finder is a module providing the indexes of EOSC portal resource and user embeddings for the purpose of searching for the most similar ones. Given a context embedding or an id of an item already in the database, the module returns a list of k most alike items. The index training (indexing) is performed by a separate module - Nearest Neighbor Finder Training Module.
