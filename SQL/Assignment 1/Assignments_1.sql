DROP DATABASE IF EXISTS Fresher_Training_Management;
CREATE DATABASE Fresher_Training_Management;
USE Fresher_Training_Management;

CREATE TABLE Trainee(
TraineeID			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
Full_Name			NVARCHAR(30) NOT NULL CHECK(length(Full_Name)>=5),
Birth_Date			DATE NULL,
Gender				ENUM('MALE','FEMALE','UNKNOW') NOT NULL,
ET_IQ				TINYINT CHECK(0<ET_IQ<20),
ET_Gmath			TINYINT CHECK(0<ET_Gmath<20),
ET_English			TINYINT CHECK(0<ET_English<50),
Training_Class		VARCHAR(10) NOT NULL CHECK(length(Training_Class)>3),
Evaluation_Notes	VARCHAR(30) NULL
);

