<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <header class="page-header">
        <div>
            <p class="eyebrow">Quản trị</p>
            <h1>Người dùng</h1>
            <p class="subtitle">Quản lý thông tin và quốc gia của người dùng.</p>
        </div>
        <a class="button button-primary" href="${pageContext.request.contextPath}/users?action=create">+ Thêm User</a>
    </header>

    <c:if test="${not empty param.message}">
        <div class="flash" role="status">
            <c:choose>
                <c:when test="${param.message == 'create'}">Đã thêm User thành công.</c:when>
                <c:when test="${param.message == 'edit'}">Đã cập nhật User thành công.</c:when>
                <c:when test="${param.message == 'delete'}">Đã xóa User thành công.</c:when>
            </c:choose>
        </div>
    </c:if>

    <section class="panel">
        <form class="filter-form" action="${pageContext.request.contextPath}/users" method="get">
            <input type="hidden" name="action" value="search">
            <label for="country">Tìm theo quốc gia</label>
            <input id="country" name="country" type="search" maxlength="120"
                   placeholder="Nhập tên quốc gia..." value="<c:out value='${countryFilter}'/>">
            <input type="hidden" name="sort" value="${sortOrder}">
            <button class="button button-secondary" type="submit">Tìm kiếm</button>
            <a class="reset-link" href="${pageContext.request.contextPath}/users">Xóa lọc</a>
        </form>

        <c:url var="sortAscUrl" value="/users">
            <c:param name="action" value="sort"/>
            <c:param name="country" value="${countryFilter}"/>
            <c:param name="sort" value="ASC"/>
        </c:url>
        <c:url var="sortDescUrl" value="/users">
            <c:param name="action" value="sort"/>
            <c:param name="country" value="${countryFilter}"/>
            <c:param name="sort" value="DESC"/>
        </c:url>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Tên User
                        <span class="sort-links">
                            <a href="${sortAscUrl}" aria-label="Sắp xếp tên tăng dần">↑</a>
                            <a href="${sortDescUrl}" aria-label="Sắp xếp tên giảm dần">↓</a>
                        </span>
                    </th>
                    <th scope="col">Email</th>
                    <th scope="col">Quốc gia</th>
                    <th scope="col">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${listUser}">
                    <tr>
                        <td class="id-cell">#<c:out value="${user.id}"/></td>
                        <td class="user-name"><c:out value="${user.name}"/></td>
                        <td><c:out value="${user.email}"/></td>
                        <td><span class="country-tag"><c:out value="${user.country}"/></span></td>
                        <td class="actions">
                            <a href="${pageContext.request.contextPath}/users?action=edit&id=${user.id}">Sửa</a>
                            <a class="delete-action" href="${pageContext.request.contextPath}/users?action=delete&id=${user.id}">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listUser}">
                    <tr><td class="empty-state" colspan="5">Không tìm thấy User phù hợp.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <footer class="panel-footer"><c:out value="${fn:length(listUser)}"/> người dùng</footer>
    </section>
</main>
</body>
</html>
