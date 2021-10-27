DROP DATABASE IF EXISTS testing_system_assignment_1;
CREATE DATABASE testing_system_assignment_1;
USE testing_system_assignment_1;

-- Tao Table 1:Department
CREATE TABLE Department(
			DepartmentID		INT,
			DepartmentName		VARCHAR(50)
);

-- Tao Table 2: Position
CREATE TABLE `Position`(
			PositionID			INT,
			PositionName		VARCHAR(50)
);

-- Tao Table 3: Account
CREATE TABLE `Account`(
			AccountID		INT,
			Email			VARCHAR(100),
			Username		VARCHAR(50),
			FullName		VARCHAR(50),
			DepartmentID	INT,
			PositionID		INT,
			CreateDate		DATETIME
);

-- Tao Table 4: Group
CREATE TABLE `Group`(
			GroupID			INT,
			GroupName		VARCHAR(50),
			CreatorID		INT,
			CreateDate		DATETIME
);

-- Tao Table 5: GroupAccount
CREATE TABLE GroupAccount(
			GroupID			INT,
			AccountID		INT,
			JoinDate		DATETIME
);

-- Tao Table 6: TypeQuestion
CREATE TABLE TypeQuestion(
			TypeID			INT,
			TypeName		ENUM('ESSAY','MULTIPLE-CHOICE')
);

-- Tao Table 7: CategoryQuestion
CREATE TABLE CategoryQuestion(
			CategoryID		INT,
			CategoryName	VARCHAR(50)
);

-- Tao Table 8: Question
CREATE TABLE Question(
			QuestionID		INT,
			Content			VARCHAR(150),
			CategoryID		INT,
			TypeID			INT,
			CreatorID		INT,
			CreateDate		DATETIME
);

-- Tao Table 9: Answer
CREATE TABLE Answer(
			AnswerID		INT,
			Content			VARCHAR(150),
			QuestionID		INT,
			isCorrect		ENUM('TRUE','FALSE')
);

-- Tao Table 10: Exam
CREATE TABLE Exam(
			ExamID			INT,
			`Code`			VARCHAR(10),
			Title			VARCHAR(150),
			CategoryID		INT,
			Duration		DATETIME,
			CreatorID		INT,
			CreateDate		DATETIME
);

-- Tao Table 11: ExamQuestion
CREATE TABLE ExamQuestion(
			ExamID			INT,
			QuestionID		INT
);
















