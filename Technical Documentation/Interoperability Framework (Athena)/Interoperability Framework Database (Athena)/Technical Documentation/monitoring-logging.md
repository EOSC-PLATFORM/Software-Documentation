# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

### Important note

*EOSC Interoperability Registry is inherently connected with the Service Cataloge Infrastructure, sharing common resources, installation and deployment. Hence, same policies, instructions and procedures apply for both components.* 

## Monitoring and Logging

Interoperability Registry backend infrastructure runs on Tomcat, and is monitored using JavaMelody: https://github.com/javamelody/javamelody

### Monitoring Tomcat with JavaMelody
JavaMelody is an open-source performance monitoring tool for Java applications. If you are using Maven to build your application, you can enable JavaMelody by adding the following dependency to the pom.xml:
```
<dependency> 
    <groupId>net.bull.javamelody</groupId> 
    <artifactId>javamelody-core</artifactId> 
    <version>1.91.0</version> 
</dependency> 
```

Once enabled, JavaMelody aggregates data from server and access logs to create charts for different metrics, including memory usage over time, number of Java Database Connectivity (JDBC) connections, and request throughput. JavaMelody graphs persist across restarts, and you can access the web interface at http://>tomcat-IP>:<port>/<application-name >/monitoring.

Arguably the most important section on the monitoring portal is the “statistics of http system errors”. It contains a list of the most frequently occurring system and HTTP errors, and Java exceptions. A similar section, “statistics system error logs”, contains a list of the logs produced by Tomcat for frequently occurring errors and warnings.

Values of JMX MBeans can also be read via JavaMelody. To access the page for any loaded MBean, one can use the following URL:/monitoring?part=mbeans-URL.

### App logging 

Tomcat provides an access log feature that logs all incoming requests to the Service Catalogue app. This can be helpful for troubleshooting and debugging purposes. Enable access logging by adding the following properties to your application.properties file:

```
server.tomcat.accesslog.enabled=true
server.tomcat.accesslog.pattern=%t %a "%r" %s %b "%{Referer}i" "%{User-Agent}i"
```

This will enable access logging and set the log pattern to include the time, client IP address, request method, response status, response body size, and HTTP headers.

Java exceptions are assigned unique identifiers by the Interoperability Registry backend infrastructure. These exception identifiers are automatically included in the non 200/OK responses to help UI/API users pinpoint issues and help developers trace back causes.