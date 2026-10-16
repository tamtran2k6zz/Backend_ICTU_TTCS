<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="form-shell">
    <a class="back-link" href="${pageContext.request.contextPath}/users">← Danh sách User</a>
    <section class="panel form-panel">
        <p class="eyebrow">Quản trị người dùng</p>
        <h1>Thêm User mới</h1>
        <p class="subtitle">Nhập thông tin người dùng cần thêm.</p>
        <c:if test="${not empty error}"><div class="form-error" role="alert"><c:out value="${error}"/></div></c:if>
        <form class="user-form" action="${pageContext.request.contextPath}/users" method="post">
            <input type="hidden" name="action" value="create">
            <label for="name">Tên đầy đủ</label>
            <input id="name" name="name" type="text" maxlength="120" required value="<c:out value='${user.name}'/>">
            <label for="email">Email</label>
            <input id="email" name="email" type="email" maxlength="220" required value="<c:out value='${user.email}'/>">
            <label for="country">Quốc gia</label>
            <input id="country" name="country" type="text" maxlength="120" required value="<c:out value='${user.country}'/>">
            <div class="form-actions">
                <button class="button button-primary" type="submit">Lưu User</button>
                <a class="button button-light" href="${pageContext.request.contextPath}/users">Hủy</a>
            </div>
        </form>
    </section>
</main>
</body>
</html>
