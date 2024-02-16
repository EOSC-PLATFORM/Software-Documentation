# Guide for developers

This document explains coding conventions, typical tasks such as compilation,
 building and testing.

## Prerequisites
- Python 3.9
- Install all python packages from `requirements.txt`
- Install project by `pip install -e .`

## How to run uvicorn

- Create file `.env` and fill in the necessary environment variables.
- Type `uvicorn app.main:app --port 8001` to run the application.

## How to run using *docker compose*
Required version for `docker compose`: `>1.29.2`.

- Build docker image  `docker-compose build`
- Run docker image  `docker-compose up`

or more details, see [BUILDING.md](docs/BUILDING.md) and [DEPLOYMENT.md](docs/DEPLOYMENT.md).

### Development utils
- **[pre-commit](https://pre-commit.com/)**
- **[black](https://github.com/psf/black)**
- **[flake8](https://github.com/pycqa/flake8)**
- **[pylint](https://github.com/PyCQA/pylint)**
- **[google docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)**

