# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## How to build

To build the application, we recommend creating Docker images; please note that the system consists of two applications that are hosted in separate Git repositories.

To build the application, download the latest code from the repository, we recommend downloading the latest release and build docker images  

## Marketplace:

Steps:

###1. Clone code from repository:
	```
	git clone https://github.com/cyfronet-fid/marketplace.git
	```
###2. Go to marketplace dir:
	```
	cd marketplace
	```
###3. Create docker configuration files:
   - Dockerfile
   - docker-compose.yml


Example Dockerfile:
```
FROM ruby:3.0.3-alpine

RUN apk --update add build-base tzdata postgresql-dev postgresql-client libxslt-dev libxml2-dev imagemagick shared-mime-info nodejs yarn build-dependencies
 
ENV RAILS_ENV production
ENV RACK_ENV production
ARG ASSET_HOST
ARG ASSET_PROTOCO
ENV ASSET_HOST $ASSET_HOST
ENV ASSET_PROTOCOL $ASSET_PROTOCOL

RUN gem install bundler  
RUN gem install foreman --conservative

RUN mkdir /marketplace
WORKDIR /marketplace
COPY Gemfile Gemfile.lock package.json yarn.lock ./

RUN bundle config set without development test
RUN bundle install
RUN yarn

COPY . /marketplace
RUN mkdir -p /marketplace/tmp/pids

RUN bundle exec rake assets:clean assets:precompile
EXPOSE 3000
CMD bundle exec puma
```

Example docker-compose.yml

```
version: '3'

services:
  redis:
	image: redis
	restart: always
  el:
	image: elasticsearch:7.5.0
	restart: always
	environment:
  	- discovery.type=single-node

  db:
	image: postgres:10.6
	restart: always
	volumes:
  	- db-data:/var/lib/postgresql/data

  web:
	build:
  	context: .
  	args:
    	ASSET_HOST: marketplace.eosc-portal.eu
    	ASSET_PROTOCOL: https
	restart: always
	volumes:
  	- media:/marketplace/media
	command: bundle exec puma 	
      ports:
  	- "3000:3000"
	depends_on:
  	- db
  	- el
  	- redis
	env_file:
  	- marketplace.env

  worker:
	build:
  	context: .
  	args:
    	ASSET_HOST: marketplace.eosc-portal.eu
    	ASSET_PROTOCOL: https
	volumes:
  	- media:/marketplace/media
	restart: always
	command: 
	depends_on: ./bin/rails db:migrate && ./bin/rake searchkick:reindex:all && bundle exec sidekiq -C config/sidekiq.yml

  	- db
  	- el
  	- redis
	env_file:
	- marketplace.env
	links:
  	- el
  	- redis
  	- db
      	 
  jms-subscriber:
	build:
  	context: .
  	args:
    	ASSET_HOST: marketplace.eosc-portal.eu
    	ASSET_PROTOCOL: https
	restart: always
	command: ./bin/jms-subscriber
	depends_on:
  	- db
  	- el
  	- redis
	env_file:
	- marketplace.env
	links:
  	- el
  	- redis
  	- db
volumes:
 media:
 db-data:
```

###4. Build docker images
 ```
 docker-compose build
 ```


# Search Service 

The application consists of three services:

* Web frontend  
* Backend API
* Transformer micro service

## Backend:

Steps:

###1. Clone code from repository:
 ```
 git clone https://github.com/cyfronet-fid/eosc-search-service.git
 ```
###2. Go to search service  dir:
 ```
 cd eosc-search-service
 ```
###3. Create docker configuration files:
 * Dockerfile
 * docker-compose.yml

Example Dockerfile:
```
FROM python:3.10
WORKDIR /app
# Don't write pyc files to disk
ENV PYTHONDONTWRITEBYTECODE 1
# Don't buffer stdout and stderr
ENV PYTHONUNBUFFERED 1
COPY Pipfile Pipfile.lock /app/
RUN pip install --upgrade pip pipenv
RUN pipenv install --deploy --system
COPY alembic alembic
COPY alembic.ini .
COPY app app
CMD pipenv run uvicorn --host 0.0.0.0 --port 8000 app.main:app
```
###4. Build docker images
 ```
 docker-compose build
 ```


## Frontend:
Steps:
###1. Clone code from repository:
 ```
 git clone https://github.com/cyfronet-fid/eosc-search-service.git
 ```
###2. Go to search service frontend dir:
 ```
 cd eosc-search-service/ui
 ```
###3. Create docker configuration files:
 * Dockerfile
 * docker-compose.yml
 * nginx.conf


Example Dockerfile:

```
FROM node:16.13 as build
RUN apt-get update -y
WORKDIR /app
COPY ./ /app/
RUN npm install
RUN npm run build
FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/apps/ui/ /usr/share/nginx/html
EXPOSE 80
```

Example docker-compose.yml 
```
version: '3.9'
services:
  web:
	build: ./ui
	restart: always
	ports:
  	- "8124:80"
	depends_on:
  	- api
	networks:
  	- ess

  api:
	build: ./backend
	restart: always
	command: bash -c " pipenv run alembic upgrade head && pipenv run uvicorn --host 0.0.0.0 --port 8000 app.main:app"
	ports:
  	- "8001:8000"
	networks:
  	- ess
	environment:
  	DATABASE_URI: postgresql+psycopg2://${DB_POSTGRES_USER:-ess}:${DB_POSTGRES_PASSWORD:-passwd}@db:5432/${DB_POSTGRES_DB:-ess}
      env_file:
	- search-service.env    
	depends_on:
  	- db

  db:
	image: postgres:14
	restart: always
	volumes:
  	- db-data-new:/var/lib/postgresql/data
	networks:
  	- ess
	environment:
  	POSTGRES_DB: ${DB_POSTGRES_DB:-ess}
  	POSTGRES_USER: ${DB_POSTGRES_USER:-ess}
  	POSTGRES_PASSWORD: ${DB_POSTGRES_PASSWORD:-passwd}

volumes:
  db-data-new:

networks:
  ess:
```

Example nginx.conf

```
user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}

http {
    server {
        listen 80;
        server_name  localhost;

        root   /usr/share/nginx/html;
        index  index.html index.htm;
        include /etc/nginx/mime.types;
        gzip on;
        gzip_vary on;
        gzip_disable "MSIE [1-6]\.";
        gzip_min_length 256;
        gzip_proxied expired no-cache no-store private auth;
        gzip_types text/plain text/css application/json application/javascript application/x-javascript text/xml application/xml application/xml+rss text/javascript;

      location ~* \.(png|jpg|jpeg|gif)$ {
         expires 365d;
         add_header Cache-Control "public, no-transform";
      }

     location ~* \.(js|css|pdf|html|swf)$ {
       expires 30d;
       add_header Cache-Control "public, no-transform";
      }


        location / {
            try_files $uri $uri/ /index.html;
        }

        location /api/web/ {
            proxy_pass http://api:8000/api/web/;
            proxy_set_header X-Forwarded-Host $host:443;
            proxy_set_header X-Forwarded-Proto https;
        }

    }
}

```
###4. Build docker images
 ```
 docker-compose build
 ```

## Transformer 

Steps:

###1. Clone code from repository:
 ```
 git clone https://github.com/cyfronet-fid/eosc-search-service.git
 ```
###2. Go to search service tranformer dir:
 ```
 cd eosc-search-service/tranform
 ```
###3. Build docker images
 ```
 docker-compose build
 ```