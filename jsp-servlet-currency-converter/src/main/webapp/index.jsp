<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Chuyển đổi USD sang VNĐ theo tỉ giá bạn nhập.">
    <title>Chuyển đổi tiền tệ | USD sang VNĐ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="converter-card" aria-labelledby="page-title">
        <a class="brand" href="${pageContext.request.contextPath}/"><span class="brand-mark" aria-hidden="true">↗</span> MoneyDesk</a>
        <p class="eyebrow">CÔNG CỤ CHUYỂN ĐỔI</p>
        <h1 id="page-title">USD <span class="exchange-arrow" aria-hidden="true">⇄</span> VND</h1>
        <p class="intro">Nhập tỉ giá và số USD để tính số tiền quy đổi sang Việt Nam đồng.</p>

        <form action="${pageContext.request.contextPath}/convert" method="POST" class="converter-form">
            <div class="form-field">
                <label for="rate">Tỉ giá <span>(VND / USD)</span></label>
                <div class="input-wrap"><input id="rate" name="rate" type="number" min="0.000001" step="any" value="25000" inputmode="decimal" required><span class="input-suffix">VND</span></div>
                <small>Một USD đổi được bao nhiêu đồng Việt Nam?</small>
            </div>
            <div class="form-field">
                <label for="usd">Lượng USD muốn đổi</label>
                <div class="input-wrap"><span class="input-prefix">$</span><input id="usd" name="usd" type="number" min="0" step="any" value="100" inputmode="decimal" required></div>
                <small>Bạn có thể nhập số thập phân, ví dụ 12.50.</small>
            </div>
            <button class="convert-button" type="submit">Chuyển đổi <span aria-hidden="true">→</span></button>
        </form>

        <p class="rate-note"><span class="info-icon" aria-hidden="true">i</span> Tỉ giá do bạn nhập và có thể thay đổi tùy nhu cầu.</p>
    </section>
    <footer class="page-footer">Tính toán được xử lý bởi Java Servlet · Kết quả hiển thị bằng VNĐ</footer>
</main>
</body>
</html>
