<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả tra cứu | Từ điển Anh – Việt</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="dictionary-card result-card ${wordFound ? 'result-found' : 'result-missing'}" aria-labelledby="result-title" aria-live="polite">
        <a class="brand" href="${pageContext.request.contextPath}/"><span class="brand-mark" aria-hidden="true">Aa</span> Wordwise</a>
        <p class="eyebrow">KẾT QUẢ TRA CỨU</p>
        <h1 id="result-title">${wordFound ? 'Từ này có nghĩa là' : 'Chưa tìm thấy'}</h1>
        <p class="searched-word">${searchWord}</p>
        <p class="translation ${wordFound ? '' : 'd-none'}">${translation}</p>
        <p class="not-found-message ${wordFound ? 'd-none' : ''}">${message}</p>
        <a class="search-again" href="${pageContext.request.contextPath}/">← Tra từ khác</a>
    </section>
    <footer class="page-footer">Tra cứu đơn giản · Kết quả được xử lý bằng Jakarta Servlet</footer>
</main>
</body>
</html>
