<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xóa sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="form-shell">
    <section class="panel confirm-panel">
        <div class="warning-icon" aria-hidden="true">!</div>
        <p class="eyebrow">Xác nhận thao tác</p>
        <h1>Xóa sản phẩm?</h1>
        <p class="subtitle">Bạn có chắc muốn xóa <strong><c:out value="${product.name}"/></strong>? Thao tác này không thể hoàn tác.</p>
        <div class="confirm-product">
            <span>Mã sản phẩm</span><strong>#${product.id}</strong>
            <span>Nhà sản xuất</span><strong><c:out value="${product.manufacturer}"/></strong>
        </div>
        <form class="form-actions" action="${pageContext.request.contextPath}/products" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" value="${product.id}">
            <button class="button button-danger" type="submit">Xóa sản phẩm</button>
            <a class="button button-light" href="${pageContext.request.contextPath}/products">Giữ lại</a>
        </form>
    </section>
</main>
</body>
</html>
