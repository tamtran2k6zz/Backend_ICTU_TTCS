<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%
    float rate = 0f;
    float usd = 0f;
    float vnd = 0f;
    String errorMessage = null;

    try {
        rate = Float.parseFloat(request.getParameter("rate"));
        usd = Float.parseFloat(request.getParameter("usd"));

        if (!Float.isFinite(rate) || !Float.isFinite(usd) || rate <= 0 || usd < 0) {
            throw new IllegalArgumentException("Values are outside the accepted range.");
        }

        vnd = rate * usd;
        if (!Float.isFinite(vnd)) {
            throw new IllegalArgumentException("The conversion result is too large.");
        }
    } catch (IllegalArgumentException exception) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        errorMessage = "Vui lòng nhập tỉ giá dương và lượng USD không âm bằng số hợp lệ.";
    }

    NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);
    numberFormat.setMinimumFractionDigits(2);
    numberFormat.setMaximumFractionDigits(2);
%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả chuyển đổi | MoneyDesk</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="converter-card result-card" aria-labelledby="result-title" aria-live="polite">
        <a class="brand" href="${pageContext.request.contextPath}/"><span class="brand-mark" aria-hidden="true">↗</span> MoneyDesk</a>
        <p class="eyebrow">JSP CURRENCY TOOL</p>
        <h1 id="result-title">Kết quả <span>chuyển đổi</span></h1>

        <% if (errorMessage == null) { %>
            <div class="result-details">
                <div><span>Tỉ giá hiện tại</span><strong><%= numberFormat.format(rate) %> VND/USD</strong></div>
                <div><span>Lượng USD yêu cầu</span><strong>$<%= numberFormat.format(usd) %></strong></div>
            </div>
            <div class="result-total">
                <span>THÀNH TIỀN</span>
                <strong><%= numberFormat.format(vnd) %> <small>VNĐ</small></strong>
            </div>
        <% } else { %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>

        <a class="back-button" href="${pageContext.request.contextPath}/">← Quay lại chuyển đổi</a>
    </section>
    <footer class="page-footer">Kết quả được tính trực tiếp bằng JSP Scriptlet và Expression</footer>
</main>
</body>
</html>
