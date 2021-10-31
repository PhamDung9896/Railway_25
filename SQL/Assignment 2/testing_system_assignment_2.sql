DROP DATABASE IF EXISTS testing_system_assignment_2;
CREATE DATABASE testing_system_assignment_2;
USE testing_system_assignment_2;
-- tai sao chay chung thi ok ma chay rieng thi bao loi????--
-- Giua cac truong voi nhau nen giong nhau--
-- Neu ko can thi co the bo UNSINGED--
								
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
			AccountID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			Email				VARCHAR(50) UNIQUE NOT NULL,
			Username			VARCHAR(20) UNIQUE NOT NULL CHECK(length(Username)>=3) ,
			FullName			NVARCHAR(30) NOT NULL,
			DepartmentID		TINYINT UNSIGNED DEFAULT 1, -- khi nhan vien moi vao cty chua dc phan vao phong ban nao thi se dc vao phong ban so 1
			PositionID			TINYINT UNSIGNED DEFAULT 1, -- tuong tu nhu DepartmentID
			CreateDate			DATETIME DEFAULT NOW() -- mac dinh la thoi diem ngay luc du lieu dc nhap vao va chay cau lenh
);

-- Tao Table 4: Group
CREATE TABLE `Group`(
			GroupID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			GroupName			VARCHAR(30) UNIQUE NOT NULL,
			CreatorID			TINYINT UNSIGNED NOT NULL DEFAULT 1,
			CreateDate			DATETIME DEFAULT NOW()
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
			TypeName		ENUM('ESSAY','MULTIPLE_CHOICE') NOT NULL DEFAULT 'ESSAY'
);

-- Tao Table 7: CategoryQuestion
CREATE TABLE CategoryQuestion(
			CategoryID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			CategoryName	VARCHAR(50) UNIQUE NOT NULL CHECK(length(CategoryName)>=1)
);

-- Tao Table 8: Question
CREATE TABLE Question(
			QuestionID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			Content			VARCHAR(150) UNIQUE NOT NULL CHECK(length(Content)>=5),
			CategoryID		TINYINT UNSIGNED NOT NULL DEFAULT 1,
			TypeID			TINYINT UNSIGNED NOT NULL DEFAULT 1, 
			CreatorID		TINYINT UNSIGNED NOT NULL DEFAULT 1,
			CreateDate		DATETIME DEFAULT NOW(),
            FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
            FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID)
);


-- Tao Table 11: ExamQuestion
CREATE TABLE ExamQuestion(
			ExamID			TINYINT UNSIGNED NOT NULL DEFAULT 1,
			QuestionID		TINYINT UNSIGNED NOT NULL,
            FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
            FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);
-- Tao Table 9: Answer
CREATE TABLE Answer(
			AnswerID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			Content			VARCHAR(150) UNIQUE NOT NULL CHECK(length(Content)>=2),
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
-- testing_system_assignment_3--
-- Question 1: Thêm ít nhất 10 record vào mỗi table
INSERT INTO Department(DepartmentName)
VALUES				('S1'),
					('S2'),
					('S3'),
                    ('S4'),
                    ('S5'),
                    ('S6'),
                    ('S7'),
                    ('S8'),
                    ('S9'),
                    ('S10'),
                    ('S11'),
                    ('S12'),
                    ('S13'),
                    ('S14'),
                    ('S15');
                    
INSERT INTO `Position`(PositionName)
VALUES				('Software Engineer'),
					('Computer Programmer'),
                    ('Computer System Analysist'),
                    ('Web Developers'),
                    ('Software Testers'),
                    ('Database Administrator'),
                    ('Computer Network Architects'),
                    ('Quality Assurance Engineers'),
                    ('Front End Developer'),
                    ('Data Quality Manager'),
                    ('Help Desk Specialist'),
                    ('IT Support Manager'),
                    ('Java Developer'),
                    ('Information System Security Staff'),
                    ('Web Desinger');
                    

				
INSERT INTO `Account`(Email,Username,FullName,DepartmentID,PositionID,CreateDate)
VALUES				('LETHUANDUC@gmail.com','LeDuc','LeThuanDuc',1,3,'2019/03/12'),
					('VOHOHONGLOAN@gmail.com','VoLoan','VoHoHongLoan',2,2,'2018/05/12'),
                    ('NGUYENNGOCHUY@gmail.com','NguyenHuy','NguyenNgocHuy',3,1,'2019/12/09'),
                    ('VOKHOIHONGNHUNG@gmail.com','VoNhung','VoKhoiHongNhung',1,3,'2017/01/30'),
                    ('DANGHONHATTHACH@gmail.com','DangThach','DangHoNhatThach',1,1,'2019/12/03'),
                    ('VOVANTHANG@gmail.com','VoThang','VoVanThang',2,3,'2020/01/01'),
                    ('HOANGMINHTIEN@gmail.com','HoangTien','HoangMinhTien',3,1,'2019/07/02'),
                    ('DANGHOAIAN@gmail.com','DangAn','DangHoaiAn',3,4,'2019/03/16'),
                    ('BUITHIHIENNA@gmail.com','BuiNa','BuiThiHienNa',4,2,'2019/08/09'),
                    ('LEPHANMINHQUAN@gmail.com','LeQuan','LePhanMinhQuan',4,1,'2019/09/25'),
                    ('PHAMTHINGOCTRANG@gmail.com','PhamTrang','PhamThiNgocTrang',5,1,'2019/05/05'),
                    ('VANTHUTRUNG@gmail.com','VanTrung','VanThuTrung',3,4,'2019/10/02'),
                    ('DINHTHANHTUONGVY@gmail.com','DinhVy','DinhThanhTuongVy',3,2,'2019/11/02'),
                    ('PHANTHAIBACH@gmail.com','PhanBach','PhanThaibach',4,1,'2019/03/30'),
                    ('LEHOANGBINH@gmail.com','LeBinh','LeHoangBinh',4,3,'2019/05/02');
                    


INSERT INTO  `Group`(GroupName,CreatorID,CreateDate)
VALUES				('A',1,'2019/03/12'),
					('B',3,'2018/05/12'),
                    ('C',2,'2019/12/09'),
					('D',4,'2017/01/30'),
                    ('E',5,'2019/12/03'),
                    ('F',4,'2020/01/01'),
					('J',2,'2019/07/02'),
                    ('K',3,'2019/03/16'),
                    ('L',2,'2019/08/09'),
                    ('M',5,'2019/09/25'),
                    ('N',6,'2019/05/05'),
                    ('O',2,'2019/10/02'),
                    ('S',3,'2019/11/02'),
                    ('G',2,'2019/03/30'),
                    ('W',1,'2019/05/02');


INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES				(1,2,'2020/12/03'),
					(2,3,'2019/12/30'),
					(3,4,'2019/11/22'),
					(4,5,'2020/05/12'),
					(5,6,'2020/03/25'),
                    (6,7,'2020/12/03'),
                    (7,1,'2020/12/07'),
                    (7,2,'2020/12/08'),
                    (3,5,'2020/12/07'),
                    (1,5,'2019/10/03'),
                    (6,2,'2020/11/03'),
                    (2,4,'2020/10/03'),
                    (2,1,'2019/01/03'),
                    (3,2,'2020/12/03'),
                    (1,6,'2020/12/01');

                   


INSERT INTO TypeQuestion(TypeName)
VALUES				('ESSAY'),
					('MULTIPLE_CHOICE'),
					('MULTIPLE_CHOICE'),
					('ESSAY'),
					('MULTIPLE_CHOICE'),
                    ('ESSAY'),
                    ('ESSAY'),
                    ('ESSAY'),
                    ('MULTIPLE_CHOICE'),
                    ('MULTIPLE_CHOICE'),
                    ('ESSAY'),
                    ('ESSAY'),
                    ('ESSAY'),
                    ('MULTIPLE_CHOICE'),
                    ('ESSAY');


INSERT INTO  CategoryQuestion(CategoryName)
VALUES				('Java'),
					('.NET'),
					('SQL'),
					('Postman'),
					('Ruby'),
                    ('Python'),
                    ('PHP'),
                    ('Swift'),
                    ('C#'),
                    ('Objective-C'),
                    ('C++'),
                    ('C'),
                    ('Pascal'),
                    ('JavaScript'),
                    ('HTML');
                    
INSERT INTO  Question(Content,CreateDate)
VALUES				('Java la gi','2020/12/01'),
					('Tai sao Java lai duoc ua chuong','2019/02/01'),
                    ('Su khac nhau giua .NET va Java','2019/03/01'),
                    ('Dung SQL de lam gi','2019/05/12'),
                    ('Su khac nhau giua SQl va Excel','2019/12/25'),
                    ('1byte bang bao nhieu bit','2020/12/01'),
                    ('SQL la gi','2020/11/01'),
                    ('Tai sao nen dung SOL','2019/12/01'),
                    ('su khac nhau giua SQL va Ruby','2020/12/21'),
                    ('khi nao dung Java','2019/02/01'),
                    ('C++ la gi','2019/12/03'),
                    ('Ruby la gi','2020/10/01'),
                    ('Python la gi','2019/12/01'),
                    ('.NET la gi','2020/09/01'),
                    ('C# la gi','2020/08/01');


INSERT INTO Answer(Content,QuestionID,isCorrect)
VALUES				('11',1,'TRUE'),
					('21',3,'TRUE'),
                    ('31',2,'FALSE'),
                    ('42',5,'FALSE'),
                    ('52',6,'FALSE'),
                    ('62',7,'TRUE'),
                    ('74',8,'TRUE'),
                    ('84',11,'FALSE'),
                    ('94',10,'TRUE'),
                    ('10',12,'FALSE'),
                    ('19',13,'TRUE'),
                    ('12',14,'TRUE'),
                    ('13',1,'FALSE'),
                    ('14',2,'TRUE'),
                    ('15',3,'TRUE');


INSERT INTO Exam(`Code`,Title,CategoryID,CreatorID,Duration)
VALUES				('FE1','AVG',2,'2','45'),	
					('FE2','BINARY',3,'3','90'),
					('FE3','CASE','1',4,'30'),
					('FE4','DEFAULT',1,'5','45'),
					('FE5','EXISTS',2,'4','90'),
                    ('FE6','fresher',3,'2','45'),
                    ('FE7','GROUPING',4,'1','45'),
                    ('FE8','JSON_ARRAYAGG',5,'2','45'),
                    ('FE9','LAG',6,'3','90'),
                    ('FE10','RANK',7,'2','45'),
                    ('FE11','TIMESTAMP',4,'1','30'),
                    ('FE22','TRUE','5',4,'45'),
                    ('FE13','PERCENT_RANK','2',3,'90'),
                    ('FE14','CONVERT','2',6,'45'),
                    ('FE15','STDDEV','1',7,'45');


INSERT INTO ExamQuestion(ExamID,QuestionID)
VALUES				('2','3'),
					('3','3'),
					('4','4'),
					('4','1'),
					('5','2'),
                    ('2','3'),
                    ('2','3'),
                    ('2','4'),
                    ('2','4'),
                    ('5','3'),
                    ('5','2'),
                    ('2','1'),
                    ('3','3'),
                    ('4','3'),
                    ('2','3');














































































