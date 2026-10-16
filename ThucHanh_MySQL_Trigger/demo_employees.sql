USE company;

-- Chay mot lan tren bang employees chua co ba nhan vien demo.
INSERT INTO employees (name, department, salary)
VALUES ('John Doe', 'A', 3500),
       ('Jane Smith', 'A', 2000),
       ('David Johnson', 'A', 6000);

-- Kiem tra phong ban da duoc trigger gan tu dong.
SELECT id, name, department, salary
FROM employees
WHERE name IN ('John Doe', 'Jane Smith', 'David Johnson')
ORDER BY id;
