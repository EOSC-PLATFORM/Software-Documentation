# Guide for developers

This document explains coding conventions, typical tasks such as compilation,
 building and testing.

## Prerequisites
- Python 3.9
- Install all python packages from [requirements.txt](requirements.txt)

### Development utils
- **[pre-commit](https://pre-commit.com/)**
- **[black](https://github.com/psf/black)**
- **[flake8](https://github.com/pycqa/flake8)**
- **[pylint](https://github.com/PyCQA/pylint)**
- **[google docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)**

## Setup

Create file `.env` and fill in the necessary environment variables according to the [CONFIGURATION.md](docs/CONFIGURATION.md).

### How to run localy using uvicorn

- Install project by `pip install -e .`
- Type `uvicorn facade_app.main:app --port 8001` to run the application.

### How to run container using *docker compose*
Required version for `docker compose`: `>1.29.2`.

- Build docker image  `docker-compose build`
- Run docker image  `docker-compose up`


