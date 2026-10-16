<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    java.util.List<java.util.Map<String, String>> customers = new java.util.ArrayList<>();

    customers.add(java.util.Map.of(
            "name", "Nguyễn Thị Lan",
            "birthDate", "12/03/1995",
            "address", "Ba Đình, Hà Nội",
            "image", "https://i.pravatar.cc/120?img=47"));
    customers.add(java.util.Map.of(
            "name", "Trần Minh Quân",
            "birthDate", "24/08/1992",
            "address", "Hải Châu, Đà Nẵng",
            "image", "https://i.pravatar.cc/120?img=12"));
    customers.add(java.util.Map.of(
            "name", "Lê Hoàng Mai",
            "birthDate", "05/11/1998",
            "address", "Quận 3, TP. Hồ Chí Minh",
            "image", "https://i.pravatar.cc/120?img=44"));
    customers.add(java.util.Map.of(
            "name", "Phạm Đức Anh",
            "birthDate", "17/06/1990",
            "address", "Ninh Kiều, Cần Thơ",
            "image", "https://i.pravatar.cc/120?img=13"));

    request.setAttribute("customers", customers);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="page">
    <header class="page-header">
        <div>
            <p class="eyebrow">Quản lý khách hàng</p>
            <h1>Danh sách khách hàng</h1>
            <p class="subtitle">Thông tin liên hệ và hồ sơ khách hàng.</p>
        </div>
        <span class="customer-count"><c:out value="${customers.size()}"/> khách hàng</span>
    </header>

    <section class="customer-panel" aria-label="Danh sách khách hàng">
        <div class="table-scroll">
            <table>
                <thead>
                <tr>
                    <th scope="col">Khách hàng</th>
                    <th scope="col">Ngày sinh</th>
                    <th scope="col">Địa chỉ</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="customer" items="${customers}">
                    <tr>
                        <td>
                            <div class="customer-cell">
                                <img class="avatar" src="<c:out value='${customer.image}'/>"
                                     alt="Ảnh của <c:out value='${customer.name}'/>" width="48" height="48">
                                <span class="customer-name"><c:out value="${customer.name}"/></span>
                            </div>
                        </td>
                        <td><c:out value="${customer.birthDate}"/></td>
                        <td><c:out value="${customer.address}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <p class="list-note">Danh sách minh họa được khai báo sẵn trong trang JSP.</p>
    </section>
</main>
</body>
</html>
