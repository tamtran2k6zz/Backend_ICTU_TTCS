<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    Map<String, String> dictionary = new HashMap<>();
    dictionary.put("hello", "Xin chào");
    dictionary.put("how", "Thế nào");
    dictionary.put("book", "Quyển sách");
    dictionary.put("computer", "Máy tính");
    dictionary.put("student", "Sinh viên");

    String searchWord = request.getParameter("search");
    String normalizedWord = searchWord == null ? "" : searchWord.trim();
    String result = dictionary.get(normalizedWord.toLowerCase(Locale.ROOT));
    String escapedWord = normalizedWord
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả tra cứu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="card result-card">
    <p class="eyebrow">Từ điển Anh – Việt</p>
    <h1>Kết quả tra cứu</h1>

    <% if (normalizedWord.isEmpty()) { %>
        <div class="notice notice-error" role="status">
            Vui lòng nhập từ tiếng Anh cần tra cứu.
        </div>
    <% } else if (result != null) { %>
        <p class="searched-word">Từ cần tra: <strong><%= escapedWord %></strong></p>
        <div class="notice notice-success" role="status">
            <span>Nghĩa tiếng Việt</span>
            <strong class="translation"><%= result %></strong>
        </div>
    <% } else { %>
        <div class="notice notice-error" role="status">
            Không tìm thấy từ <strong><%= escapedWord %></strong> trong từ điển.
        </div>
    <% } %>

    <a class="back-link" href="${pageContext.request.contextPath}/index.jsp">Quay lại tra cứu</a>
</main>
</body>
</html>
