/* Lenh xoa Database */
DROP DATABASE IF EXISTS `Testing_System_1`;
/* Lenh tao Database */
CREATE DATABASE IF NOT EXISTS `Testing_System_1`;
/* Lenh su dung Database */
USE `Testing_System_1`;


/*------------------- Create table ----------------------- */

/* Lenh xoa bang */
DROP TABLE IF EXISTS `Department`;
/* Len tao bang va cac cot du lieu cua bang--*/
CREATE TABLE `Department`
(
    `DepartmentID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `DepartmentName` VARCHAR(50) NOT NULL UNIQUE KEY
);
Select * From `Department`;

DROP TABLE IF EXISTS `Position`;
CREATE TABLE IF NOT EXISTS `Position`
(
    `PositionID`   TINYINT UNSIGNED AUTO_INCREMENT,
    `PositionName` ENUM ('Dev1', 'Dev2', 'Test', 'Scrum Master', 'PM'),
    CONSTRAINT pk_1 PRIMARY KEY (PositionID)
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE IF NOT EXISTS `Account`
(
    `AccountID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Email`        VARCHAR(100) UNIQUE,
    `Username`     VARCHAR(50) NOT NULL,
    `Fullname`     VARCHAR(50),
    `DepartmentID` TINYINT UNSIGNED,
    `PossitionID`  TINYINT UNSIGNED,
    `CreateDate`   DATETIME ,
    CONSTRAINT fk_dp_id FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_ps_id FOREIGN KEY (`PossitionID`) REFERENCES `Position` (`PositionID`) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE IF NOT EXISTS `Group`
(
    `GroupID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `GroupName`  VARCHAR(50) NOT NULL,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME
);

DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE IF NOT EXISTS `GroupAccount`
(
    `GroupID`   MEDIUMINT,
    `AccountID` MEDIUMINT,
    `JoinDate`  DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE IF NOT EXISTS `TypeQuestion`
(
    `TypeID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `TypeName` VARCHAR(50)
);

DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE IF NOT EXISTS `CategoryQuestion`
(
    `CategoryID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')
);

DROP TABLE IF EXISTS `Question`;
CREATE TABLE IF NOT EXISTS `Question`
(
    `QuestionID` TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `CategoryID` TINYINT UNSIGNED,
    `TypeID`     TINYINT UNSIGNED,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME ,
    CONSTRAINT fk_q1 FOREIGN KEY (`CreatorID`) REFERENCES `Account` (`AccountID`) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_q2 FOREIGN KEY (`CategoryID`) REFERENCES `CategoryQuestion` (`CategoryID`) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_q3 FOREIGN KEY (`TypeID`) REFERENCES `TypeQuestion` (`TypeID`) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `Answer`;
CREATE TABLE IF NOT EXISTS `Answer`
(
    `AnswerID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `QuestionID` TINYINT UNSIGNED,
    `isCorrect`  BIT, 
    CONSTRAINT fk_qid FOREIGN KEY (`QuestionID`) REFERENCES `Question` (`QuestionID`) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE IF NOT EXISTS `Exam`
(
    `ExamID`     TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code`       VARCHAR(20) NOT NULL,
    `Title`      VARCHAR(50) NOT NULL,
    `CategoryID` TINYINT UNSIGNED,
    `Duration`   TINYINT,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME ,
    CONSTRAINT fk_ex_1 FOREIGN KEY (CreatorID) REFERENCES Account (AccountID) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_ex_2 FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID) ON UPDATE CASCADE ON DELETE SET NULL
);


DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE IF NOT EXISTS `ExamQuestion`
(
    `ExamID`     TINYINT UNSIGNED,
    `QuestionID` TINYINT UNSIGNED,
    CONSTRAINT fk_eq1 FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
    CONSTRAINT fk_eq2 FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);


/* ---------------------- INSERT DATA ---------------------------- */
/* INSERT DATA bang Department */
INSERT INTO `Department`(`DepartmentName`)
VALUES ('Phong Ky Thuat 1'),
       ('Phong Ky Thuat 2'),
       ('Phong Dev 1'),
       ('Phong Dev 2'),
       ('Phong Sale'),
       ('Phong Marketing'),
       ('Phong Giam Doc'),
       ('Phong Tai Chinh'),
       ('Phong Cho Viec');

/* Lenh sua bang `Position` sua kieu du lieu cot `PositionName` */
ALTER TABLE `Position`
    MODIFY COLUMN `PositionName` ENUM ('Dev1', 'Dev2', 'PM', 'Leader', 'Scrum Master' , 'Test');
/* INSERT DATA bang Position */
INSERT INTO `Position`(`PositionName`)
VALUES ('Dev1'),
       ('Dev2'),
       ('Test'),
       ('PM'),
       ('Leader'),
       ('Scrum Master');

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `Account`
    DROP CONSTRAINT `fk_dp_id`,
    DROP CONSTRAINT `fk_ps_id`;
/* INSERT DATA bang Account */
INSERT INTO `Account`(`Email`, `Username`, `Fullname`, `DepartmentID`, `PossitionID`, `CreateDate`)
VALUES ('vti_account1@vtiacademy.com', 'vti1', 'Nguyen Van Tinh', 1, 1, '2019-12-01'),
       ('vti_account2@vtiacademy.com', 'vti2', 'Trinh Hoai Linh', 1, 2, '2020-12-01'),
       ('vti_account3@vtiacademy.com', 'vti3', 'Nguyen Van Test', 1, 1, '2020-07-01'),
       ('vti_account4@vtiacademy.com', 'vti4', 'Tran Van Tinh', 1, 2, '2019-09-01'),
       ('vti_account5@vtiacademy.com', 'account5', 'Ho Van Tinh', 3, 2, '2021-07-01'),
       ('vti_account6@vtiacademy.com', 'account_vti6', 'Cao Thai Son', 3, 1, NOW()),
       ('vti_7@vtiacademy.com', 'account_vti7', 'Tam Thất Tùng', 3, 3, '2020-10-01'),
       ('vti_8@vtiacademy.com', 'account_vti8', 'Nguyen Quynh Thu', 3, 4, '2019-04-01'),
       ('vti_9@vtiacademy.com', 'account_vti9', 'Tran Kim Tuyen', 2, 1, NOW()),
       ('vti_account10@vtiacademy.com', 'account_vti10', 'Nguyen Ba Dao', 1, 5, '2019-10-01'),
       ('vti_account11@vtiacademy.com', 'account_vti11', 'Nguyen Van Binh', 1, 3, '2020-12-01'),
		('vti_account12@vtiacademy.com', 'account_vti12', 'Ho Cam Dao', 5, 2, '2020-11-08');
/* INSERT DATA bang Group */
INSERT INTO `Group`(`GroupName`, `CreatorID`, CreateDate)
VALUES ('Nhom 1', '3', '2021-04-03'),
       ('Nhom 2', '3', '2019-01-03'),
       ('Nhom 3', '2', '2020-04-03'),
       ('Nhom 4', '1', NOW()),
       ('Nhom 5', '3', '2021-06-03'),
       ('Nhom 6', '1', '2020-04-03'),
       ('Nhom 7', '5', '2021-04-03'),
       ('Nhom 8', '5', '2019-05-03'),
       ('Nhom 9', '3', '2019-01-03'),
       ('Nhom 10', '1', NOW());

/* INSERT DATA bang GroupAccount */
INSERT INTO `GroupAccount`(`GroupID`, `AccountID`, `JoinDate`)
VALUES ('1', '1', '2021-06-01'),
       ('1', '3', '2020-01-01'),
       ('1', '2', NOW()),
       ('1', '4', '2021-06-01'),
       ('2', '1', '2021-06-01'),
       ('2', '10', '2019-05-01'),
       ('5', '1', '2021-06-01'),
       ('5', '3', '2020-01-01'),
       ('5', '4', '2021-07-01'),
       ('3', '1', '2021-06-01'),
       ('9', '2', '2021-06-01'),
       ('10', '1', NOW());

/* INSERT DATA bang TypeQuestion */
INSERT INTO `TypeQuestion`(`TypeName`)
VALUES ('Trac nghiem'),
       ('Tu Luan');

/* INSERT DATA bang CategoryQuestion */
/*`CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')*/
INSERT INTO `CategoryQuestion` (`CategoryName`)
VALUES ('Java'),
       ('SQL'),
       ('HTML'),
       ('CSS '),
       ('.NET'),
       ('Python'),
       ('Ruby'),
       ('JavaScript');

/* Lenh sua bang `Question` Xoa rang buoc khoa ngoai Foreign Key */
ALTER TABLE `Question`
    DROP CONSTRAINT `fk_q1`,
    DROP CONSTRAINT `fk_q2`,
    DROP CONSTRAINT `fk_q3`;
/* INSERT DATA bang Question */
INSERT INTO `Question`(`Content`, CategoryID, TypeID, CreatorID, CreateDate)
VALUES ('Câu hỏi SQL 1', 2, 2, 1, '2021-04-01'),
       ('Câu hỏi SQL 2', 2, 2, 2, '2020-01-01'),
       ('Câu hỏi JAVA 1', 1, 1, 10, '2021-07-01'),
       ('Câu hỏi JAVA 2', 1, 2, 5, '2021-06-01'),
       ('Câu hỏi HTML 1', 3, 1, 2, NOW()),
       ('Câu hỏi HTML 2', 3, 2, 2, NOW());

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `Answer`
    DROP CONSTRAINT `fk_qid`;
/* INSERT DATA bang Answer */
INSERT INTO `Answer` (`Content`, `QuestionID`, `isCorrect`)
VALUES ('Câu trả lời 1 - question SQL 1', 1, 1),
       ('Câu trả lời 2 - question SQL 1', 1, 0),
       ('Câu trả lời 3 - question SQL 1', 1, 0),
       ('Câu trả lời 4 - question SQL 1', 1, 1),
       ('Câu trả lời 1 - question SQL 2', 2, 0),
       ('Câu trả lời 2 - question SQL 2', 2, 0),
       ('Câu trả lời 3 - question SQL 2', 2, 0),
       ('Câu trả lời 4 - question SQL 2', 2, 1),
       ('Câu trả lời 1 - question JAVA 1', 3, 0),
       ('Câu trả lời 2 - question JAVA 1', 3, 1),
       ('Câu trả lời 1 - question JAVA 2', 4, 0),
       ('Câu trả lời 2 - question JAVA 2', 4, 0),
       ('Câu trả lời 3 - question JAVA 2', 4, 0),
       ('Câu trả lời 4 - question JAVA 2', 4, 1),
       ('Câu trả lời 1 - question HTML 1', 5, 1),
       ('Câu trả lời 2 - question HTML 2', 5, 0);

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `Exam`
    DROP CONSTRAINT `fk_ex_1`;
ALTER TABLE `Exam`
    DROP CONSTRAINT `fk_ex_2`;
/* INSERT DATA bang Exam */
INSERT INTO `Exam`(`Code`, `Title`, `CategoryID`, `Duration`, `CreatorID`, `CreateDate`)
VALUES ('MS_01', 'De thi 01', 1, 90, 1, NOW()),
       ('MS_02', 'De thi 02', 1, 60, 5, NOW()),
       ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
       ('MS_04', 'De thi 04', 2, 90, 1, NOW()),
       ('MS_05', 'De thi 05', 1, 60, 2, NOW()),
       ('MS_06', 'De thi 06', 2, 90, 2, NOW()),
       ('MS_07', 'De thi 07', 1, 60, 1, NOW());

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `ExamQuestion`
    DROP CONSTRAINT `fk_eq1`,
    DROP CONSTRAINT `fk_eq2`;
/* INSERT DATA bang Examquestion */
INSERT INTO `ExamQuestion`
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 2),
       (6, 2),
       (7, 2),
       (8, 2),
       (9, 3),
       (10, 3),
       (11, 4),
       (12, 4),
       (13, 4),
       (14, 4),
       (15, 5),
       (16, 5);


-- ===================================== Bài tập ======================================


-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

## Cách 1
Drop Procedure if exists  Get_account_by_input_departmentname 
Delimiter $$
create procedure Get_account_by_input_departmentname (In ten_phong_ban varchar(50))
Begin
Select A.accountid , A.Fullname , A.Username , D.Departmentname 
From `account` A
inner join department D 
on D.DepartmentID = A.DepartmentID
where D.Departmentname = ten_phong_ban;
End$$
Delimiter ;

## Cách 2
Drop Procedure if exists Get_account_by_input_departmentid 
Delimiter $$
create procedure Get_account_by_input_departmentid (In ID_phong_ban varchar(50))
Begin
Select A.accountid , A.Fullname , A.Username , D.Departmentname 
From `account` A
inner join department D 
on D.DepartmentID = A.DepartmentID
where D.DepartmentID = ID_phong_ban;
End$$
Delimiter ;

-- Question 2: Tạo store để in ra số lượng account trong mỗi group

-- Cách 1:
Drop procedure if exists get_amount_of_account_each_group;
Delimiter $$
create procedure get_amount_of_account_each_group (IN Group_id mediumint )
Begin
Select G.GroupID , count(GA.GroupID) as 'số lượng account trong group này là'
from `group` G 
left join `groupaccount` GA
on GA.GroupID = G.GroupID
where G.GroupID = Group_id;
End$$
Delimiter ;
Call get_amount_of_account_each_group(1);

-- Cách 2:
Drop function if exists get_amount_of_account_each_group_FUNCTION;
Delimiter $$
create function get_amount_of_account_each_group_FUNCTION (Group_id mediumint ) returns INT
DETERMINISTIC
Begin
Declare v_count_account INT;
Select  count(GA.GroupID) INTO v_count_account
from `group` G 
left join `groupaccount` GA
on GA.GroupID = G.GroupID
where G.GroupID = Group_id;
return v_count_account;
End$$
Delimiter ;

Select get_amount_of_account_each_group_FUNCTION(1);



-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại

-- Cach 1
Drop Procedure if exists usp_Statistic_TypeQuestion_In_Month;
Delimiter $$
create procedure usp_Statistic_TypeQuestion_In_Month()
Begin
	Select TQ.TypeID , Q.CreateDate, count(Q.TypeID) as 'số question được tạo ra là'
	from Question Q
	left join typequestion TQ
	on Q.TypeID = TQ.TypeID
	where month(Q.CreateDate) = month(now()) and year(Q.CreateDate) = year(now())
	group by Q.TypeID;
End$$
Delimiter ;

-- Cach 2

Drop function if exists FUNC_Statistic_TypeQuestion_In_Month;
Delimiter $$
Create function FUNC_Statistic_TypeQuestion_In_Month(Type_ID tinyint) returns int
deterministic
Begin
Declare number_of_question_created int;
Select count(Q.TypeID) into number_of_question_created
	from Question Q
	left join typequestion TQ
	on Q.TypeID = TQ.TypeID
	where month(Q.CreateDate) = month(now()) and year(Q.CreateDate) = year(now()) and TQ.TypeID = Type_ID;
return number_of_question_created;
End$$
Delimiter ;


-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

DROP PROCEDURE IF EXISTS spTypeQuestionHasMaxQuestion;
DELIMITER $$
CREATE PROCEDURE spTypeQuestionHasMaxQuestion(OUT id_type_question INT)
BEGIN
Select TQ.TypeID INTO id_type_question 
from Question Q 
inner join Typequestion TQ 
group by Q.TypeID 
having  count(Q.TypeID) = (select max(checker) from
											(select Q.TypeID , count(Q.TypeID) as checker
											 from question Q Group by Q.TypeID) as maximum)
Limit 1;
END$$
DELIMITER ;


-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question


DROP PROCEDURE IF EXISTS usp_TypeQuestion_has_max_Question;
DELIMITER $$
CREATE PROCEDURE usp_TypeQuestion_has_max_Question(OUT TYPE_ID TINYINT Unsigned)
BEGIN
Select TQ.TypeID INTO TYPE_ID 
from Question Q 
inner join Typequestion TQ 
group by Q.TypeID 
having  count(Q.TypeID) = (select max(checker) from
											(select Q.TypeID , count(Q.TypeID) as checker
											 from question Q Group by Q.TypeID) as maximum);
END$$
DELIMITER ;

SET @ID = 0;
Call usp_TypeQuestion_has_max_Question(@ID);
SELECT @ID;

-- Question 6: Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào

Drop procedure if exists ups_Group_name_or_Username;
Delimiter $$
Create procedure ups_Group_name_or_Username (IN Ten_goi_y_groupname_or_username varchar(50))
begin

Select Groupname 
from `Group`
where groupname like CONCAT("%",Ten_goi_y_groupname_or_username,"%")

Union 

Select username
from `account` A
where username like CONCAT("%",Ten_goi_y_groupname_or_username,"%");

End$$
Delimiter ;



-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- 			   username sẽ giống email nhưng bỏ phần @..mail đi
-- 			   positionID: sẽ có default là developer
--  		   departmentID: sẽ được cho vào 1 phòng chờ
--             Sau đó in ra kết quả tạo thành công

## Cách 1
Drop Procedure if exists ups_insert_account;
Delimiter $$
Create Procedure ups_insert_account (In Full_name varchar(50) , IN Email_ varchar(100))
Begin
Declare account_ID INT;
SELECT AccountID INTO account_ID 
FROM `Account` 
WHERE FullName = Full_Name AND Email = Email_;

UPDATE `Account`
SET UserName = substring_index(Email_,'@', 1),
PositionID = (SELECT PositionID FROM Position WHERE PositionName LIKE 'dev1'),
departmentID = (SELECT DepartmentID FROM Department WHERE DepartmentName LIKE 'phong cho')
WHERE AccountID = account_ID;
 
IF ROW_COUNT() > 0 THEN
			Select 'You created record successfully';
Else
			Select 'You did not create record successfully';
            END IF;
End$$
Delimiter ;

Select * from `account` where fullname = 'Nguyen Van Tinh';
Select * from `account` where AccountID = 1;
-- begin work;
-- CAll ups_insert_account('Nguyen Van Tinh' , 'vti_account1@vtiacademy.com');
-- rollback;

## Cách 2
Drop Procedure if exists ups_insert_account;
Delimiter $$
Create Procedure ups_insert_account (In var_fullname varchar(50) , IN var_email varchar(100))
Begin

DECLARE v_Username VARCHAR(50) DEFAULT substring_index(var_email,'@', 1);
Declare v_PositionID TINYINT UNSIGNED Default 1;
Declare v_departmentID TINYINT UNSIGNED Default 1;
DECLARE v_Createdate DATETIME DEFAULT now();

Select PositionID INTO v_PositionID
From  `Position`
Where Positionname = 'DEV1';  

Select departmentID INTO v_departmentID
From Department
where departmentname = 'Phong Cho';

Insert INTO `account`
(email,		username,		fullname, 	  PossitionID,	  DepartmentID,		CreateDate )   Values
(var_email,	v_Username,		var_fullname, v_PositionID,	  v_departmentID,	v_Createdate);
 
IF ROW_COUNT() > 0 THEN
			Select 'You created record successfully';
Else
			Select 'You did not create record successfully';
            END IF;
End$$
Delimiter ;


CAll ups_insert_account('Nguyen Van Tinh' , 'vti_account@vtiacademy.com');

SELECT * FROM `account`;

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

Drop procedure if exists max_length_essay_content
Delimiter $$
Create procedure max_length_essay_content (IN Type_Question Enum('Tu Luan'))
Begin
Select Q.TypeID , length(Content) as 'độ dài ký tự là'
From question Q
Inner Join TypeQuestion TQ
where Q.TypeID = 2
	  and	length(Content) = (select max(characterlength) from 
													      (select Q.QuestionID , length(Content) as characterlength
													       from Question Q
                                                           where typeID = 2) as maximum)
	  and TQ.typeName = Type_Question ;
End$$
Delimiter ;

Drop procedure if exists max_length_Mulitple_Choice_Question
Delimiter $$
Create procedure max_length_Mulitple_Choice_Question (IN Type_Question Enum('Trac nghiem'))
Begin
Select Q.TypeID , length(Content) as 'độ dài ký tự là'
From question Q
Inner Join TypeQuestion TQ
where Q.TypeID = 1
	  and	length(Content) = (select max(characterlength) from 
													      (select Q.QuestionID , length(Content) as characterlength
													       from Question Q
                                                           where typeID = 1) as maximum)
	  and TQ.typeName = Type_Question ;
End$$
Delimiter ;

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID

Drop procedure if exists delete_exam_base_on_ID
Delimiter $$
Create procedure delete_exam_base_on_ID (IN Exam_ID tinyint )
Begin
Delete from exam
where ExamID = Exam_ID ;
End$$
Delimiter ;


/*begin work;
call delete_exam_base_on_ID(1);
rollback;*/

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing


Drop procedure if exists delete_exam_3_Years
Delimiter $$
Create procedure delete_exam_3_Years()
Begin
delete
from exam 
where (year(now()) - year(CreateDate)) = 3;
 End$$
 Delimiter ;



-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc


Drop Procedure if exists ups_change_department;

Delimiter $$
Create procedure ups_change_department (IN department_name varchar(50))
Begin
Declare v_departmentID INT;
Select D.DepartmentID into v_departmentID 
FROM Department D
where D.Departmentname = department_name;

Update `account` A
SET A.DepartmentID = (Select DepartmentID from department where Departmentname = 'Phong Cho Viec');

Delete 
from department D  
where D.Departmentname = department_name ;
End$$
Delimiter ;

Begin work;
Call ups_change_department('Phong Dev 1');
Rollback; 


-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
/* Cách 1*/
Drop procedure if exists Amount_Question__Created_This_Year;
Delimiter $$
Create procedure Amount_Question_Created_This_Year (IN THIS_MONTH TINYINT , OUT NUMBER_OF_QUESTION INT)
Begin
Select count(Month(CreateDate)) into NUMBER_OF_QUESTION
from Question
Where Month(CreateDate) = THIS_MONTH;
End$$
Delimiter ;

/* Cách 2*/

SET GLOBAL log_bin_trust_function_creators = 1;

drop function if exists Amount_Question_Created_This_Year_Way2;
Delimiter $$
Create function Amount_Question_Created_This_Year_Way2 (THIS_MONTH TINYINT) returns INT 
Begin
Declare NUMBER_OF_QUESTION INT;
Select count(Month(CreateDate)) into NUMBER_OF_QUESTION
from Question
Where Month(CreateDate) = THIS_MONTH;
return NUMBER_OF_QUESTION ;
End$$
Delimiter ;



