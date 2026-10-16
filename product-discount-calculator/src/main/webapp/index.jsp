<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Calculate your product discount and final price.">
    <title>Product Discount Calculator</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <section class="calculator-card" aria-labelledby="page-title">
        <a class="brand" href="${pageContext.request.contextPath}/"><span class="brand-mark" aria-hidden="true">%</span> Pricewise</a>
        <p class="eyebrow">SMARTER SHOPPING STARTS HERE</p>
        <h1 id="page-title">Product discount <span>calculator</span></h1>
        <p class="intro">Add the product details below to see your savings and final price.</p>

        <form action="${pageContext.request.contextPath}/display-discount" method="POST" class="calculator-form">
            <div class="form-field">
                <label for="productDescription">Product Description</label>
                <input id="productDescription" name="productDescription" type="text" placeholder="e.g. Wireless headphones" autocomplete="off" required>
            </div>
            <div class="form-grid">
                <div class="form-field">
                    <label for="listPrice">List Price</label>
                    <div class="input-with-prefix"><span aria-hidden="true">$</span><input id="listPrice" name="listPrice" type="number" min="0" step="0.01" placeholder="129.99" inputmode="decimal" required></div>
                </div>
                <div class="form-field">
                    <label for="discountPercent">Discount Percent</label>
                    <div class="input-with-suffix"><input id="discountPercent" name="discountPercent" type="number" min="0" max="100" step="0.01" placeholder="15" inputmode="decimal" required><span aria-hidden="true">%</span></div>
                </div>
            </div>
            <button class="calculate-button" type="submit">Calculate Discount <span aria-hidden="true">→</span></button>
        </form>
        <p class="formula-note">Your discount and final price are calculated instantly from the values you enter.</p>
    </section>
    <footer class="page-footer">A simple Java Web form · Powered by Jakarta Servlet</footer>
</main>
</body>
</html>
