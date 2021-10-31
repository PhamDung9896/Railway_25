DROP DATABASE IF EXISTS testing_system_assignment_3;
CREATE DATABASE testing_system_assignment_3;
USE testing_system_assignment_2;

#NOTES:
-- Nhung du lieu de khoa PRIMARY KEY AUTO_INCREMENT thi ko can INSERT nua
-- Nhung loi da gap Error Code: 1062. Duplicate entry 'A1' for key 'department.DepartmentName'=>????
-- 					Error Code: 1136. Column count doesn't match value count at row 1=>check lai cac du lieu
-- 					Error Code: 1049. Unknown database 'testing_system_assignment_2'=>phai chay lai thu cac cau lenh
-- 					Error Code: 1146. Table 'testing_system_assignment_2.department' doesn't exist=>phai chay lai thu cac cau lenh
-- 					Error Code: 1050. Table 'position' already exists=>????
-- 					Error Code: 1062. Duplicate entry 'Help_Desk_Specialist' for key 'position.PositionName'
-- 					Error Code: 3819. Check constraint 'account_chk_1' is violated.
-- 					Error Code: 1364. Field 'GroupID' doesn't have a default value->lúc mà mình đặt giá trị not null cho cột nào đó trong 1 bảng thì lúc insert mọi dữ liệu liên quan đến bảng đó mình đều phải thêm cột có giá trị not null vào



-- Chu y su dong nhat giua du lieu cu va du lieu moi, neu trong truong hop muon dung lai du lieu cua bt truoc
              
                    
-- Question 2: lấy ra tất cả các phòng ban
SELECT *
FROM Department;

-- Question 3: lấy ra id của phòng ban "Sale"
SELECT DepartmentID
FROM Department
WHERE DepartmentName='Sale';

-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT FullName,length(FullName) AS do_dai_ten
FROM `Account`
WHERE length(FullName)= (SELECT max(length(FullName)) FROM `account`);
						

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT 		DepartmentID,FullName,length(FullName) AS do_dai_ten
FROM 		`Account`
WHERE 		DepartmentID=3 AND length(FullName)= (SELECT max(length(FullName))
												  FROM `account`
                                                  WHERE DepartmentID=3);

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT		GroupName
FROM		`Group`
WHERE		CreateDate <'2019/12/20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT		QuestionID, count(QuestionID) AS So_luong
FROM		Answer
GROUP BY	QuestionID
HAVING 		count(QuestionID)>=4;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT		`Code`
FROM		Exam
WHERE		Duration>=60 AND CreateDate<'2019/12/20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT		*
FROM		`Group`
ORDER BY	CreateDate DESC
LIMIT		5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT DepartmentID,
COUNT(AccountID) AS so_luong
FROM `Account`
WHERE DepartmentID=2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT FullName
FROM	`Account`
WHERE	FullName LIKE 'D%o';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE
FROM	Exam;

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE
FROM	Question
WHERE	Content='câu hỏi';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `Account`
SET		FullName='Nguyen Ba Loc',
		Email='thanhloc.nguyenba@vti.com.vn'
WHERE	AccountID=5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4                   
UPDATE GroupAccount 
SET	AccountID=5
WHERE GroupID=4;                    
