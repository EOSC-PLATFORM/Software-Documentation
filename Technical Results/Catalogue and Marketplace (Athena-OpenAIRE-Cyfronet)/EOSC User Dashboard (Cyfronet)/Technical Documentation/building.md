# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## How to build


The application consists of two services:

* Web frontend  
* Backend API

## Backend and frontend

Steps:

###1. Clone code from repository:
 ```
 git clone https://github.com/cyfronet-fid/eosc-user-dashboard.git
 ```
###2. Go to user service  dir:
 ```
 cd eosc-user-dashboard
 ```
###3. Create docker configuration file:
 * docker-compose.yml

Example docker-compose.yml

```
version: '3'

services:
  web:
    build: ./ui
    restart: always
    ports:
      - "8003:80"
    networks:
      - user-dashboard-local
    depends_on:
      - api
  api:
    build: ./backend
    command: bash -c "alembic upgrade head && uvicorn app.main:app --reload --workers 1 --host 0.0.0.0 --port 8000"
    restart: always
    ports:
      - "8004:8000"
    networks:
      - user-dashboard-local
    environment:
      DATABASE_URI: postgresql+psycopg2://${POSTGRES_USER:-user-dashboard}:${POSTGRES_PASSWORD:-password}@db:5432/${POSTGRES_DB:-user-dashboard}
      OIDC_HOST: https://aai.eosc-portal.eu
      OIDC_CLIENT_ID: ${OIDC_CLIENT_ID:-id}
      OIDC_CLIENT_SECRET: ${OIDC_CLIENT_SECRET:-I-secret}
      SECRET_KEY: ${SECRET_KEY:-sercret-key}
      BACKEND_BASE_URL: https://my.eosc-portal.eu
      UI_BASE_URL: https://my.eosc-portal.eu
      OIDC_AAI_NEW_API: "true"
      RECOMMENDER_ENDPOINT: http://hostname:8081/recommendations
      SOLR_URL: http://hostname:8983/solr/
      STOMP_HOST: marketplace.eosc-portal.eu
      STOMP_PORT: 61613
      STOMP_LOGIN: login
      STOMP_PASS: password
      ESS_STOMP_SSL: 1
      ESS_QUEUE_CLIENT_NAME: "ud-prod"
    depends_on:
      - db

  db:
    image: postgres:14
    restart: always
    volumes:
      - db-data:/var/lib/postgresql/data/
    networks:
      - user-dashboard-local
    environment:
      POSTGRES_DB: ${POSTGRES_DB:-user-dashboard}
      POSTGRES_USER: ${POSTGRES_USER:-user-dashboard}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-password}

volumes:
    db-data:

networks:
  user-dashboard-local:
```

###4. Build docker images
 ```
 docker-compose build
 ```