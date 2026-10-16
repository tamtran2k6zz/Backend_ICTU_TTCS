# JSP Servlet Demo — Server Time

A minimal Maven WAR application for Java 17 and Apache Tomcat 10.1+. The home JSP renders the current server date/time and timezone on each request. `/hello` is mapped to a Jakarta Servlet through `web.xml`.

## Project layout

```text
jsp-servlet-demo/
├── pom.xml
└── src/main/
    ├── java/com/codegym/HelloServlet.java
    └── webapp/
        ├── index.jsp
        ├── assets/styles.css
        └── WEB-INF/web.xml
```

## Build and deploy

From this directory, run:

```bash
mvn clean package
```

The deployable WAR is created at `target/jsp-servlet-demo.war`. Copy it to Tomcat 10.1+'s `webapps` directory and start Tomcat. The example URLs are:

- `http://localhost:8080/jsp-servlet-demo/`
- `http://localhost:8080/jsp-servlet-demo/hello`

Java 17 and Maven must be installed locally. The Servlet and JSP APIs are declared with `provided` scope because Tomcat supplies them at runtime.
