# English–Vietnamese Dictionary

A small Java 17 Maven WAR project for Apache Tomcat 10.1+. Search terms are submitted via `POST` to `/translate` and looked up case-insensitively in a built-in `Map`. The JSP result page shows the Vietnamese meaning or a not-found message.

## Run

From this directory, build the application:

```bash
mvn clean package
```

Deploy `target/jsp-servlet-dictionary.war` to Tomcat 10.1+'s `webapps` directory. Open `http://localhost:8080/jsp-servlet-dictionary/`. Sample entries include `hello`, `book`, `computer`, `student`, and `good morning`.

Servlet and JSP APIs use Maven `provided` scope because Tomcat supplies them at runtime.
