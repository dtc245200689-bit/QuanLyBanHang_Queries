-- 1. ĐẢM BẢO SỬ DỤNG ĐÚNG CƠ SỞ DỮ LIỆU
USE QuanLyBanHang;

-- Xóa dữ liệu cũ nếu có để tránh trùng lặp khi chạy lại
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE OrderDetail;
TRUNCATE TABLE `Order`;
TRUNCATE TABLE Product;
TRUNCATE TABLE Customer;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. CHÈN DỮ LIỆU VÀO CÁC BẢNG

-- Chèn dữ liệu bảng Customer
INSERT INTO Customer (cID, Name, cAge) VALUES 
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- Chèn dữ liệu bảng Product
INSERT INTO Product (pID, pName, pPrice) VALUES 
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- Chèn dữ liệu bảng Order
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES 
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- Chèn dữ liệu bảng OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES 
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);


-- ===============================================================
-- 3. CÁC CÂU LỆNH TRUY VẤN THEO YÊU CẦU
-- ===============================================================

-- Yêu cầu 1: Hiển thị các thông tin gồm oID, oDate, oTotalPrice của tất cả các hóa đơn trong bảng Order
SELECT oID, oDate, oTotalPrice 
FROM `Order`;

-- Yêu cầu 2: Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT c.Name AS CustomerName, p.pName AS ProductName
FROM Customer c
JOIN `Order` o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;

-- Yêu cầu 3: Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT Name 
FROM Customer
WHERE cID NOT IN (SELECT DISTINCT cID FROM `Order`);

-- Yêu cầu 4: Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn 
-- (Giá bán của từng loại được tính = odQTY * pPrice)
SELECT 
    o.oID, 
    o.oDate, 
    SUM(od.odQTY * p.pPrice) AS total_price
FROM `Order` o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;
