<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xóa User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="form-shell">
    <section class="panel confirm-panel">
        <div class="warning-icon" aria-hidden="true">!</div>
        <p class="eyebrow">Xác nhận thao tác</p>
        <h1>Xóa User?</h1>
        <p class="subtitle">Bạn có chắc muốn xóa <strong><c:out value="${user.name}"/></strong> khỏi danh sách?</p>
        <div class="confirm-details">
            <span>Email</span><strong><c:out value="${user.email}"/></strong>
            <span>Quốc gia</span><strong><c:out value="${user.country}"/></strong>
        </div>
        <form class="form-actions" action="${pageContext.request.contextPath}/users" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" value="${user.id}">
            <button class="button button-danger" type="submit">Xóa User</button>
            <a class="button button-light" href="${pageContext.request.contextPath}/users">Hủy</a>
        </form>
    </section>
</main>
</body>
</html>
