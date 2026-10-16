USE QuanLyBanHang;

-- 1. Tat ca hoa don: oPrice la ten hien thi cua cot oTotalPrice.
SELECT oID, oDate, oTotalPrice AS oPrice
FROM Orders
ORDER BY oID;

-- 2a. Danh sach khach hang da mua san pham (khong lap khach).
SELECT DISTINCT c.cID, c.cName, c.cAge
FROM Customer AS c
JOIN Orders AS o ON c.cID = o.cID
JOIN OrderDetail AS od ON o.oID = od.oID
ORDER BY c.cID;

-- 2b. Cac san pham tung khach da mua, moi cap khach-san pham mot dong.
SELECT DISTINCT c.cID, c.cName, p.pID, p.pName
FROM Customer AS c
JOIN Orders AS o ON c.cID = o.cID
JOIN OrderDetail AS od ON o.oID = od.oID
JOIN Product AS p ON od.pID = p.pID
ORDER BY c.cID, p.pID;

-- 3. Khach chua mua bat ky san pham nao, ke ca khach co hoa don rong.
SELECT c.cName
FROM Customer AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders AS o
    JOIN OrderDetail AS od ON o.oID = od.oID
    WHERE o.cID = c.cID
)
ORDER BY c.cID;

-- 4. Tinh tong tien tu so luong * don gia; giu ca hoa don chua co chi tiet.
SELECT o.oID, o.oDate, COALESCE(SUM(od.odQTY * p.pPrice), 0) AS oPrice
FROM Orders AS o
LEFT JOIN OrderDetail AS od ON o.oID = od.oID
LEFT JOIN Product AS p ON od.pID = p.pID
GROUP BY o.oID, o.oDate
ORDER BY o.oID;
