# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Security

Access to the application should not be made publicly available. The application validates messages delivered by JMS 
and further communicates via API, Kafka and PostgeSQL. 

Spark jobs require access to hdfs, Yarn and PostgreSQL.

The application does not support user authentication.

The Preprocessor does not validate messages arriving via JMS and treats each message as valid.