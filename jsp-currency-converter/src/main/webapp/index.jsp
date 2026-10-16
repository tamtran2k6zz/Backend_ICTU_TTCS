<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Đổi USD sang VNĐ bằng tỉ giá bạn chọn.">
    <title>USD to VND Converter | JSP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="converter-card" aria-labelledby="page-title">
        <a class="brand" href="${pageContext.request.contextPath}/"><span class="brand-mark" aria-hidden="true">↗</span> MoneyDesk</a>
        <p class="eyebrow">JSP CURRENCY TOOL</p>
        <h1 id="page-title">USD <span class="exchange-arrow" aria-hidden="true">⇄</span> VND</h1>
        <p class="intro">Nhập tỉ giá và số tiền bạn muốn đổi. Kết quả sẽ được tính ngay trên trang JSP.</p>

        <form action="${pageContext.request.contextPath}/converter.jsp" method="POST" class="converter-form">
            <div class="form-field">
                <label for="rate">Tỉ giá <span>(VND / USD)</span></label>
                <div class="input-wrap"><input id="rate" name="rate" type="number" min="0.000001" step="any" value="25000" inputmode="decimal" required><span class="input-suffix">VND</span></div>
                <small>Số tiền VND tương ứng với 1 USD.</small>
            </div>
            <div class="form-field">
                <label for="usd">Lượng USD cần đổi</label>
                <div class="input-wrap"><span class="input-prefix">$</span><input id="usd" name="usd" type="number" min="0" step="any" placeholder="Ví dụ: 100" inputmode="decimal" required></div>
                <small>Nhập số USD, có thể dùng phần thập phân.</small>
            </div>
            <button class="convert-button" type="submit">Tính toán <span aria-hidden="true">→</span></button>
        </form>

        <p class="method-note"><span aria-hidden="true">i</span> Dữ liệu được gửi bằng POST và xử lý bằng JSP Scriptlet.</p>
    </section>
    <footer class="page-footer">JSP Currency Converter · Tomcat 10.1+</footer>
</main>
</body>
</html>
