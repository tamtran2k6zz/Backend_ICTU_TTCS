# USD to VND Converter

A Java 17 Maven WAR project for Apache Tomcat 10.1+. Enter an exchange rate and USD amount; the form sends both values using `POST` to `/convert`, where `ConverterServlet` validates and multiplies them with `BigDecimal`.

## Run

From this directory, build the application:

```bash
mvn clean package
```

Deploy `target/jsp-servlet-currency-converter.war` to Tomcat 10.1+'s `webapps` directory, start Tomcat, and open `http://localhost:8080/jsp-servlet-currency-converter/`.

The rate is entered manually for this exercise; no live exchange-rate service is used. Servlet and JSP APIs use Maven `provided` scope because Tomcat supplies them at runtime.
