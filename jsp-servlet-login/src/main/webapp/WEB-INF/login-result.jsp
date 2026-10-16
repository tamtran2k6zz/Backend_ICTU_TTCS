<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign in result | JSP Servlet Demo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="result-card ${loginSuccess ? 'result-success' : 'result-error'}" aria-labelledby="result-title" aria-live="polite">
        <div class="result-mark" aria-hidden="true">${loginSuccess ? '✓' : '!'}</div>
        <p class="eyebrow">SIGN IN RESULT</p>
        <h1 id="result-title">${loginSuccess ? 'Welcome admin to website' : 'Login Error'}</h1>
        <p class="intro">${loginSuccess ? 'You signed in successfully.' : 'The username or password was incorrect. Please try again.'}</p>
        <a class="submit-button back-button" href="${pageContext.request.contextPath}/">Back to sign in <span aria-hidden="true">→</span></a>
    </section>
    <footer class="page-footer">A simple Jakarta Servlet POST exercise</footer>
</main>
</body>
</html>
