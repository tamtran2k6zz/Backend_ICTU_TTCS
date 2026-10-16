<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Máy tính</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<main class="calculator-card">
    <p class="eyebrow">Công cụ tính toán</p>
    <h1>Máy tính cơ bản</h1>
    <p class="description">Nhập hai số và chọn phép tính bạn muốn thực hiện.</p>

    <form action="${pageContext.request.contextPath}/calculator" method="post">
        <label for="firstOperand">Số thứ nhất</label>
        <input id="firstOperand" name="firstOperand" type="number" step="any" placeholder="Ví dụ: 12" required autofocus>

        <label for="operator">Phép tính</label>
        <select id="operator" name="operator" required>
            <option value="+">Cộng (+)</option>
            <option value="-">Trừ (−)</option>
            <option value="*">Nhân (×)</option>
            <option value="/">Chia (÷)</option>
        </select>

        <label for="secondOperand">Số thứ hai</label>
        <input id="secondOperand" name="secondOperand" type="number" step="any" placeholder="Ví dụ: 3" required>

        <button type="submit">Tính kết quả</button>
    </form>
</main>
</body>
</html>
