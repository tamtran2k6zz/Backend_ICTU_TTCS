<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="form-shell">
    <a class="back-link" href="${pageContext.request.contextPath}/products">← Danh sách sản phẩm</a>
    <section class="panel detail-panel">
        <div class="detail-heading">
            <div>
                <p class="eyebrow">Chi tiết sản phẩm · #${product.id}</p>
                <h1><c:out value="${product.name}"/></h1>
            </div>
            <span class="detail-price"><c:out value="${product.price}"/> ₫</span>
        </div>
        <dl class="detail-list">
            <dt>Nhà sản xuất</dt>
            <dd><c:out value="${product.manufacturer}"/></dd>
            <dt>Mô tả sản phẩm</dt>
            <dd class="description-value"><c:out value="${product.description}"/></dd>
        </dl>
        <div class="form-actions">
            <a class="button button-primary" href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Chỉnh sửa</a>
            <a class="button button-light" href="${pageContext.request.contextPath}/products">Quay lại</a>
        </div>
    </section>
</main>
</body>
</html>
