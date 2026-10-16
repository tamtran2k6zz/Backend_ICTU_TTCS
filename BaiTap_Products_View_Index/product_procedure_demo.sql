USE demo_products_db;

-- Demo them, cap nhat va xoa mot san pham thu nghiem.
CALL addProduct(
    'DEMO-PROC-001', 'Procedure Demo', 19.99, 5,
    'Temporary row for procedure practice', 1
);
SET @demo_product_id = LAST_INSERT_ID();

CALL updateProduct(
    @demo_product_id, 'DEMO-PROC-001', 'Procedure Demo Updated', 24.99, 8,
    'Updated by updateProduct', 1
);

SELECT * FROM Products WHERE Id = @demo_product_id;

CALL deleteProduct(@demo_product_id);
SELECT * FROM Products WHERE Id = @demo_product_id;

-- Goi rieng de xem toan bo danh sach (1.000 dong):
-- CALL getAllProducts();
