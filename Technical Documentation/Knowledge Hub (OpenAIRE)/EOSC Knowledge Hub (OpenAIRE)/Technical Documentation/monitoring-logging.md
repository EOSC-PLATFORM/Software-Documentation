# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Monitoring and Logging

- Explanation of monitoring tools and practices.
- How to interpret logs and troubleshoot issues.

Site is monitored by two outside (from other network than system is running) monitoring servers and one internal.  
HTTPS connections are monitored - whether the website is responding and there are no response delays.

System resources (CPU, RAM, space, system load)  are internally monitored with:

  - Prometheus: to gather metrics
  - Grafana: to visualize metrics during time 

Additional monitoring is done with Mmonit.  
Mmonit checks if every critical service (apache, mysql, sshd) is up and running.  
If something is wrong Mmonit send email to Administrators and try to restart service if needed.
