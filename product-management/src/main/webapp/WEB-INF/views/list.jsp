<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page-shell">
    <header class="page-header">
        <div>
            <p class="eyebrow">Kho hàng</p>
            <h1>Quản lý sản phẩm</h1>
            <p class="subtitle">Theo dõi thông tin và giá bán sản phẩm.</p>
        </div>
        <a class="button button-primary" href="${pageContext.request.contextPath}/products?action=create">+ Thêm sản phẩm</a>
    </header>

    <c:if test="${not empty param.message}">
        <div class="flash" role="status">
            <c:choose>
                <c:when test="${param.message == 'created'}">Đã thêm sản phẩm thành công.</c:when>
                <c:when test="${param.message == 'updated'}">Đã cập nhật sản phẩm thành công.</c:when>
                <c:when test="${param.message == 'deleted'}">Đã xóa sản phẩm thành công.</c:when>
            </c:choose>
        </div>
    </c:if>

    <section class="panel">
        <form class="search-form" action="${pageContext.request.contextPath}/products" method="get">
            <input type="hidden" name="action" value="search">
            <label class="visually-hidden" for="search">Tìm theo tên sản phẩm</label>
            <input id="search" name="q" type="search" placeholder="Tìm theo tên sản phẩm...">
            <button class="button button-secondary" type="submit">Tìm kiếm</button>
            <a class="reset-link" href="${pageContext.request.contextPath}/products">Xóa lọc</a>
        </form>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th scope="col">Sản phẩm</th>
                    <th scope="col">Giá</th>
                    <th scope="col">Nhà sản xuất</th>
                    <th scope="col" class="actions-heading">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>
                            <a class="product-name" href="${pageContext.request.contextPath}/products?action=view&id=${product.id}">
                                <c:out value="${product.name}"/>
                            </a>
                            <span class="product-description"><c:out value="${product.description}"/></span>
                        </td>
                        <td class="price"><c:out value="${product.price}"/> ₫</td>
                        <td><c:out value="${product.manufacturer}"/></td>
                        <td class="actions">
                            <a href="${pageContext.request.contextPath}/products?action=view&id=${product.id}">Xem</a>
                            <a href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Sửa</a>
                            <a class="delete-action" href="${pageContext.request.contextPath}/products?action=delete&id=${product.id}">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty products}">
                    <tr>
                        <td class="empty-state" colspan="4">
                            <strong>Không có sản phẩm phù hợp.</strong>
                            <span>Thử từ khóa khác hoặc thêm sản phẩm mới.</span>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <footer class="panel-footer"><c:out value="${products.size()}"/> sản phẩm</footer>
    </section>
</main>
</body>
</html>
