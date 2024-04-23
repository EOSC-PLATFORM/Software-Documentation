# Guide for developers

This document explains coding conventions, typical tasks such as compilation,
building and testing.

## How to run using *docker compose*

1. Add required .env file in the project directory
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

Nearest Neighbor Finder Training Module provides indexes for similarity search on EOSC portal resource and user embeddings. The indexes trained by this module can be used by the separate module Nearest Neighbor Finder which provides the search endpoint.
