<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả phép tính</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="calculator-card result-card">
    <p class="eyebrow">Kết quả</p>
    <h1>Phép tính của bạn</h1>

    <% if (request.getAttribute("error") != null) { %>
        <div class="message message-error" role="alert">
            <strong>Không thể thực hiện phép tính</strong>
            <p>${error}</p>
        </div>
    <% } else if (request.getAttribute("result") != null) { %>
        <p class="equation">${firstOperand} ${operator} ${secondOperand}</p>
        <div class="message message-success" role="status">
            <span>Kết quả</span>
            <strong>${result}</strong>
        </div>
    <% } else { %>
        <div class="message message-error" role="alert">
            Không có dữ liệu phép tính. Hãy nhập hai số và thử lại.
        </div>
    <% } %>

    <a class="back-link" href="${pageContext.request.contextPath}/index.jsp">Quay lại máy tính</a>
</main>
</body>
</html>
