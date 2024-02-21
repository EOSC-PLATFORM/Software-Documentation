# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Building

This project consists of two modules, one _Angular_ application for the [frontend](#frontend) and one _Java_ application for the [backend](#backend).

---

### Frontend
The frontend has been developed and tested using [Angular 12](https://v12.angular.io/docs).

#### Manual build

###### Requirements:
- [Node.js version 16](https://nodejs.org/en/blog/release/v16.16.0)

###### Build Instructions:
Follow the instructions below to download the source code and build the application. 
For more information about building an Angular app you can refer to the official documentation: [Building and serving Angular apps](https://angular.io/guide/build#building-and-serving-angular-apps). 

1. Clone the repository and move inside the directory
   <br> `git clone https://github.com/madgeek-arc/resource-catalogue-ui-eosc.git && cd resource-catalogue-ui-eosc`
2. Install Angular dependencies
   <br> `npm install`
3. Build Angular app
   <br> `ng build --configuration production`
   <br> Produces the directory "dist/**resource-catalogue-ui**" which contains the compiled files.

<br>


#### Build using Docker
The repository contains a **Dockerfile** which can be used to build an Nginx image containing the project files.

###### Requirements:
- Docker

###### Build Instructions:
1. Clone the repository and move inside the directory
   <br> `git clone https://github.com/madgeek-arc/resource-catalogue-ui-eosc.git && cd resource-catalogue-ui-eosc`
2. Build Docker image
   <br> `docker build . -t <docker-image-name>`

---

### Backend
The backend is a [Maven](https://maven.apache.org/index.html) project. It has been tested using Java 8 and Java 11 versions.

<br>

#### Manual Build Instructions

###### Requirements:
- Java 8 / Java 11
- Apache Maven 3+

###### Build Instructions:
1. Clone the repository and move inside the directory
   <br> `git clone https://github.com/madgeek-arc/resource-catalogue.git && cd resource-catalogue`
2. Build Maven project
   <br> `mvn clean package`
   <br> Produces the file "./target/**eic-registry.war**" which can be deployed using [Apache Tomcat](https://tomcat.apache.org/index.html). 

<br>

#### Build using Docker
The repository contains a **Dockerfile** which can be used to build an image containing the compiled project.

###### Requirements:
- Docker

###### Build Instructions:
1. Clone the repository and move inside the directory
   <br> `git clone https://github.com/madgeek-arc/resource-catalogue.git && cd resource-catalogue`
2. Build Docker image
   <br> `docker build . -t <docker-image-name>`

---