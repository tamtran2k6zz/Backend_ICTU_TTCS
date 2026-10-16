<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.ZonedDateTime, java.time.format.DateTimeFormatter, java.util.Locale" %>
<%
    ZonedDateTime serverNow = ZonedDateTime.now();
    String formattedTime = serverNow.format(
            DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy 'at' HH:mm:ss z", Locale.ENGLISH));
    String serverZone = serverNow.getZone().getId();
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="A simple JSP page that displays the current server time.">
    <title>Server Time | JSP Servlet Demo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="time-card" aria-labelledby="page-title">
        <div class="brand-mark" aria-hidden="true">CG</div>
        <p class="eyebrow">JAVA WEB · JSP / SERVLET</p>
        <h1 id="page-title">Your server, <span>right now.</span></h1>
        <p class="intro">A small window into the system clock powering this application.</p>

        <div class="time-panel" aria-live="polite">
            <span class="time-label">CURRENT SERVER TIME</span>
            <time datetime="<%= serverNow.toOffsetDateTime() %>"><%= formattedTime %></time>
            <span class="timezone-label">Server timezone: <%= serverZone %></span>
        </div>

        <div class="card-footer">
            <p>Time is generated on the server when this page loads.</p>
            <a class="button-link" href="${pageContext.request.contextPath}/hello">Test HelloServlet <span aria-hidden="true">→</span></a>
        </div>
    </section>
    <footer class="page-footer">Built with Java 17 · Jakarta Servlet 6 · Tomcat 10.1+</footer>
</main>
</body>
</html>
