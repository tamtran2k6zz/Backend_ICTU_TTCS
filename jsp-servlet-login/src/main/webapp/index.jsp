<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Sign in to the JSP Servlet Demo.">
    <title>Sign in | JSP Servlet Demo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="login-card" aria-labelledby="page-title">
        <a class="brand" href="${pageContext.request.contextPath}/" aria-label="CodeGym home"><span class="brand-mark">C</span> CodeGym</a>
        <p class="eyebrow">JAVA WEB · JSP / SERVLET</p>
        <h1 id="page-title">Welcome back</h1>
        <p class="intro">Sign in to continue to your learning workspace.</p>

        <form action="${pageContext.request.contextPath}/login" method="POST" class="login-form">
            <div class="form-field">
                <label for="username">Username</label>
                <input id="username" name="username" type="text" autocomplete="username" placeholder="Enter your username" required>
            </div>
            <div class="form-field">
                <label for="password">Password</label>
                <input id="password" name="password" type="password" autocomplete="current-password" placeholder="Enter your password" required>
            </div>
            <button class="submit-button" type="submit">Sign in <span aria-hidden="true">→</span></button>
        </form>

        <p class="demo-hint">Demo credentials: <code>admin</code> / <code>admin</code></p>
    </section>
    <footer class="page-footer">A simple Jakarta Servlet POST exercise</footer>
</main>
</body>
</html>
