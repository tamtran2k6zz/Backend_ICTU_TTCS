# [Thực hành] Tạo CSDL Quản lý sinh viên (QuanLySinhVien)

## 1. Mục tiêu
- Luyện tập tạo CSDL và thiết kế các bảng quan hệ đầy đủ trong hệ quản trị MySQL.
- Vận dụng thành thạo các loại ràng buộc (Constraints):
  - `PRIMARY KEY` & `AUTO_INCREMENT`
  - `NOT NULL`
  - `FOREIGN KEY` (Khóa ngoại)
  - `CHECK` (Kiểm tra điều kiện hợp lệ của dữ liệu)
  - `DEFAULT` (Giá trị mặc định)
  - `UNIQUE` (Ràng buộc duy nhất trên cặp thuộc tính)

---

## 2. Mô tả các bảng trong CSDL `QuanLySinhVien`

### 2.1. Bảng `Class` (Lớp học)
| Tên trường | Kiểu dữ liệu | Ràng buộc |
|:---|:---|:---|
| `ClassID` | `INT` | NOT NULL, PRIMARY KEY, AUTO_INCREMENT |
| `ClassName` | `VARCHAR(60)` | NOT NULL |
| `StartDate` | `DATETIME` | NOT NULL |
| `Status` | `BIT` | Trạng thái lớp học (1: Hoạt động, 0: Ngừng) |

### 2.2. Bảng `Student` (Sinh viên)
| Tên trường | Kiểu dữ liệu | Ràng buộc |
|:---|:---|:---|
| `StudentID` | `INT` | NOT NULL, PRIMARY KEY, AUTO_INCREMENT |
| `StudentName` | `VARCHAR(30)` | NOT NULL |
| `Address` | `VARCHAR(50)` | Địa chỉ sinh viên |
| `Phone` | `VARCHAR(20)` | Số điện thoại |
| `Status` | `BIT` | Trạng thái (1: Đang học, 0: Nghỉ học) |
| `ClassID` | `INT` | NOT NULL, FOREIGN KEY tham chiếu đến `Class(ClassID)` |

### 2.3. Bảng `Subject` (Môn học)
| Tên trường | Kiểu dữ liệu | Ràng buộc |
|:---|:---|:---|
| `SubID` | `INT` | NOT NULL, PRIMARY KEY, AUTO_INCREMENT |
| `SubName` | `VARCHAR(30)` | NOT NULL |
| `Credit` | `TINYINT` | NOT NULL, DEFAULT 1, CHECK (`Credit` >= 1) |
| `Status` | `BIT` | DEFAULT 1 |

### 2.4. Bảng `Mark` (Điểm thi)
| Tên trường | Kiểu dữ liệu | Ràng buộc |
|:---|:---|:---|
| `MarkID` | `INT` | NOT NULL, PRIMARY KEY, AUTO_INCREMENT |
| `SubID` | `INT` | NOT NULL, FOREIGN KEY tham chiếu đến `Subject(SubId)` |
| `StudentID` | `INT` | NOT NULL, FOREIGN KEY tham chiếu đến `Student(StudentId)` |
| `Mark` | `FLOAT` | DEFAULT 0, CHECK (`Mark` BETWEEN 0 AND 100) |
| `ExamTimes` | `TINYINT` | DEFAULT 1 (Số lần thi) |
| *Ràng buộc khác* | - | UNIQUE (`SubId`, `StudentId`) |

---

## 3. Sơ đồ thực thể liên kết (ERD)

```mermaid
erDiagram
    Class ||--o{ Student : "chứa (1,n)"
    Student ||--o{ Mark : "có kết quả (1,n)"
    Subject ||--o{ Mark : "thuộc môn (1,n)"

    Class {
        int ClassID PK
        varchar(60) ClassName
        datetime StartDate
        bit Status
    }

    Student {
        int StudentID PK
        varchar(30) StudentName
        varchar(50) Address
        varchar(20) Phone
        bit Status
        int ClassID FK
    }

    Subject {
        int SubID PK
        varchar(30) SubName
        tinyint Credit
        bit Status
    }

    Mark {
        int MarkID PK
        int SubID FK
        int StudentID FK
        float Mark
        tinyint ExamTimes
    }
```

---

## 4. Hướng dẫn thực thi

Mở MySQL Workbench, tạo truy vấn mới và chạy file [`quan_ly_sinh_vien.sql`](quan_ly_sinh_vien.sql).
Sau khi chạy, bảng và các liên kết khóa ngoại, điều kiện `CHECK`, `DEFAULT` sẽ được khởi tạo hoàn chỉnh.
