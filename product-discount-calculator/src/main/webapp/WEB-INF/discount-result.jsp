<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Discount result | Product Discount Calculator</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="calculator-card result-card ${calculationSuccess ? 'result-success' : 'result-error'}" aria-labelledby="result-title" aria-live="polite">
        <a class="brand" href="${pageContext.request.contextPath}/"><span class="brand-mark" aria-hidden="true">%</span> Pricewise</a>
        <p class="eyebrow">YOUR PRICE SUMMARY</p>
        <h1 id="result-title">${calculationSuccess ? 'Discount calculated' : 'Check your details'}</h1>
        <p class="product-name ${calculationSuccess ? '' : 'd-none'}">${productDescription}</p>
        <div class="result-list ${calculationSuccess ? '' : 'd-none'}">
            <div class="result-row"><span>List Price</span><strong>$${listPrice}</strong></div>
            <div class="result-row"><span>Discount Percent</span><strong>${discountPercent}%</strong></div>
            <div class="result-row saving-row"><span>Discount Amount</span><strong>−$${discountAmount}</strong></div>
        </div>
        <div class="final-price ${calculationSuccess ? '' : 'd-none'}"><span>DISCOUNT PRICE</span><strong>$${discountPrice}</strong></div>
        <p class="error-message ${calculationSuccess ? 'd-none' : ''}">${errorMessage}</p>
        <a class="back-button" href="${pageContext.request.contextPath}/">Calculate another discount <span aria-hidden="true">→</span></a>
    </section>
    <footer class="page-footer">A simple Java Web form · Powered by Jakarta Servlet</footer>
</main>
</body>
</html>
