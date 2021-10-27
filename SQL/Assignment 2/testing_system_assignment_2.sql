DROP DATABASE IF EXISTS testing_system_assignment_1;
CREATE DATABASE testing_system_assignment_1;
USE testing_system_assignment_1;

-- tai sao chay chung thi ok ma chay rieng thi bao loi????--
								
												-- ***** --
-- Question 1: Tối ưu lại assignment trước
-- Question 2: Thêm các constraint vào assignment trước

-- Tao Table 1:Department
CREATE TABLE Department(
			DepartmentID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			DepartmentName		VARCHAR(50) UNIQUE NOT NULL CHECK(length(DepartmentName)>=2)
);

-- Tao Table 2: Position
CREATE TABLE `Position`(
			PositionID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			PositionName		VARCHAR(50) UNIQUE NOT NULL CHECK(length(PositionName)>=2)
);

-- Tao Table 3: Account
CREATE TABLE `Account`(
			AccountID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			Email			VARCHAR(50) UNIQUE NOT NULL,
			Username		VARCHAR(20) UNIQUE NOT NULL CHECK(length(Username)>=6) ,
			FullName		NVARCHAR(30) NOT NULL,
			DepartmentID	TINYINT UNSIGNED DEFAULT 1, -- khi nhan vien moi vao cty chua dc phan vao phong ban nao thi se dc vao phong ban so 1
			PositionID		TINYINT UNSIGNED DEFAULT 1, -- tuong tu nhu DepartmentID
			CreateDate		DATETIME DEFAULT NOW() -- mac dinh la thoi diem ngay luc du lieu dc nhap vao va chay cau lenh
);

-- Tao Table 4: Group
CREATE TABLE `Group`(
			GroupID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			GroupName		VARCHAR(30) UNIQUE NOT NULL,
			CreatorID		TINYINT UNSIGNED NOT NULL DEFAULT 1,
			CreateDate		DATETIME DEFAULT NOW()
);

-- Tao Table 5: GroupAccount
CREATE TABLE GroupAccount(
			GroupID			TINYINT UNSIGNED NOT NULL,
			AccountID		TINYINT UNSIGNED NOT NULL,
			JoinDate		DATETIME DEFAULT NOW(),
            PRIMARY KEY (GroupID,AccountID),
            FOREIGN KEY (GroupID) REFERENCES `group`(GroupID),
			FOREIGN KEY (AccountID) REFERENCES `account`(AccountID)
);

-- Tao Table 6: TypeQuestion
CREATE TABLE TypeQuestion(
			TypeID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			TypeName		ENUM('ESSAY','MULTIPLE-CHOICE') NOT NULL DEFAULT 'ESSAY'
);

-- Tao Table 7: CategoryQuestion
CREATE TABLE CategoryQuestion(
			CategoryID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			CategoryName	VARCHAR(50) UNIQUE NOT NULL CHECK(length(CategoryName)>=3)
);

-- Tao Table 8: Question
CREATE TABLE Question(
			QuestionID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			Content			VARCHAR(150) UNIQUE NOT NULL CHECK(length(Content)>=10),
			CategoryID		TINYINT UNSIGNED NOT NULL DEFAULT 1,
			TypeID			TINYINT UNSIGNED NOT NULL DEFAULT 1, -- tao sao dat chu ko dc???
			CreatorID		TINYINT UNSIGNED NOT NULL DEFAULT 1,
			CreateDate		DATETIME DEFAULT NOW(),
            FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
            FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID)
);

-- Tao Table 9: Answer
CREATE TABLE Answer(
			AnswerID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			Content			VARCHAR(150) UNIQUE NOT NULL CHECK(length(Content)>=3),
			QuestionID		TINYINT UNSIGNED NOT NULL,
			isCorrect		ENUM('TRUE','FALSE') NOT NULL,
            FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

-- Tao Table 10: Exam
CREATE TABLE Exam(
			ExamID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			`Code`			VARCHAR(10) UNIQUE NOT NULL,
			Title			VARCHAR(150) UNIQUE NOT NULL ,
			CategoryID		TINYINT UNSIGNED NOT NULL,
			Duration		TINYINT UNSIGNED NOT NULL CHECK(Duration>=15 AND Duration<=90),
			CreatorID		TINYINT UNSIGNED NOT NULL,
			CreateDate		DATETIME DEFAULT NOW(),
            FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID)
);

-- Tao Table 11: ExamQuestion
CREATE TABLE ExamQuestion(
			ExamID			TINYINT UNSIGNED NOT NULL DEFAULT 1,
			QuestionID		TINYINT UNSIGNED NOT NULL,
            FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
            FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

													-- ***** --
-- Question 3: Chuẩn bị data cho bài 3: Insert data vào 11 table, mỗi table có ít nhất 5 records
INSERT INTO Department(DepartmentID,DepartmentName)
VALUES				('1','A1'),
					('2','A2'),
                    ('3','A3'),
                    ('4','A4'),
                    ('5','A5');
                    
INSERT INTO `Position`(PositionID,PositionName)
VALUES				('1','Software_Engineer'),
					('2','Computer_Programmer'),
                    ('3','Computer_System_Analysist'),
                    ('4','Web_Developers'),
                    ('5','Software_Testers');

				
INSERT INTO `Account`(AccountID,Emai,Username,FullName,DepartmentID,PositionID,CreateDate)
VALUES				('1','LETHUANDUC@gmail.com','LeDuc','LeThuanDuc','1','1','2019/03/02'),
					('2','VOHOHONGLOAN@gmail.com','VoLoan','VoHoHongLoan','1','5','2018/05/12'),
                    ('3','NGUYENNGOCHUY@gmail.com','NguyenHuy','NguyenNgocHuy','3','4','2019/12/09'),
                    ('4','VOKHOIHONGNHUNG@gmail.com','VoNhung','VoKhoiHongNhung','3','3','2017/01/30'),
                    ('5','DANGHONHATTHACH@gmail.com','DangThach','DangHoNhatThach','2','2','2019/12/03'),
                    ('6','VOVANTHANG@gmail.com','VoThang','VoVanThang','4','3','2020/01/01');


INSERT INTO  `Group`(GroupID,GroupName,CreatorID,CreateDate)
VALUES				('1','B1','1','2019/05/13'),
					('2','B2','3','2020/01/02'),
                    ('3','B3','5','2019/12/15'),
                    ('4','B4','7','2019/12/9'),
                    ('5','B5','9','2019/11/31');


INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES				('1','VIT1','2020/12/03'),
					('2','VIT2','2019/12/30'),
					('3','VIT3','2019/11/22'),
					('4','VIT4','2020/05/12'),
					('5','VIT5','2020/03/25');


INSERT INTO TypeQuestion(TypeID,TypeName)
VALUES				('1','ESSAY'),
					('2','MULTIPLE_CHOICE'),
					('3','MULTIPLE_CHOICE'),
					('4','ESSAY'),
					('5','MULTIPLE_CHOICE');


INSERT INTO  CategoryQuestion(CategoryID,CategoryName)
VALUES				('1','Java'),
					('2','.NET'),
					('3','SQL'),
					('4','Postman'),
					('5','Ruby');
                    
INSERT INTO  Question(QuestionID,Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES				('1','Java la gi','2','2','1','2020/12/01'),
					('2','Tai sao Java lai duoc ua chuong','1','4','5','2019/02/01'),
                    ('3','Su khac nhau giua .NET va Java','3','4','5','2019/03/01'),
                    ('4','Dung SQL de lam gi','6','5','4','2019/05/12'),
                    ('5','Su khac nhau giua SQl va Excel','3','3','4','2019/12/25');


INSERT INTO Answer(AnswerID,QuestionID,isCorrect)
VALUES				('1','2','TRUE'),
					('2','3','TRUE'),
                    ('3','4','FALSE'),
                    ('4','5','FALSE'),
                    ('5','1','FALSE');


INSERT INTO Exam(ExamID,`Code`,CategoryID,Duration)
VALUES				('1','FE1','2','45'),	
					('2','FE2','2','90'),
					('3','FE1','3','30'),
					('4','FE2','4','45'),
					('5','FE2','5','90');


INSERT INTO ExamQuestion(ExamID,QuestionID)
VALUES				('2','3'),
					('3','3'),
					('4','4'),
					('4','1'),
					('5','2');















































































