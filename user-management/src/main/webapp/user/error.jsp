<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lỗi cơ sở dữ liệu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="form-shell">
    <section class="panel error-panel">
        <p class="eyebrow">Không thể hoàn tất yêu cầu</p>
        <h1>Lỗi cơ sở dữ liệu</h1>
        <p class="subtitle"><c:out value="${error}"/></p>
        <a class="button button-primary" href="${pageContext.request.contextPath}/users">Thử lại</a>
    </section>
</main>
</body>
</html>
