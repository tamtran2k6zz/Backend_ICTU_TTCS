# JSP Currency Converter

A Java 17 Maven WAR project for Apache Tomcat 10.1+. The form on `index.jsp` sends the exchange rate and USD amount with `POST` to `converter.jsp`. That JSP uses a Scriptlet to parse, validate, and calculate the conversion, then Expressions to display the result.

## Run

From this directory, build the application:

```bash
mvn clean package
```

Deploy `target/jsp-currency-converter.war` to Tomcat 10.1+'s `webapps` directory. Open `http://localhost:8080/jsp-currency-converter/` to use the converter.
