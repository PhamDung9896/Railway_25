DROP DATABASE IF EXISTS testing_system_assignment_4;
CREATE DATABASE testing_system_assignment_4;
USE testing_system_assignment_2;

-- (Sử dụng subquery hoặc CTE)
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale->S5
-- Subquery --
DROP VIEW IF EXISTS Danh_sach_nhan_vien_phong_S5;
CREATE VIEW Danh_sach_nhan_vien_phong_S5 AS
SELECT A.AccountID, A.Username, A.FullName
FROM `Account` AS A
JOIN Department AS D ON A.DepartmentID=D.DepartmentID
WHERE D.DepartmentName='S5';
-- CTE -- ???
WITH Danh_sach_nhan_vien_phong_S5 AS(
SELECT A.*,D.DepartmentName
FROM `Account` AS A
INNER JOIN Department AS D ON A.DepartmentID=D.DepartmentID
WHERE D.DepartmentID='S5'
)
SELECT *
FROM Danh_sach_nhan_vien_phong_S5;


-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
WITH Nguoi_tham_gia_nhieu_nhom_nhat AS(
SELECT count(GAcc.AccountID) AS CGA FROM GroupAccount AS Gacc
GROUP BY Gacc.AccountID
) -- CTE
SELECT A.AccountID, A.Username, count(GA.AccountID) AS So_Luong_nhom_tham_gia FROM GroupAccount GA
INNER JOIN account A ON GA.AccountID = A.AccountID
GROUP BY GA.AccountID
HAVING count(GA.AccountID) = (SELECT MAX(CGA) AS maxCount 
							  FROM Nguoi_tham_gia_nhieu_nhom_nhat
);


-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
CREATE OR REPLACE VIEW noi_dung_qua_lon AS
SELECT *
FROM Question
WHERE LENGTH(Content) > 18;
SELECT *
FROM noi_dung_qua_lon;
DELETE 
FROM noi_dung_qua_lon;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE OR REPLACE VIEW Phong_ban_co_nhieu_nhan_vien_nhat AS
SELECT D.DepartmentName, count(A.DepartmentID) AS So_luong
FROM `Account` AS A
INNER JOIN `Department` AS D ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING count(A.DepartmentID) = (SELECT MAX(so_phong_ban) AS luong_phong_ban_nhieu_nhat 
								FROM (SELECT count(A1.DepartmentID) AS so_phong_ban
                                FROM `account` AS A1
								GROUP BY A1.DepartmentID) AS CADI);
SELECT * FROM Phong_ban_co_nhieu_nhan_vien_nhat;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE OR REPLACE VIEW Cau_hoi_cua_Nguyen AS
SELECT Q.CategoryID, Q.Content, A.FullName AS Creator FROM Question Q
INNER JOIN `account`AS A ON A.AccountID = Q.CreatorID
WHERE SUBSTRING_INDEX( A.FullName, ' .', 1 ) = 'Nguyen'; -- SUBSTRING_INDEX la gi?????//?
SELECT * FROM Cau_hoi_cua_Nguyen;






