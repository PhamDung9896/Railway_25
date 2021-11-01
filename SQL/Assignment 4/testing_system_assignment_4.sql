DROP DATABASE IF EXISTS testing_system_assignment_4;
CREATE DATABASE testing_system_assignment_4;
USE testing_system_assignment_2;

-- Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT	A.FullName, A.Email, D.DepartmentName
FROM	`Account` AS A
JOIN	Department AS D ON A.DepartmentID=D.DepartmentID;	

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010->2019/03/12 
SELECT *
FROM	`Account`
WHERE	CreateDate<'2019/03/12';

-- Question 3: Viết lệnh để lấy ra tất cả các developer-> Web Developers
SELECT A.FullName,P.PositionName
FROM	`Account` AS A
INNER JOIN	`Position` AS P ON A.PositionID=P.PositionID
WHERE	PositionName='Web Developers';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT	D.DepartmentName,
COUNT(A.DepartmentID) AS So_luong_phong_ban
FROM `Account`AS A
INNER JOIN	Department AS D ON A.DepartmentID=D.DepartmentID
GROUP BY	A.DepartmentID
HAVING		COUNT(A.DepartmentID)>3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT		E.QuestionID, Q.Content
FROM		EXamquestion AS E
INNER JOIN	Question AS Q ON Q.QuestionID=E.QuestionID
GROUP BY	E.QuestionID
HAVING		COUNT(E.QuestionID)= (SELECT MAX(So_luong) AS Cau_hoi_duoc_dung_nhieu_nhat 
								  FROM (SELECT COUNT(E.QuestionID) AS So_luong 
										FROM Examquestion AS E
										GROUP BY E.QuestionID) AS So_luong_cau_hoi_duoc_dung_nhieu_nhat);
-- select so luong cau hoi=>cau nau dc dung nhieu nhat=> ghep 2 lenh nho nay vao chung voi lenh lon
-- tai sao dat ten roi nhung luc truy xuat lai khong ra???


-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question -- ????
SELECT A.CategoryID, A.CategoryName, 
count(Q.CategoryID) AS So_luong
FROM CategoryQuestion AS A
LEFT JOIN Question AS Q ON A.CategoryID = Q.CategoryID
GROUP BY Q.CategoryID; 

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT Q.QuestionID, Q.Content , 
count(EQ.QuestionID) 
FROM ExamQuestion EQ
RIGHT JOIN Question Q ON Q.QuestionID = EQ.QuestionID
GROUP BY Q.QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.QuestionID, Q.Content, 
count(A.QuestionID) AS So_luong_cau_hoi
FROM Answer A
INNER JOIN Question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(So_luong_cau_hoi) = (SELECT max(Dem_so_cau_hoi ) FROM(SELECT count(B.QuestionID) AS Dem_so_cau_hoi 
														 FROM Answer B
														 GROUP BY B.QuestionID) AS Dem_so_cau_tra_loi);

-- Question 9: Thống kê số lượng account trong mỗi group 
SELECT G.GroupID, COUNT(GA.AccountID) AS 'SO LUONG'
FROM GroupAccount GA
JOIN `Group` G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
ORDER BY G.GroupID ASC;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT P.PositionID, P.PositionName, count( A.PositionID) AS So_Luong FROM account A
INNER JOIN `position` P ON A.PositionID = P.PositionID
GROUP BY A.PositionID
HAVING count(So_Luong)= (SELECT MIN(Ma_chuc_vu_co_it_nguoi_nhat ) FROM(SELECT count(B.PositionID) AS Ma_chuc_vu_co_it_nguoi_nhat 
												   FROM `Account` AS B
												   GROUP BY B.PositionID) AS Chuc_vu_co_it_nguoi_nhat);

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT D.DepartmentID,D.DepartmentName, P.PositionName, count(P.PositionName) 
FROM `Account` AS A
INNER JOIN Department AS D ON A.DepartmentID = D.DepartmentID
INNER JOIN `Position` AS P ON A.PositionID = P.PositionID
GROUP BY D.DepartmentID, P.PositionID;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, … ???
SELECT Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS Type_of_Answer, ANS.Content FROM Question Q
INNER JOIN Categoryquestion AS CQ ON Q.CategoryID = CQ.CategoryID
INNER JOIN TypeQuestion TQ ON Q.TypeID = TQ.TypeID
INNER JOIN `account` A ON A.AccountID = Q.CreatorID
INNER JOIN Answer AS ANS ON Q.QuestionID = ANS.QuestionID
ORDER BY Q.QuestionID ASC;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm -- ???
SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.TypeID) AS So_Luong 
FROM Question AS Q
RIGHT JOIN Typequestion TQ ON Q.TypeID = TQ.TypeID
GROUP BY Q.TypeID;

-- Question 14:Lấy ra group không có account nào
SELECT * FROM `Group` G
LEFT JOIN GroupAccount GA ON G.GroupID = GA.GroupID
WHERE GA.AccountID IS NULL;

-- Question 15: Lấy ra group không có account nào
SELECT *
FROM `Group`
WHERE GroupID NOT IN (SELECT GroupID FROM GroupAccount);
-- OR --
SELECT * FROM GroupAccount GA
RIGHT JOIN `Group` G ON GA.GroupID = G.GroupID
WHERE GA.AccountID IS NULL;


-- Question 16: Lấy ra question không có answer nào
SELECT *
FROM Question
WHERE QuestionID NOT IN (SELECT QuestionID From Answer);
-- OR--
SELECT Q.QuestionID 
FROM Answer AS A
RIGHT JOIN Question AS Q on A.QuestionID = Q.QuestionID
WHERE A.AnswerID IS NULL;

-- Exercise 2: Union
-- Question 17: 
-- a) Lấy các account thuộc nhóm thứ 1
SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1
UNION
SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;


-- Question 18: 
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT G.GroupName, COUNT(GA.GroupID) AS So_Luong
FROM GroupAccount AS GA
JOIN `Group` AS G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
HAVING COUNT(GA.GroupID) >= 5;



-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT G.GroupName, COUNT(GA.GroupID) AS SL
FROM GroupAccount GA
JOIN `Group` G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
HAVING COUNT(GA.GroupID) <= 7;


-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT G.GroupName, COUNT(GA.GroupID) AS SL
FROM GroupAccount GA
JOIN `Group` AS G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
HAVING COUNT(GA.GroupID) >= 5
UNION ALL
SELECT G.GroupName, COUNT(GA.GroupID) AS So_Luong
FROM GroupAccount AS GA
JOIN `Group` AS G ON GA.GroupID = G.GroupID
GROUP BY G.GroupID
HAVING COUNT(ga.GroupID) <= 7;
















