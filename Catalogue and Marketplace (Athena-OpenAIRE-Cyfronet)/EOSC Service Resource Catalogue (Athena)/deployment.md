* Name of file”

*  © 2023 ARC full name.

* This file is licensed to You under the Apache Software License 2.0 license, a copy of which is included in the repository. ou may obtain a copy of the License at     http://www.apache.org/licenses/LICENSE-2.0. you may not use this file except in compliance with the License

*  Unless required by applicable law or agreed to in writing, software  distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

* See the License for the specific language governing permissions and  limitations under the License

# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

# Deployment

## Frontend

### Prerequisites
- Nginx

### Instructions
To deploy the Frontend app: 
1. Make sure that you have successfully [built](./building.md#frontend) and [installed](./installation.md#frontend) the application on Nginx (or another Web Server).
2. _Start_ or _reload_ the Web Server service. 
<br>e.g. `systemctl start nginx` or `systemctl reload nginx`


---

## Backend

### Prerequisites
* [Apache Tomcat 8.5](https://tomcat.apache.org/download-80.cgi)
* [ActiveMQ 5.x.x](https://activemq.apache.org/)
* [Elasticsearch 7.x.x](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/elasticsearch-intro.html)
* [PostgreSQL 9.5+](https://www.postgresql.org/)


### Instructions


#### Add resourceTypes (only the first time you deploy the project)
1. Navigate to eic/eic-registry/src/main/resources/resourceTypes

2. Execute `bash loadResourceTypes.sh localhost` (replace localhost with your host)


#### Deploy Tomcat
1. Ensure that the [Prerequisites](#prerequisites) are up and running.
2. Start Apache Tomcat service: `systemctl start tomcat`
3. Check that the backend application is running by reviewing the logs and make sure that there are no errors.
   <br> The Tomcat logs can be found inside "tomcat-base-dir/logs/catalina.out"
   <br> To get only the webapp logs you can find them inside "tomcat-base-dir/logs/eic.log"
