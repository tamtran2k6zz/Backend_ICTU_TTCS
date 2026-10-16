# JSP Servlet Login

A small Maven WAR application for Java 17 and Apache Tomcat 10.1+. The login form posts `username` and `password` to `/login`; `LoginServlet` accepts `admin` / `admin` and displays the required success or error message.

## Build and deploy

From this directory, run:

```bash
mvn clean package
```

Deploy `target/jsp-servlet-login.war` to Tomcat 10.1+'s `webapps` directory. Open `http://localhost:8080/jsp-servlet-login/` and try both valid and invalid credentials.

The credentials are hardcoded for this exercise only. Servlet and JSP APIs use `provided` scope because Tomcat supplies them at runtime.
