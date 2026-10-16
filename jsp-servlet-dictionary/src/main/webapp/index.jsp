<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Tra cứu nghĩa tiếng Việt của một số từ tiếng Anh cơ bản.">
    <title>Từ điển Anh – Việt</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="dictionary-card" aria-labelledby="page-title">
        <a class="brand" href="${pageContext.request.contextPath}/"><span class="brand-mark" aria-hidden="true">Aa</span> Wordwise</a>
        <p class="eyebrow">TỪ ĐIỂN ANH – VIỆT</p>
        <h1 id="page-title">Một từ mới, <span>một thế giới mới.</span></h1>
        <p class="intro">Nhập từ hoặc cụm từ tiếng Anh để xem nghĩa tiếng Việt.</p>

        <form action="${pageContext.request.contextPath}/translate" method="POST" class="search-form">
            <label class="visually-hidden" for="word">Từ tiếng Anh cần tra</label>
            <div class="search-input-wrap"><span class="search-icon" aria-hidden="true">⌕</span><input id="word" name="word" type="search" placeholder="Ví dụ: hello, book, computer..." autocomplete="off" required autofocus></div>
            <button class="search-button" type="submit">Tìm kiếm <span aria-hidden="true">→</span></button>
        </form>

        <div class="popular-words" aria-label="Một số từ có sẵn">
            <span>Thử tra:</span><kbd>hello</kbd><kbd>book</kbd><kbd>computer</kbd>
        </div>
        <div class="dictionary-note"><span class="note-mark" aria-hidden="true">i</span><span>Từ điển mẫu hoạt động với các từ có sẵn trong ứng dụng.</span></div>
    </section>
    <footer class="page-footer">Tra cứu đơn giản · Kết quả được xử lý bằng Jakarta Servlet</footer>
</main>
</body>
</html>
