<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả chuyển đổi | USD sang VNĐ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="converter-card result-card ${conversionSuccess ? 'result-success' : 'result-error'}" aria-labelledby="result-title" aria-live="polite">
        <a class="brand" href="${pageContext.request.contextPath}/"><span class="brand-mark" aria-hidden="true">↗</span> MoneyDesk</a>
        <p class="eyebrow">KẾT QUẢ CHUYỂN ĐỔI</p>
        <h1 id="result-title">${conversionSuccess ? 'Đã quy đổi xong' : 'Kiểm tra lại dữ liệu'}</h1>

        <div class="result-amount ${conversionSuccess ? '' : 'd-none'}">
            <span>THÀNH TIỀN</span>
            <strong>${vndFormatted} <small>₫</small></strong>
        </div>
        <dl class="calculation-list ${conversionSuccess ? '' : 'd-none'}">
            <div><dt>Số tiền quy đổi</dt><dd>$${usdFormatted}</dd></div>
            <div><dt>Tỉ giá áp dụng</dt><dd>${rateFormatted} VND/USD</dd></div>
        </dl>
        <p class="error-message ${conversionSuccess ? 'd-none' : ''}">${errorMessage}</p>

        <a class="convert-button back-button" href="${pageContext.request.contextPath}/">Quay lại chuyển đổi <span aria-hidden="true">→</span></a>
    </section>
    <footer class="page-footer">Tính toán được xử lý bởi Java Servlet · Kết quả hiển thị bằng VNĐ</footer>
</main>
</body>
</html>
