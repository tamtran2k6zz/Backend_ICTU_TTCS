<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="form-shell">
    <a class="back-link" href="${pageContext.request.contextPath}/products">← Danh sách sản phẩm</a>
    <section class="panel form-panel">
        <p class="eyebrow">Kho hàng</p>
        <h1>Thêm sản phẩm</h1>
        <p class="subtitle">Điền thông tin sản phẩm mới.</p>
        <c:if test="${not empty error}"><div class="form-error" role="alert"><c:out value="${error}"/></div></c:if>
        <form class="product-form" action="${pageContext.request.contextPath}/products" method="post">
            <input type="hidden" name="action" value="create">
            <label for="name">Tên sản phẩm</label>
            <input id="name" name="name" type="text" maxlength="120" required value="<c:out value='${formName}'/>">
            <label for="price">Giá sản phẩm (₫)</label>
            <input id="price" name="price" type="number" min="0" step="0.01" required value="<c:out value='${formPrice}'/>">
            <label for="manufacturer">Nhà sản xuất</label>
            <input id="manufacturer" name="manufacturer" type="text" maxlength="120" required value="<c:out value='${formManufacturer}'/>">
            <label for="description">Mô tả</label>
            <textarea id="description" name="description" rows="4" maxlength="1000"><c:out value="${formDescription}"/></textarea>
            <div class="form-actions">
                <button class="button button-primary" type="submit">Lưu sản phẩm</button>
                <a class="button button-light" href="${pageContext.request.contextPath}/products">Hủy</a>
            </div>
        </form>
    </section>
</main>
</body>
</html>
