# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Backup and Recovery

The **Postgres and HDFS** backup is necessary for the proper functioning of the application and 
for the correctness of the recommendations.

The application stores information about statistics regarding **user sessions** (visited and ordered resources).
Statistics are sent to the database every 10 minutes by default (enviorment variable: *CRON_TODAY_UPDATE*). 
The potential loss of data for a period of 10 minutes does not significantly affect the quality of the recommendations 
and does not require a backup. 

The application also assigns tasks to the **computing cluster** and tracks the status of the 
tasks by ordering subsequent tasks. If the application crashes, it may be necessary to restart processing or manually 
perform individual operations.

