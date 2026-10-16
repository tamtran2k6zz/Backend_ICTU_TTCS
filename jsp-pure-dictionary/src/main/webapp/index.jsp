<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Từ điển Anh – Việt</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="card">
    <p class="eyebrow">Tra cứu nhanh</p>
    <h1>Từ điển Anh – Việt</h1>
    <p class="intro">Nhập một từ tiếng Anh để xem nghĩa tiếng Việt.</p>

    <form action="${pageContext.request.contextPath}/dictionary.jsp" method="post">
        <label for="search">Từ tiếng Anh</label>
        <input id="search" name="search" type="text" placeholder="Ví dụ: hello" required autofocus>
        <button type="submit">Tìm kiếm</button>
    </form>

    <p class="examples">Từ mẫu: hello, book, computer, student</p>
</main>
</body>
</html>
