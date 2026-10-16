# Product Discount Calculator

A Java 17 Maven WAR project for Apache Tomcat 10.1+. Enter a product description, list price, and discount percentage. The form submits with `POST` to `/display-discount`; `DiscountServlet` validates the inputs, calculates the discount amount and discounted price, and forwards the result to a JSP page.

## Run

From this directory, build the application:

```bash
mvn clean package
```

Deploy `target/product-discount-calculator.war` to Tomcat 10.1+'s `webapps` directory and open `http://localhost:8080/product-discount-calculator/`.

Prices are displayed as numeric amounts with two decimal places. The discount percentage must be between 0 and 100.
